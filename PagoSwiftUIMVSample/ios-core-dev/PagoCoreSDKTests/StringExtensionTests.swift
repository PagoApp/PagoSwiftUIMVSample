//
//  StringExtensionTests.swift
//  PagoCoreSDKTests
//
//  Created by Cosmin Iulian on 29.11.2023.
//

import XCTest

final class StringExtensionTests: XCTestCase {
    
    func testIsNumberShouldReturnFalseWhenContentIsNotNumber() throws {
        
        XCTAssertFalse("test@mail.com".isNumber)
    }
    
    func testIsNumberShouldReturnTrueWhenContentIsNumber() throws {
        
        XCTAssertTrue("12345".isNumber)
    }
}
