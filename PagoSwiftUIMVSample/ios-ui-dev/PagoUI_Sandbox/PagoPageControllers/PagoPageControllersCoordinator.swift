//
//  
//  PagoPageControllersCoordinator.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 21.11.2023.
//
//

import PagoUISDK
import UIKit

internal class PagoPageControllersCoordinator: BaseCoordinator {
    
    private var controller: PagoPageControllersViewController!
    private let navigationController: UINavigationController
    
    private var presenter: PagoPageControllersPresenter!
    
    internal init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.makeItFlatWhite()
    }

   
    internal func start() {
        let navigationModel = PagoNavigationModel(title: "Pago Page Controller", shortTitle: "Pago Page Controller", type: .simple, isSnapping: true, style: PagoNavigationStyle(textAlignment: .center, detailSize: Float(18)))
        let titleNavigationPresenter = PagoNavigationPresenter(model: navigationModel)
        let predicate = PagoPageControllersPredicate()
        presenter = PagoPageControllersPresenter(navigation: titleNavigationPresenter, predicate: predicate)
        controller = PagoPageControllersViewController(presenter: presenter)
        navigationController.pushViewController(controller, animated: true)
    }
    
    internal func stop() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
    }
    
}
