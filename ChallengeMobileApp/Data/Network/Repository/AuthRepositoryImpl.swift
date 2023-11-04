//
//  AuthRepositoryImpl.swift
//  ChallengeMobileApp
//

import Foundation
import Moya
import Combine

struct AuthRepositoryImpl: AuthRepository {
    
    private let api: MoyaProvider<AuthApi>

    init(provider: MoyaProvider<AuthApi>) {
        api = provider
    }
    
    func login(params: LoginRequest) -> AnyPublisher<AccessToken, Error> {
        api.requestPublisher(.login(params: params))
            .map(\.data)
            .decode(type: LoginResponse.self, decoder: JSONDecoder())
            .tryMap { response in
                
                let model = AccessToken(
                    id: response.data?.id,
                    accessToken: response.data?.attributes?.accessToken,
                    expiresIn: response.data?.attributes?.expiresIn,
                    refreshToken: response.data?.attributes?.refreshToken,
                    createdAt: response.data?.attributes?.createdAt
                )
                
                let currentTime = Date()
                Storage.shared.saveCreateTokenAt(createdAt: currentTime.toString())
                Storage.shared.saveRefreshToken(token: response.data?.attributes?.refreshToken ?? "")
                Storage.shared.saveExpiresTokenIn(expiresIn: response.data?.attributes?.expiresIn ?? 0)
                Storage.shared.saveTokenAuth(token: response.data?.attributes?.accessToken ?? "")
                
                return model
            }
            .eraseToAnyPublisher()
    }
    
    func isUserLogged() -> Bool {
        !Storage.shared.getTokenAuth().isEmpty
    }
    
    func refeshToken(params: RefreshTokenRequest) -> AnyPublisher<AccessToken, Error> {
        api.requestPublisher(.refreshToken(params: params))
            .map(\.data)
            .decode(type: RefreshTokenResponse.self, decoder: JSONDecoder())
            .tryMap { response in
                
                let model = AccessToken(
                    id: response.data?.id,
                    accessToken: response.data?.attributes?.accessToken,
                    expiresIn: response.data?.attributes?.expiresIn,
                    refreshToken: response.data?.attributes?.refreshToken,
                    createdAt: response.data?.attributes?.createdAt
                )
                
                let currentTime = Date()
                Storage.shared.saveCreateTokenAt(createdAt: currentTime.toString())
                Storage.shared.saveRefreshToken(token: response.data?.attributes?.refreshToken ?? "")
                Storage.shared.saveExpiresTokenIn(expiresIn: response.data?.attributes?.expiresIn ?? 0)
                Storage.shared.saveTokenAuth(token: response.data?.attributes?.accessToken ?? "")
                
                return model
            }
            .eraseToAnyPublisher()
    }
}
