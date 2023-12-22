//
//  
//  PagoLoadedImagesCoordinator.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 21.11.2023.
//
//

import PagoUISDK
import UIKit

internal class PagoLoadedImagesCoordinator: BaseCoordinator {
    
    private var controller: PagoLoadedImagesViewController!
    private let navigationController: UINavigationController
    
    private var presenter: PagoLoadedImagesPresenter!
    
    internal init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.makeItFlatWhite()
    }

   
    internal func start() {
        let navigationModel = PagoNavigationModel(title: "Pago Loaded Images", shortTitle: "Pago Loaded Images", type: .simple, isSnapping: true, style: PagoNavigationStyle(textAlignment: .center, detailSize: Float(18)))
        let titleNavigationPresenter = PagoNavigationPresenter(model: navigationModel)
        let predicate = PagoLoadedImagesPredicate()
        presenter = PagoLoadedImagesPresenter(navigation: titleNavigationPresenter, predicate: predicate)
        controller = PagoLoadedImagesViewController(presenter: presenter)
        navigationController.pushViewController(controller, animated: true)
    }
    
    internal func stop() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
    }
    
}
