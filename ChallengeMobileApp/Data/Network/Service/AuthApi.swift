//
//  AuthApi.swift
//  ChallengeMobileApp
//

import Moya
import RxSwift
import Foundation

enum AuthApi {
    case login(params: LoginRequest)
    case refreshToken(params: RefreshTokenRequest)
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
        case .refreshToken:
            return "/oauth/token"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .refreshToken:
            return .post
        }
    }

    var task: Task {
        switch self {
        case let .login(params):
            return .requestCustomJSONEncodable(params, encoder: JSONEncoder())
        case let .refreshToken(params):
            return .requestCustomJSONEncodable(params, encoder: JSONEncoder())
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var sampleData: Data {
        var data = Data()
        switch self {
        case .login:
            data = """
            {
                "data": {
                    "id": "123",
                    "type": "token",
                    "attributes": {
                        "access_token": "123-f2i0CG6MDsf-wJE9FyYrhSGAOtxBkhYWDI",
                        "token_type": "Bearer",
                        "expires_in": 7200,
                        "refresh_token": "l27GNT0kmkPbnEaUxniXyu4cHfPyWFr00kZTX5oWKA6c",
                        "created_at": 1681974651
                    }
                }
            }
            """.dataEncoded
        case .refreshToken:
            data = """
            {
                "data": {
                    "id": "123",
                    "type": "token",
                    "attributes": {
                        "access_token": "123-f2i0CG6MDsf-wJE9FyYrhSGAOtxBkhYWDI",
                        "token_type": "Bearer",
                        "expires_in": 7200,
                        "refresh_token": "l27GNT0kmkPbnEaUxniXyu4cHfPyWFr00kZTX5oWKA6c",
                        "created_at": 1681974651
                    }
                }
            }
            """.dataEncoded
        }
        return data
    }
}
