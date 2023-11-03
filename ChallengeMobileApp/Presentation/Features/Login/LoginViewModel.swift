//
//  LoginViewModel.swift
//  ChallengeMobileApp
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    @Published private(set) var validCredentials: Bool?
    
    private let loginUseCase: LoginUseCase
    private var cancellable = Set<AnyCancellable>()
    
    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
        login()
    }
    
    private func login() {
        loginUseCase.login(params: LoginRequest(
                grantType: "password",
                email: email,
                password: password,
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
                    if result != nil {
                        self.validCredentials = false
                    }
                }
            case .finished:
                break
            }
        }, receiveValue: { [weak self] _ in
            self?.validCredentials = true
        })
        .store(in: &cancellable)
    }
}

extension LoginViewModel {
    static func make() -> LoginViewModel {
        LoginViewModel(loginUseCase: Injector.resolve(LoginUseCase.self))
    }
}
