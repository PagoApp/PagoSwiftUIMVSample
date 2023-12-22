//
//  
//  PagoMenusCoordinator.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 01.11.2023.
//
//

import PagoUISDK
import UIKit

internal class PagoMenusCoordinator: BaseCoordinator {
    
    private var controller: PagoMenusViewController!
    private let navigationController: UINavigationController
    
    private var presenter: PagoMenusPresenter!
    
    internal init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.makeItFlatWhite()
    }

   
    internal func start() {
        let navigationModel = PagoNavigationModel(title: "Detalii autovehicul", shortTitle: "Detalii autovehicul", type: .simple, isSnapping: true, style: PagoNavigationStyle(textAlignment: .center, detailSize: Float(18)))
        let titleNavigationPresenter = PagoNavigationPresenter(model: navigationModel)
        let predicate = PagoMenusPredicate()
        presenter = PagoMenusPresenter(navigation: titleNavigationPresenter, predicate: predicate)
        controller = PagoMenusViewController(presenter: presenter)
        navigationController.pushViewController(controller, animated: true)
    }
    
    internal func stop() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
    }
    
}
