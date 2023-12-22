//
//  ViewControllerPresenterMock.swift
//  PagoUITests
//
//  Created by Gabi on 18.12.2023.
//

import Foundation
@testable import PagoUISDK

final class BaseViewControllerPresenterMock: ViewControllerPresenter {
    
    override func getData(completion: @escaping (Model) -> ()) {
        
    }
    
    override func getRemoteData(completion: @escaping (Model) -> ()) {
        
    }
    
    override func setupPresenters() {
        
    }
}
