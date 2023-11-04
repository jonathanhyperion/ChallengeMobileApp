//
//  AuthApi.swift
//  ChallengeMobileApp
//

import Moya
import Foundation

enum AuthApi {
    case auth
}

extension AuthApi: TargetType {
    var baseURL: URL {
        guard let url = URL(string: K.baseUrl) else {
            fatalError("baseURL could not be configurated.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .auth:
            return "/"
        }
    }
    
    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .auth:
            return .requestPlain
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
