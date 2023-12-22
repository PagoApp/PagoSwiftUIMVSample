//
//  ViewControllerPresenterViewMock.swift
//  PagoUITests
//
//  Created by Gabi on 18.12.2023.
//

import Foundation
@testable import PagoUISDK

final class BaseViewControllerPresenterViewMock: ViewControllerPresenterView {
    
    let setupViewBackground: ((Bool)->())?
    
    init(setupViewBackground: @escaping (Bool) -> Void) {
        self.setupViewBackground = setupViewBackground
    }
    
    func setupViewBackground(hasEmptyScreen: Bool) {
        self.setupViewBackground?(hasEmptyScreen)
    }
}
