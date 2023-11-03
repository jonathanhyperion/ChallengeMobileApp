//
//  AuthApi.swift
//  ChallengeMobileApp
//

import Moya
import Foundation

enum AuthApi {
    case login(params: LoginRequest)
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
        case .login:
            return "/oauth/token"
        }
    }
    
    var method: Moya.Method {
        return .post
    }

    var task: Task {
        switch self {
        case let .login(params):
            return .requestCustomJSONEncodable(params, encoder: JSONEncoder())
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
