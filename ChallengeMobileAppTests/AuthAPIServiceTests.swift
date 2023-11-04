//
//  APIServiceTests.swift
//  ChallengeMobileAppTests
//

import XCTest
import Moya
@testable import ChallengeMobileApp

class AuthAPIServiceTests: XCTestCase {

    var provider: MoyaProvider<AuthApi>!

    override func setUp() {
        super.setUp()
        provider = MoyaProvider<AuthApi>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
    }

    override func tearDown() {
        provider = nil
        super.tearDown()
    }

    func customEndpointClosure(target: AuthApi) -> Endpoint {
        let sampleResponseClosure = { return EndpointSampleResponse.networkResponse(200, target.sampleData) }
        return Endpoint(
            url: URL(target: target).absoluteString,
            sampleResponseClosure: sampleResponseClosure,
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }

    func testLoginSuccessResponse() {
        provider.request(.login(params: LoginRequest(
            grantType: "password",
            email: "your_email@example.com",
            password: "12345678",
            clientID: "123",
            clientSecret: "123"
        ))) { result in
            switch result {
            case let .success(response):
                XCTAssertEqual(response.statusCode, 200)
                XCTAssertEqual(response.data, self.sampleData)

            case let .failure(error):
                XCTFail("❌ Unexpected error: \(error)")
            }
        }
    }

    var sampleData: Data {
        let jsonString = """
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
        """
        return jsonString.data(using: .utf8)!
    }
}
