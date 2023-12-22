//
//  PagoAlertTest.swift
//  PagoUITests
//
//  Created by Bogdan on 10.05.2023.
//

import XCTest
@testable import PagoUISDK

final class PagoDatePickerTest: XCTestCase {
    
    func testShouldShowUTCTime() throws {
        let datePickerStyle = PagoDatePickerStyle(showLocalTime: false)
        let model = PagoDatePickerModel(style: datePickerStyle)
        let presenter = PagoDatePickerPresenter(model: model)
        XCTAssertEqual(presenter.timeZone, TimeZone(identifier: "UTC"))
    }
    
    func testShouldShowLocalTime() throws {
        let datePickerStyle = PagoDatePickerStyle(showLocalTime: true)
        let model = PagoDatePickerModel(style: datePickerStyle)
        let presenter = PagoDatePickerPresenter(model: model)
        XCTAssertNil(presenter.timeZone)
    }

}
