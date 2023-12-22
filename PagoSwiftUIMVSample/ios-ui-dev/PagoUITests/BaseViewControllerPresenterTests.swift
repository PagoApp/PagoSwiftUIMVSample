//
//  BaseViewControllerPresenterTests.swift
//  PagoUITests
//
//  Created by Gabi on 18.12.2023.
//

import Foundation
import XCTest
@testable import PagoUISDK

final class ViewControllerPresenterTests: XCTestCase {

    ///Cecking that this is called: setupViewBackground(hasEmptyScreen: false)
    ///first time when the logic starts, if the presenter for the empty screen is nil and
    ///if the repository returns a model for the empty screen
    func testSetupViewBackgroundShouldBeCalledWithHasEmptyFALSEWhenEmptyScreenIsSetupFirstTimeIfEmptyScreenIsPresent() throws {
        
        /// Expectations
        let hasEmptyExpectation = false
        let hasEmptyScreenModel = true
        
        /// Mocks
        let promise = expectation(description: "Validating logic")
        let setupExpectation: (Bool)->() = { hasEmpty in
            if hasEmpty == hasEmptyExpectation {
                promise.fulfill()
            }
        }
        
        let vcMock = BaseViewControllerPresenterViewMock(setupViewBackground: setupExpectation)
        let presenter = BaseViewControllerPresenterMock(model: EmptyModel())
        presenter.setView(mView: vcMock)
        
        /// Trigger point for the test
        presenter.setupLoadingStart(from: BaseViewControllerRepositoryMock(hasEmptyScreen: hasEmptyScreenModel))
        wait(for: [promise], timeout: 1)
    }
   
    ///Cecking that this is called: setupViewBackground(hasEmptyScreen: true)
    ///every time when the willShowEmptyScreen() is called
    func testSetupViewBackgroundShouldBeCalledWithHasEmptyTRUEWhenWillShowEmptyScreenIsCalled() throws {
    
        ///Expectation
        let hasEmptyExpectation = true
        
        ///Mock
        let promise = expectation(description: "Validating logic")
        let setupExpectation: (Bool)->() = { hasEmpty in
            if hasEmpty == hasEmptyExpectation {
                promise.fulfill()
            }
        }
        
        let vcMock = BaseViewControllerPresenterViewMock(setupViewBackground: setupExpectation)
        let presenter = BaseViewControllerPresenterMock(model: EmptyModel())
        presenter.setView(mView: vcMock)
        
        ///Trigger point
        presenter.willShowEmptyScreen()
        wait(for: [promise], timeout: 1)
    }
    
    ///Cecking that this is called: setupViewBackground(hasEmptyScreen: false)
    ///every time when the willShowEmptyScreen() is called
    func testSetupViewBackgroundShouldBeCalledWithHasEmptyFALSEWhenWillHideEmptyScreenIsCalled() throws {
    
        ///Expectation
        let hasEmptyExpectation = false
        
        ///Mock
        let promise = expectation(description: "Validating logic")
        let setupExpectation: (Bool)->() = { hasEmpty in
            if hasEmpty == hasEmptyExpectation {
                promise.fulfill()
            }
        }
        
        let vcMock = BaseViewControllerPresenterViewMock(setupViewBackground: setupExpectation)
        let presenter = BaseViewControllerPresenterMock(model: EmptyModel())
        presenter.setView(mView: vcMock)
         
        ///Trigger point
        presenter.willHideEmptyScreen()
        wait(for: [promise], timeout: 1)
    }
    
}


