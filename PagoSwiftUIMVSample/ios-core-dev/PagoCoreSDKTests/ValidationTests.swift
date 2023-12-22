//
//  ValidationTests.swift
//  PagoCoreSDKTests
//
//  Created by Bogdan Oliniuc on 22.07.2022.
//

import XCTest
import PagoCoreSDK

class ValidationTests: XCTestCase {
    
    func testIsNull() throws {
        let str: String? = nil
        let result = CommonValidations.isNullOrEmpty(str)
        
        XCTAssertTrue(result)
    }
    
    func testIsEmpty() throws {
        let str = ""
        let result = CommonValidations.isNullOrEmpty(str)
        
        XCTAssertTrue(result)
    }

    func testIsNotNullOrEmpty() throws {
        let str = "not null or empty"
        let result = CommonValidations.isNullOrEmpty(str)
        
        XCTAssertFalse(result)
    }
   
    func testPlateNumberIsValid() throws {
        let plateNumber = "BV12ABC"
        let result = plateNumber =~ ValidationPatterns.plateNumber
        
        XCTAssertTrue(result)
    }
    
    func testPlateNumberIsInvalid() throws {
        let plateNumber = "AA12ABC"
        let result = plateNumber =~ ValidationPatterns.plateNumber
        
        XCTAssertFalse(result)
    }
    
    func testChassisIdIsValid() throws {
        let chassisId = "1234567890ABCDEFG"
        let result = chassisId =~ ValidationPatterns.chassisId
        
        XCTAssertTrue(result)
    }
    
    func testChassisIdIsInvalid() throws {
        let chassisId = "1234567890ABCDO"
        let result = chassisId =~ ValidationPatterns.chassisId
        
        XCTAssertFalse(result)
    }
    
    func testValidStreeyAddressField() throws {
        
        let streetName = "Strada A."
        let result = streetName =~ ValidationPatterns.addressField
        XCTAssertTrue(result)
    }
    
    func testInvalid1StreetAddressField() throws {
        
        let streetName = " Strada A."
        let result = streetName =~ ValidationPatterns.addressField
        XCTAssertFalse(result)
    }
    
    func testInvalid2StreetAddressField() throws {
        
        let streetName = "Strada A.+"
        let result = streetName =~ ValidationPatterns.addressField
        XCTAssertFalse(result)
    }
    
    func testIdCardValidation() throws {
        let validIdCards = ["zv123456", "ZV123456", "zv1234567"]
        for idCard in validIdCards {
            XCTAssertTrue(CommonValidations.idCardIsValid(idCard))
        }
        let invalidIdCards = ["", "123", "123456", "12345678", "123456789", "12abcdef"]
        for idCard in invalidIdCards {
            XCTAssertFalse(CommonValidations.idCardIsValid(idCard))
        }
    }
    
    func testBookIdValidationShouldReturnTrueWhenValidBookId() throws {
        let correctBookIds = ["K123456", "K1234567"]
        for id in correctBookIds {
            XCTAssertTrue(CommonValidations.bookIdValid(id))
        }
    }
    
    func testBookIdValidationShouldReturnFalseWhenIvalidBookId() throws {
        let incorrectBookIds = ["K12345", "K12345678"]
        for id in incorrectBookIds {
            XCTAssertFalse(CommonValidations.bookIdValid(id))
        }
    }
}
