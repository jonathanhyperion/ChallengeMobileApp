//
//  UserApi.swift
//  ChallengeMobileApp
//

import Moya
import RxSwift
import Foundation

enum UserApi {
    case getUser
}

extension UserApi: TargetType {
    var baseURL: URL {
        guard let url = URL(string: K.baseUrl) else {
            fatalError("baseURL could not be configurated.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getUser:
            return "/me"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUser:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getUser:
            return .requestPlain
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: [String : String]? {
        return [
            "Content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer \(Storage.shared.getTokenAuth())",
        ]
    }
    
    var sampleData: Data {
        var data = Data()
        switch self {
        case .getUser:
            data = """
            {}
            """.dataEncoded
        }
        return data
    }
}
