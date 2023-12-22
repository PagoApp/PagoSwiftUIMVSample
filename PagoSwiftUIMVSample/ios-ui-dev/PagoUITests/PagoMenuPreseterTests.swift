//
//  PagoUISDKTests.swift
//  PagoUISDKTests
//
//  Created by Gabi on 20.11.2023.
//

import XCTest
@testable import PagoUISDK

final class PagoMenuPreseterTests: XCTestCase {

    
    private func getPresenter(type: PagoMenuType, count: Int, insets: UIEdgeInsets = UIEdgeInsets.zero) -> PagoMenuPresenter {
        let buttons = (0..<count).map({PagoMenuButtonModel(title: "Title\($0)")})
        
        let menuStyle: PagoMenuStyle = PagoMenuStyle(type: .background, insets: insets)
        
        let models = PagoMenuModel(buttons: buttons,
                                   style: menuStyle)
        let presenter = PagoMenuPresenter(model: models)
        return presenter
    }
    
    func testButtonsCountShouldReturnCorrectValueWhenCalled() throws {
        let buttonsCount = 3
        let presenter = getPresenter(type: .background, count: buttonsCount)
        
        XCTAssertEqual(presenter.buttonsCount, buttonsCount)
    }
    
    func testInsetsShouldReturnCorrectValueWhenCalled() throws {
        let buttonsCount = 3
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let presenter = getPresenter(type: .background, count: buttonsCount, insets: insets)
        XCTAssertEqual(presenter.insets, insets)
    }
    
    func testWidthShouldReturnCorrectValueWhenCalled() throws {
        let inset = CGFloat(10)
        let screenWidth = UIScreen.main.bounds.width
        let expectedWidth = screenWidth - 2*inset
        let insets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        let presenter = getPresenter(type: .background, count: 3, insets: insets)
        XCTAssertEqual(presenter.width, expectedWidth)
    }
    
    func testMenuTypeShouldReturnCorrectValueWhenCalled() throws {
        let expectedType = PagoMenuType.background
        let buttonsCount = 3
        let presenter = getPresenter(type: expectedType, count: buttonsCount)
        
        XCTAssertEqual(presenter.menuType, expectedType)
    }

}
