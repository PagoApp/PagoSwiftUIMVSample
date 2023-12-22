//
//  
//  PagoEmailConfirmationCoordinator.swift
//  PagoRCASDK
//
//  Created by Gabi on 19.10.2022.
//
//

import UIKit

public class PagoEmailConfirmationCoordinator: BasePushCoordinator {
    
    public var baseController: BaseViewController? {
        return controller
    }
    public var navigationController: UINavigationController
    
    private var presenter: PagoEmailConfirmationPresenter!
    private var controller: PagoEmailConfirmationViewController!
    private var handler: ((String)->())?
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.makeItFlatWhite()
    }

   
    public func start(predicate: PagoEmailConfirmationPredicate, handler: @escaping (String)->()) {
        
        self.handler = handler
        let navigationModel = PagoNavigationModel(title: predicate.screenTitle, shortTitle: predicate.screenTitle, type: .none, style: PagoNavigationStyle(textAlignment: .center, detailSize: Float(18)), handlesPop: true)
        let titleNavigationPresenter = PagoNavigationPresenter(model: navigationModel)
        presenter = PagoEmailConfirmationPresenter(navigation: titleNavigationPresenter, predicate: predicate)
        presenter.delegate = self
        controller = PagoEmailConfirmationViewController(presenter: presenter)
        navigationController.pushViewController(controller, animated: true)
    }

}

extension PagoEmailConfirmationCoordinator: PagoEmailConfirmationPresenterDelegate {
    
    public func handle(email: String) {
        
        handler?(email)
    }
    
    
    public func presenterDidStop() {
        //TODO: User did stop with iteractive gesture.
    }
    
    public func presenterWillStop(animated: Bool) {
        
        stop(animated: animated)
    }
}
