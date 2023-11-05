//
//  HomeViewModel.swift
//  ChallengeMobileApp
//

import Foundation
import Combine
import Swinject

final class HomeViewModel: ObservableObject {
    @Published var user = UserProfile.placeholders
    
    private let logoutUseCase: LogoutUseCase
    private let getProfileUseCase: GetProfileUseCase
    private var cancellable = Set<AnyCancellable>()
    
    init(
        logoutUseCase: LogoutUseCase,
        getProfileUseCase: GetProfileUseCase
    ) {
        self.logoutUseCase = logoutUseCase
        self.getProfileUseCase = getProfileUseCase
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
            getProfileUseCase: Injector.resolve(GetProfileUseCase.self)
        )
    }
}
