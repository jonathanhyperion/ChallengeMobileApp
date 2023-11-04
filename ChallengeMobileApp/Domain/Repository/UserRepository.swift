//
//  UserRepository.swift
//  ChallengeMobileApp
//

import Foundation
import Moya
import Combine

protocol UserRepository {
    func getUser() -> AnyPublisher<UserProfile, Error>
}
