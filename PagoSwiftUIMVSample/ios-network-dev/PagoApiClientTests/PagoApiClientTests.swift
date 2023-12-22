//
//  PagoApiClientTests.swift
//  PagoApiClientTests
//
//  Created by Andrei Chirita on 25.05.2022.
//

import XCTest
@testable import PagoApiClient

class PagoApiClientTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //NOTE: tests cannot pass because the session from PagoApiClient cannot be created
    //       the session is created by initializing it with the tokens wich reside in Keychain -> the Keychain cannot be used in testing environment (saving into Keychain returns error -34018 = errSecMissingEntitlement)
//    func testSetupSDKIsSettingFirstAccessToken() throws {
//        let dummyKey = "token"
//        let authKey = "bearer auth key"
//        let url = "https://google.com"
//        PagoApiClientManager.setup(accessToken: dummyKey, authorizationKey: authKey, baseUrl: url)
//        XCTAssertTrue(PagoApiClientManager.shared.session.accessToken.rawValue == dummyKey)
//    }
//
//    func testSessionRawValueEqualsToken() throws {
//
//        let dummyKey = "token"
//        let authKey = "bearer auth key"
//        let url = "https://google.com"
//        PagoApiClientManager.setup(accessToken: dummyKey, authorizationKey: authKey, baseUrl: url)
//        XCTAssertTrue(PagoApiClientManager.shared.session.accessToken.rawValue == PagoApiClientManager.shared.session.accessToken.token)
//    }
//
//    func testNewTokenIsSaved() throws {
//        let dummyKey = "token"
//        let authKey = "bearer auth key"
//        let url = "https://google.com"
//        PagoApiClientManager.setup(accessToken: dummyKey, authorizationKey: authKey, baseUrl: url)
//        XCTAssertTrue(PagoApiClientManager.shared.session.accessToken.rawValue == dummyKey)
//
//        let newToken = "token new"
//        PagoApiClientManager.shared.triggerExpiredToken() {
//            XCTAssertTrue(PagoApiClientManager.shared.session.accessToken.rawValue == newToken)
//        }
//    }
    
}
