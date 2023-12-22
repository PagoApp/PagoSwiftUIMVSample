//
//  CoordinatorT.swift
//  Pago
//
//  Created by Bogdan-Gabriel Chiosa on 05/12/2019.
//  Copyright © 2019 cleversoft. All rights reserved.
//

import UIKit

public protocol BaseCoordinator: AnyObject {

}

//TODO: Must replace BaseCoordinator
public protocol BaseCoordinatorWithStop: BaseCoordinator {

    var baseController: BaseViewController? { get }
    func stop(animated: Bool, completion: (()->())?)
}

public protocol BasePushCoordinator: BaseCoordinatorWithStop {
    
    var navigationController: UINavigationController { get set }
    
}
extension BasePushCoordinator {
    
    public func stop(animated: Bool, completion: (()->())? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if animated {
                //NOTE: We make sure that we have the controller in the viewcontrollers stack
                guard let controller = self.baseController, self.navigationController.viewControllers.firstIndex(of: controller) != nil else {
                    completion?()
                    return
                }
                self.navigationController.popViewController(pagoAnimated: animated) {
                    completion?()
                }
            } else if let controller = self.baseController, let index = self.navigationController.viewControllers.firstIndex(of: controller) {
                var vcs = self.navigationController.viewControllers
                //TODO: If THERE'S ONLY ONE VC to remove from navigation controller this doesn't work. see the BaseScanFlow Module issue, when on fail intro user selects try again later
                vcs.remove(at: index)
                self.navigationController.viewControllers = vcs
                completion?()
            }
        }
    }
}

public protocol BasePresentedCoordinator: BaseCoordinatorWithStop {
    
    var navigationPresenter: BaseViewController { get set }
}

extension BasePresentedCoordinator {
    
    public func stop(animated: Bool, completion: (()->())? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.navigationPresenter.dismiss(animated: animated, completion: completion)
        }
    }
}

extension BaseCoordinator {

    public func topViewController(controller: UIViewController) -> BaseViewController? {
        
        if let navigationController = controller as? UINavigationController, let visibleViewController = navigationController.visibleViewController {
            return topViewController(controller: visibleViewController)
        }
        if let tabController = controller as? UITabBarController, let selected = tabController.selectedViewController {
            return topViewController(controller: selected)
        }
        if let presented = controller.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller as? BaseViewController
    }
}
