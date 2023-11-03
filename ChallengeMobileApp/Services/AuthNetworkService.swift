//
//  TestNetworkService.swift
//  ChallengeMobileApp
//

import Foundation
import Moya
import Combine

protocol AuthService {
    func auth() async -> Result<Any, Error>}

struct AuthNetworkService: AuthService {
    
    private let api: MoyaProvider<AuthApi>

    init(provider: MoyaProvider<AuthApi>) {
        api = provider
    }
    
    func auth() async -> Result<Any, Error> {
        do {
            let response: Any = try await api.requestPublisher(.auth)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
