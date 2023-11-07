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
            .tryMap { result in
                if let response = result.response,
                   !(200 ... 299).contains(response.statusCode)
                {
                    let info = try JSONDecoder().decode(NetworkErrors.self, from: result.data)
                    throw self.httpError(response.statusCode, info)
                }
                return result.data
            }
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
                Storage.shared.saveCreateTokenAt(createdAt: currentTime.toString(format: "yyyy-MM-dd HH:mm:ss Z"))
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
                Storage.shared.saveCreateTokenAt(createdAt: currentTime.toString(format: "yyyy-MM-dd HH:mm:ss Z"))
                Storage.shared.saveRefreshToken(token: response.data?.attributes?.refreshToken ?? "")
                Storage.shared.saveExpiresTokenIn(expiresIn: response.data?.attributes?.expiresIn ?? 0)
                Storage.shared.saveTokenAuth(token: response.data?.attributes?.accessToken ?? "")
                
                return model
            }
            .eraseToAnyPublisher()
    }
    
    func logout(params: LogoutRequest) -> AnyPublisher<LogoutResponse, Error> {
        api.requestPublisher(.logout(params: params))
            .map(\.data)
            .decode(type: LogoutResponse.self, decoder: JSONDecoder())
            .tryMap { response in
                return response
            }
            .eraseToAnyPublisher()
    }
    
    func forgotPassword(params: ForgotPasswordRequest) -> AnyPublisher<String, Error> {
        api.requestPublisher(.forgotPassword(params: params))
            .map(\.data)
            .decode(type: ForgotPasswordResponse.self, decoder: JSONDecoder())
            .tryMap { response in
                return response.meta?.message ?? ""
            }
            .eraseToAnyPublisher()
    }
    
    private func httpError(_ statusCode: Int, _ response: NetworkErrors?) -> NetworkRequestError {
        switch statusCode {
        case 400: return .badRequest(response)
        case 401: return .unauthorized(response)
        case 403: return .forbidden(response)
        case 404: return .notFound(response)
        case 402, 405 ... 499: return .error4xx(statusCode)
        case 500: return .serverError(response)
        case 501 ... 599: return .error5xx(statusCode)
        default: return .unknownError(response)
        }
    }
}
