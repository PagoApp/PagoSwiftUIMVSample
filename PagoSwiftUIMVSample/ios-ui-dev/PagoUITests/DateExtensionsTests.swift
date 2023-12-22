//
//  Date_ExtensionsTests.swift
//  PagoUITests
//
//  Created by LoredanaBenedic on 18.09.2022.
//

import XCTest
@testable import PagoUISDK

fileprivate struct TestCase<Input, Output> {

    let input: Input
    let output: Output
    let description: String
    let line: Int

    var message: String {
        "Line \(line): \(description)"
    }

    init(input: Input, output: Output, _ description: String = "", _ line: Int = #line) where Input == (Date.PagoDateFormat, String?) {
        self.input = input
        self.output = output
        self.description = description
        self.line = line
    }
}

class DateExtensionsTests: XCTestCase {

    let date = Date()

    override func setUpWithError() throws {
        
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        
        try super.tearDownWithError()
    }

    func testDateToStringFormatting() {

        let date: Date = Date(milliseconds: 1668243600000) // 12.11.2022 09:00 GMT / UTC
        let locale = "ro-RO"

        [
            TestCase(input: (Date.PagoDateFormat.shortDate, locale), output: "12 nov", "dd MMM"),
            TestCase(input: (Date.PagoDateFormat.normal, locale), output: "12 noiembrie", "dd MMMM"),
            TestCase(input: (Date.PagoDateFormat.shorterDate, locale), output: "12 nov", "d MMM"),
            TestCase(input: (Date.PagoDateFormat.shortDateWithYear, locale), output: "12 nov 2022", "dd MMM YYYY"),
            TestCase(input: (Date.PagoDateFormat.dateWithYear, locale), output: "12 11 2022", "dd MM YYYY"),
            TestCase(input: (Date.PagoDateFormat.dateWithMonthLettersYear, locale), output: "12 noiembrie 2022", "dd MMMM YYYY"),
            TestCase(input: (Date.PagoDateFormat.dayWithMonth, locale), output: "12 noiembrie", "d MMMM"),
            TestCase(input: (Date.PagoDateFormat.hour24Format, locale), output: "09:00", "HH:mm"),
            TestCase(input: (Date.PagoDateFormat.hour24Format, nil), output: "09:00", "HH:mm"),
            TestCase(input: (Date.PagoDateFormat.yearMonthDate, nil), output: "20221112"),
            TestCase(input: (Date.PagoDateFormat.dayMonthDateCommaSeparated, nil), output: "12 Nov, 09:00")


        ].forEach { testcase in

            let formattedDate = date.toString(format: testcase.input.0, locale: testcase.input.1)
            XCTAssertEqual(formattedDate, testcase.output, testcase.message)
        }
    }
}
