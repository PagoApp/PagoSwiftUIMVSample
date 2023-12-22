//
//  
//  PagoButtonsCoordinator.swift
//  PagoUI_Sandbox
//
//  Created by LoredanaBenedic on 14.03.2023.
//
//

import PagoUISDK
import UIKit

class PagoButtonsCoordinator: BaseCoordinator {
    
    private var controller: PagoButtonsViewController!
    private let navigationController: UINavigationController
    
    private var presenter: PagoButtonsPresenter!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.makeItFlatWhite()
    }

   
    func start() {
        let navigationModel = PagoNavigationModel(title: "PagoButtons", shortTitle: "PagoButtons", type: .simple, isSnapping: true, style: PagoNavigationStyle(textAlignment: .center, detailSize: Float(18)))
        let titleNavigationPresenter = PagoNavigationPresenter(model: navigationModel)
        let predicate = PagoButtonsPredicate()
        presenter = PagoButtonsPresenter(navigation: titleNavigationPresenter, predicate: predicate)
        controller = PagoButtonsViewController(presenter: presenter)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func stop() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
    }
    
}
