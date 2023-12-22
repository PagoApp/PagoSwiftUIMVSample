//
//  PagoCheckboxPresenterTests.swift
//  PagoUITests
//
//  Created by LoredanaBenedic on 28.09.2023.
//

import XCTest
@testable import PagoUISDK

class PagoCheckboxPresenterTests: XCTestCase {
	
	var presenter: PagoCheckboxPresenter!
	let selectedStateStyle = PagoCheckboxStyle.stateStyle(for: .roundedSquare, state: .selectedState)
	let deselectedStateStyle = PagoCheckboxStyle.stateStyle(for: .roundedSquare, state: .deselectedState)
	let errorStateStyle = PagoCheckboxStyle.stateStyle(for: .roundedSquare, state: .errorState)
	let disabledStateStyle = PagoCheckboxStyle.stateStyle(for: .roundedSquare, state: .disabledState)
	
	
	override func setUpWithError() throws {
		
		let checkboxStyle = PagoCheckboxStyle(selectedStateStyle: selectedStateStyle, deselectedStateStyle: deselectedStateStyle, errorStateStyle: errorStateStyle, disabledStateStyle: disabledStateStyle, imageSize: .large)
		let checkboxModel = PagoCheckboxModel(style: checkboxStyle, accessibility: PagoAccessibility(isAccessibilityElement: true, accessibilityTraits: .button, accessibilityLabel: "title"))
		presenter = PagoCheckboxPresenter(model: checkboxModel)
	}
	
	override func tearDownWithError() throws {
		
		presenter = nil
	}
	
	func testIsUserInteractionEnabledShouldUpdateViewToSelectedWhenSetToTrueAndSelectedIsTrue() throws {
		
		let expectedStateStyle = selectedStateStyle
		presenter.isSelected = true
		presenter.isUserInteractionEnabled = true
		XCTAssertTrue(presenter.stateStyle.state == expectedStateStyle.state)
	}
	
	func testIsUserInteractionEnabledShouldUpdateViewToDelectedWhenSetToTrueAndSelectedIsFalse() throws {
		
		let expectedStateStyle = deselectedStateStyle
		presenter.isSelected = false
		presenter.isUserInteractionEnabled = true
		XCTAssertTrue(presenter.stateStyle.state == expectedStateStyle.state)
	}
	
	func testIsUserInteractionEnabledShouldUpdateViewToSelectedWhenSetToFalseAndSelectedIsTrue() throws {
		
		let expectedStateStyle = disabledStateStyle
		presenter.isSelected = true
		presenter.isUserInteractionEnabled = false
		XCTAssertTrue(presenter.stateStyle.state == expectedStateStyle.state)
	}
	
	func testIsUserInteractionEnabledShouldUpdateViewToDelectedWhenSetToFalseAndSelectedIsFalse() throws {
		
		let expectedStateStyle = disabledStateStyle
		presenter.isSelected = false
		presenter.isUserInteractionEnabled = false
		XCTAssertTrue(presenter.stateStyle.state == expectedStateStyle.state)
	}
	
	func testIsUserInteractionEnabledShouldUpdateViewToErrorWhenForceErrorIsTrue() throws {
		
		let expectedStateStyle = errorStateStyle
		presenter.isSelected = false
		presenter.isUserInteractionEnabled = true
		presenter.forceError = true
		XCTAssertTrue(presenter.stateStyle.state == expectedStateStyle.state)
	}

	func testToggleSelectionShouldSetStyleToSelectedWhenDeselectedAndCalled() throws {
		
		let expectedStateStyle = selectedStateStyle
		presenter.isSelected = false
		presenter.isUserInteractionEnabled = true
		presenter.toggleSelection()
		XCTAssertTrue(presenter.stateStyle.state == expectedStateStyle.state)
	}
	
	func testToggleSelectionShouldSetStyleToDeselectedWhenSelectedAndCalled() throws {
		
		let expectedStateStyle = deselectedStateStyle
		presenter.isSelected = true
		presenter.isUserInteractionEnabled = true
		presenter.toggleSelection()
		XCTAssertTrue(presenter.stateStyle.state == expectedStateStyle.state)
	}
	
	func testUpdateSelectionShouldDeselectWhenCalledWithFalse() throws {
		
		let expectedStateStyle = deselectedStateStyle
		presenter.updateSelection(selected: false)
		XCTAssertTrue(presenter.stateStyle.state == expectedStateStyle.state)
	}
	
	func testUpdateSelectionShouldSelectWhenCalledWithTrue() throws {
		
		let expectedStateStyle = selectedStateStyle
		presenter.updateSelection(selected: true)
		XCTAssertTrue(presenter.stateStyle.state == expectedStateStyle.state)
	}
	
	func testValidateCheckboxAndForceErrorsIfAnyShouldSetStateToErrorWhenDeselectedAndCalled() {
		
		let expectedStateStyle = errorStateStyle
		presenter.isSelected = false
		presenter.validateCheckboxAndForceErrorsIfAny()
		XCTAssertTrue(presenter.stateStyle.state == expectedStateStyle.state)
	}
	
	func testValidateCheckboxAndForceErrorsIfAnyShouldSetStateToOriginalWhenSelectedAndCalled() {
		
		let expectedStateStyle = selectedStateStyle
		presenter.isSelected = true
		presenter.validateCheckboxAndForceErrorsIfAny()
		XCTAssertTrue(presenter.stateStyle.state == expectedStateStyle.state)
	}
}
