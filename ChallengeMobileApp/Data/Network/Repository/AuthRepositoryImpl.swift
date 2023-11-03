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
                guard let id = response.data?.id,
                      let accessToken = response.data?.attributes?.accessToken,
                      let expiresIn = response.data?.attributes?.expiresIn,
                      let refreshToken = response.data?.attributes?.refreshToken,
                      let createdAt = response.data?.attributes?.createdAt else {
                    throw NetworkRequestError.invalidResponse(
                        NetworkErrors(
                            code: 502,
                            detail: "❌ The server got an invalid response needed to handle the request."
                        )
                    )
                }
                
                Storage.shared.saveTokenAuth(token: accessToken)
                
                let model = AccessToken(
                    id: id,
                    accessToken: accessToken,
                    expiresIn: expiresIn,
                    refreshToken: refreshToken,
                    createdAt: createdAt
                )
                return model
            }
            .eraseToAnyPublisher()
    }
}
