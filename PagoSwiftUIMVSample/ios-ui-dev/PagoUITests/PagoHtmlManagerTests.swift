//
//  PagoHtmlManagerTests.swift
//  PagoUITests
//
//  Created by Cosmin Iulian on 27.09.2023.
//

import XCTest
@testable import PagoUISDK

final class PagoHtmlManagerTests: XCTestCase {
    
    func testExtractedTextsShouldReturnTextsBetweenTags() throws {
       
        let text = "<b> Dummy Text 1 </b> <b> Dummy Text 2 </b> <b> Dummy Text 3 </b>"
        let htmlManager = PagoHtmlManager(string: text, type: .bold, fontType: .bold17)
        let result = htmlManager.extractedTexts
        let expect = [" Dummy Text 1 ", " Dummy Text 2 ", " Dummy Text 3 "]
        XCTAssertEqual(result, expect)
    }
    
    func testPlaceholdersShouldReturnPlaceholdersWithTextsAndGivenFontType() throws {
       
        let text = "<b> Dummy Text 1 </b> <b> Dummy Text 2 </b> <b> Dummy Text 3 </b>"
        let htmlManager = PagoHtmlManager(string: text, type: .bold, fontType: .bold17)
        let resultedTexts = htmlManager.placeholders.map { $0.text }
        let resultedFontType = htmlManager.placeholders.first?.style.fontType?.font
        let expectedTexts = [" Dummy Text 1 ", " Dummy Text 2 ", " Dummy Text 3 "]
        let expectedFontType: UIFont? = UIFont.Pago.bold17.font
        XCTAssertEqual(resultedTexts, expectedTexts)
        XCTAssertEqual(resultedFontType, expectedFontType)
    }
    
    func testStringWithoutTagsShouldReturnTextsWithoutGivenTags() throws {
       
        let text = "<b> Dummy Text 1 </b>"
        let htmlManager = PagoHtmlManager(string: text, type: .bold, fontType: .bold17)
        let result = htmlManager.stringWithoutTags
        let expect = " Dummy Text 1 "
        XCTAssertEqual(result, expect)
    }

}
