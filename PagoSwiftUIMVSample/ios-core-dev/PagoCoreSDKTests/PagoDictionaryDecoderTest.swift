//
//  PagoDictionaryDecoderTest.swift
//  PagoCoreSDKTests
//
//  Created by Bogdan on 04.05.2023.
//

import XCTest
import PagoCoreSDK

struct StructureDecodable: BasePagoCodable {
    
    var variableA: String
    var variableB: String
}

class PagoDictionaryDecoderTest: XCTestCase {
    
    func testDecoder() throws {
        
        let dictionary = ["variableA":"variableA", "variableB": "variableB"]
        let decodedDic: StructureDecodable? = PagoDictionaryDecoder.decode(dictionary: dictionary)
        XCTAssertNotNil(decodedDic)
    }
    
    func testDecoderForNil() throws {
        
        let dictionary = ["keyA":"", "keyB": ""]
        let decodedDic: StructureDecodable? = PagoDictionaryDecoder.decode(dictionary: dictionary)
        XCTAssertNil(decodedDic)
    }
}
