//
//  ForgotPasswordViewModel.swift
//  ChallengeMobileApp
//

import Foundation
import Combine

final class ForgotPasswordViewModel: ObservableObject {
    @Published var email = ""
    
    private let forgotPasswordUseCase: ForgotPasswordUseCase
    private var cancellable = Set<AnyCancellable>()
    
    init(forgotPasswordUseCase: ForgotPasswordUseCase) {
        self.forgotPasswordUseCase = forgotPasswordUseCase
    }
    
    func sendEmailForgotPassword() {
        forgotPasswordUseCase.forgotPassword(
            params: ForgotPasswordRequest(
                user: User(email: email),
                clientID: K.clientID,
                clientSecret: K.clientSecret
            )
        )
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { error in
            switch error {
            case let .failure(error):
                if let networkError = error as? NetworkRequestError {
                    let result: NetworkErrors? = networkError.associatedValue()
                    if result != nil {}
                }
                print("❌ Error \(error)")
            case .finished:
                break
            }
        }, receiveValue: { [weak self] _ in })
        .store(in: &cancellable)
    }
}

extension ForgotPasswordViewModel {
    static func make() -> ForgotPasswordViewModel {
        ForgotPasswordViewModel(forgotPasswordUseCase: Injector.resolve(ForgotPasswordUseCase.self))
    }
}
