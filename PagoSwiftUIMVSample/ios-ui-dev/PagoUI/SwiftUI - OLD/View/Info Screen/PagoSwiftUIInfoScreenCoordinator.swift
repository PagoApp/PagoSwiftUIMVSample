//
//  PagoUIInfoScreenCoordinator.swift
//  PagoInvoiceIntegrator
//
//  Created by Cosmin Iulian on 17.11.2023.
//

import PagoUISDK
import UIKit
import SwiftUI

@available(iOS 15.0, *)
public class PagoSwiftUIInfoScreenCoordinator: BaseCoordinator {
    
    internal var viewController: UIViewController?
    internal var navigationController: UINavigationController?
    
    public init(viewController: UIViewController) {
        
        self.viewController = viewController
    }
    
    public init(navigationController: UINavigationController) {
        
        self.navigationController = navigationController
    }
    
    public func start(predicate: PagoSwiftUIInfoScreenPredicate, mainCompletion: @escaping ()->(), secondaryCompletion: @escaping ()->() = {}) {
        
        let introView = PagoSwiftUIInfoScreen(predicate: predicate, mainAction: mainCompletion, secondaryAction: secondaryCompletion)
        let introController = UIHostingController(rootView: introView)
        if predicate.isFullScreen {
            introController.modalPresentationStyle = .fullScreen
        }
        if let navigationController = navigationController {
            navigationController.navigationBar.makeItTransparent()
            navigationController.pushViewController(introController, animated: true)
        } else if let viewController = viewController {
            viewController.present(introController, animated: true)
        }
    }
    
    public func stop(animated: Bool = true) {
        
        if let navigationController = navigationController {
            navigationController.popViewController(animated: animated)
        } else if let viewController = viewController {
            viewController.dismiss(animated: animated)
        }
    }
}
