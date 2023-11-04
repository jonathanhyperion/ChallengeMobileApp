//
//  UserRepositoryImpl.swift
//  ChallengeMobileApp
//

import Foundation
import Moya
import Combine

struct UserRepositoryImpl: UserRepository {
    
    private let api: MoyaProvider<UserApi>

    init(provider: MoyaProvider<UserApi>) {
        api = provider
    }
    
    func getUser() -> AnyPublisher<UserProfile, Error> {
        api.requestPublisher(.getUser)
            .map(\.data)
            .decode(type: GetUserResponse.self, decoder: JSONDecoder())
            .tryMap { response in
                
                let user = UserProfile(
                    email: response.data?.attributes?.email ?? "",
                    name: response.data?.attributes?.name ?? "",
                    avatarURL: response.data?.attributes?.avatarURL ?? ""
                )
                
                return user
            }
            .eraseToAnyPublisher()
    }
}
