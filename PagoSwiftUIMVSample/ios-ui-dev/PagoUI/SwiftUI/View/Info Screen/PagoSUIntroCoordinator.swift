//
//  PagoSUIntroCoordinator.swift
//  PagoUISDK
//
//  Created by Cosmin Iulian on 17.11.2023.
//

import UIKit
import SwiftUI
import PagoUISDK

// MARK: - PagoUIInfoScreenCoordinator (public)

@available(iOS 14.0, *)
public class PagoSUIntroCoordinator: BaseCoordinator {
    
    // MARK: - Properties (internal)
    
    var viewController: UIViewController?
    var navigationController: UINavigationController?
    
    // MARK: Initializers (public)
    
    public init(viewController: UIViewController) {
        
        self.viewController = viewController
    }
    
    public init(navigationController: UINavigationController) {
        
        self.navigationController = navigationController
    }
    
    // MARK: - Methods (public)
    
    public func start(predicate: PagoSUIntroPredicate, mainCompletion: @escaping ()->(), secondaryCompletion: @escaping ()->() = {}) {
        
        let introView = PagoSUIntroView(predicate: predicate, mainAction: mainCompletion, secondaryAction: secondaryCompletion)
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
