//
//  
//  PagoCustomComponentCoordinator.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 21.11.2023.
//
//

import PagoUISDK
import UIKit

internal class PagoCustomComponentCoordinator: BaseCoordinator {
    
    private var controller: PagoCustomComponentViewController!
    private let navigationController: UINavigationController
    
    private var presenter: PagoCustomComponentPresenter!
    
    internal init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.makeItFlatWhite()
    }

   
    internal func start() {
        let navigationModel = PagoNavigationModel(title: "Pago Custom Component", shortTitle: "Pago Custom Component", type: .simple, isSnapping: true, style: PagoNavigationStyle(textAlignment: .center, detailSize: Float(18)))
        let titleNavigationPresenter = PagoNavigationPresenter(model: navigationModel)
        let predicate = PagoCustomComponentPredicate()
        presenter = PagoCustomComponentPresenter(navigation: titleNavigationPresenter, predicate: predicate)
        controller = PagoCustomComponentViewController(presenter: presenter)
        navigationController.pushViewController(controller, animated: true)
    }
    
    internal func stop() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
    }
    
}
