//
//  PagoUINavigationControllerExtensionTests.swift
//  PagoUITests
//
//  Created by Bogdan on 12.07.2023.
//

import XCTest
import PagoUISDK

final class PagoUINavigationControllerExtensionTests: XCTestCase {
    
    var topController: BaseViewController!
    var firstController: BaseViewController!
    var secondController: BaseViewController!
    var navigationController: UINavigationController!
        
    override func setUpWithError() throws {
        
        topController = BaseViewController()
        firstController = BaseViewController()
        secondController = BaseViewController()
        topController.loadViewIfNeeded()
        secondController.loadViewIfNeeded()
        topController.loadViewIfNeeded()
        navigationController = UINavigationController(rootViewController: topController)
    }
    
    func testInsertionIndex() throws {
        
        XCTAssert(navigationController.insertionIndex == 0)
    }
    
    func testInsertionIndexAfterInsertion() throws {
        
        navigationController.insertControllers([firstController, secondController])
        XCTAssert(navigationController.insertionIndex == 2)
    }

    func testInsertion() throws {
        
        navigationController.insertControllers([firstController, secondController])
        //NOTE: test the insertion of the controllers
        XCTAssertEqual(navigationController.viewControllers.count, 3)
        let firstInsertedController = navigationController.viewControllers[0] as! BaseViewController
        let secondInsertedController = navigationController.viewControllers[1] as! BaseViewController
        //NOTE: test the insertion of specific controllers
        XCTAssertEqual(firstInsertedController, firstController)
        XCTAssertEqual(secondInsertedController, secondController)
        //NOTE: test the value of the title of the first inserted controller into stack
        XCTAssertEqual(firstInsertedController.navigationItem.backBarButtonItem?.title, "")
    }
    
    override func tearDownWithError() throws {
        
        topController = nil
        navigationController = nil
    }
    
}
