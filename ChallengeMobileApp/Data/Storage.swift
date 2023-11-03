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
    }

    func saveTokenAuth(token: String) {
        storage?.set(token, forKey: Constants.tokenAuth)
    }

    func getTokenAuth() -> String {
        storage?.string(forKey: Constants.tokenAuth) ?? ""
    }

    func clearAll() {
        UserDefaults.standard.removePersistentDomain(forName: "user")
    }
}
