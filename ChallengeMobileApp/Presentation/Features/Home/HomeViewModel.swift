//
//  HomeViewModel.swift
//  ChallengeMobileApp
//

import Foundation
import Combine
import Swinject

final class HomeViewModel: ObservableObject {
    @Published var user: UserProfile  = UserProfile.placeholders
    @Published var surveys: [SurveyItemList] = SurveyItemList.placeholders
    @Published var currentSurveyIndex: Int = 0
    @Published var isLoading = false
    
    private let logoutUseCase: LogoutUseCase
    private let getProfileUseCase: GetProfileUseCase
    private let getSurveyUseCase: GetSurveysUseCase
    
    private var cancellable = Set<AnyCancellable>()
    
    init(
        logoutUseCase: LogoutUseCase,
        getProfileUseCase: GetProfileUseCase,
        getSurveyUseCase: GetSurveysUseCase
    ) {
        self.logoutUseCase = logoutUseCase
        self.getProfileUseCase = getProfileUseCase
        self.getSurveyUseCase = getSurveyUseCase
    }
    
    func logout() {
        logoutUseCase.logout(
            params: LogoutRequest(
                token: Storage.shared.getTokenAuth(),
                clientID: K.clientID,
                clientSecret: K.clientSecret
            )
        )
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { error in
            switch error {
            case let .failure(error):
                if let _ = error as? NetworkRequestError {}
            case .finished:
                print("Finish...")
            }
        }, receiveValue: { [weak self] _ in
            Storage.shared.clearAll()
        })
        .store(in: &cancellable)
    }
    
    func getProfile() {
        getProfileUseCase.getUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { error in
                switch error {
                case let .failure(error):
                    if let _ = error as? NetworkRequestError {}
                case .finished:
                    print("Finish...")
                }
            }, receiveValue: { [weak self] user in
                self?.user = user
            }
        )
        .store(in: &cancellable)
    }
    
    func getSurveys() {
        self.isLoading = true
        Task {
            getSurveyUseCase.getSurveys(pageNumber: 1, pageSize: 5)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { error in
                    switch error {
                    case let .failure(error):
                        if let networkError = error as? NetworkRequestError {
                            let result: NetworkErrors? = networkError.associatedValue()
                            if result != nil {}
                        }
                        self.surveys = []
                        print("❌ Error \(error)")
                    case .finished:
                        break
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self.isLoading = false
                    }
                }, receiveValue: { [weak self] surveys in
                    self?.surveys = surveys
                    print(surveys)
                })
                .store(in: &cancellable)
        }
    }
    
    func todayDate() -> String {
        let today = Date()
        let dateFormatter = today.toString(format: "EEEE, MMMM dd")
        return dateFormatter
    }
}

extension HomeViewModel {
    static func make() -> HomeViewModel {
        HomeViewModel(
            logoutUseCase: Injector.resolve(LogoutUseCase.self),
            getProfileUseCase: Injector.resolve(GetProfileUseCase.self),
            getSurveyUseCase: Injector.resolve(GetSurveysUseCase.self)
        )
    }
}
