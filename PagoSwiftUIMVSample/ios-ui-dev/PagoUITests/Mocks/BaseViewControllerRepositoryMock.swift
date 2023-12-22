//
//  BaseViewControllerPresenterMock.swift
//  PagoUITests
//
//  Created by Gabi on 18.12.2023.
//

@testable import PagoUISDK
import UIKit

final class BaseViewControllerRepositoryMock: BaseViewControllerRepository<EmptyModel, BaseViewControllerPredicateMock> {
    
    var hasEmptyScreen: Bool
    init(hasEmptyScreen: Bool) {
        self.hasEmptyScreen = hasEmptyScreen
    }
    
    override func getData(predicate: EmptyModel, completion: @escaping (BaseViewControllerPredicateMock) -> ()) {
        
    }
    
    override func getRemoteData(predicate: EmptyModel, completion: @escaping (BaseViewControllerPredicateMock) -> ()) {
        
    }
    
    override func getLocalData(predicate: EmptyModel, completion: @escaping (BaseViewControllerPredicateMock) -> ()) {
        
    }
    
    override var emptyListScreenModel: PagoEmptyListScreenModel? {
        let image = PagoImage(image: .accessibilityIllustration)
        let model = getEmptySceenModel(imageData: image, title: "", detail: "")
        return hasEmptyScreen ? model : nil
    }
}
