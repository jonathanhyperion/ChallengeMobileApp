//
//  Storage.swift
//  ChallengeMobileApp
//

import Foundation

final class Storage {
    static let shared = Storage()
    let storage = UserDefaults(suiteName: "user")

    private enum Constants {
        static let tokenAuth = "token"
        static let createdAt = "createdAt"
        static let expiresIn = "expiresIn"
        static let refreshToken = "refreshToken"
    }

    func saveTokenAuth(token: String) {
        storage?.set(token, forKey: Constants.tokenAuth)
    }

    func getTokenAuth() -> String {
        storage?.string(forKey: Constants.tokenAuth) ?? ""
    }
    
    func saveRefreshToken(token: String) {
        storage?.set(token, forKey: Constants.refreshToken)
    }

    func getRefreshToken() -> String {
        storage?.string(forKey: Constants.refreshToken) ?? ""
    }
    
    func saveCreateTokenAt(createdAt: String) {
        storage?.set(createdAt, forKey: Constants.createdAt)
    }

    func getCreateTokenAt() -> String {
        storage?.string(forKey: Constants.createdAt) ?? ""
    }
    
    func saveExpiresTokenIn(expiresIn: Int) {
        storage?.set(expiresIn, forKey: Constants.expiresIn)
    }

    func getExpiresTokenIn() -> Int {
        storage?.integer(forKey: Constants.expiresIn) ?? 0
    }
    
    func clearAll() {
        UserDefaults.standard.removePersistentDomain(forName: "user")
    }
    
    func isTokenExpired() -> Bool {
        let now = Date()
        let timeElapsed = Int(now.timeIntervalSince(getCreateTokenAt().toDate()))
        let timeElapsedInMinutes = timeElapsed / 60
        let expiredToken = getExpiresTokenIn() / 60
        let timeToWaitInMinutes = expiredToken - timeElapsedInMinutes
        
        print("Create \(getCreateTokenAt())")
        print("Now \(now.toString())")
        print("Token expiration time \(expiredToken) minutes")
        print("Time Elapsed \(timeElapsedInMinutes) minutes")
        print("Time left for token to expire \(timeToWaitInMinutes) minutes")
        
        return expiredToken > timeElapsedInMinutes
    }
}
