//
//  BaseViewController+Extensions.swift
//  Pago
//
//  Created by Gabi Chiosa on 12/02/2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//

import UIKit

extension BaseViewController {
    
    private func topViewController(controller: BaseViewController) -> BaseViewController {
        
        if let presented = controller.presentedViewController as? BaseViewController {
            return topViewController(controller: presented)
        } else if let presented = controller.presentedViewController as? UINavigationController,
                  let topController = presented.topViewController as? BaseViewController {
            return topViewController(controller: topController)
        }
        return controller
    }
    
    public var topPresentedController: BaseViewController {
        
        return topViewController(controller: self)
    }
}


extension BaseViewController: UIScrollViewDelegate, BaseTableViewScrollDelegate {
    
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        basePresenter.isScrolling = true
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {

        basePresenter.isScrolling = true
        basePresenter.updateNavigationTitle()
        if let contentOffset = basePresenter.didScroll(y: Float(scrollView.contentOffset.y)) {
            scrollView.contentOffset.y = CGFloat(contentOffset)
        }
    }

    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
        basePresenter.willBeginDecelerating()
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        if !decelerate {
            basePresenter.isScrolling = false
        }
        basePresenter.snapView()
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        basePresenter.isScrolling = false
        basePresenter.snapView()
    }
}


extension BaseViewController: UINavigationControllerDelegate {

    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        let navCount = navigationController.viewControllers.count
        if navCount >= 2 {
            let prevVC = navigationController.viewControllers[navCount-2]
            
            var backButtonTitle = ""
            
            if let viewController = viewController as? BaseViewController {
                backButtonTitle =  viewController.basePresenter.backButtonTitle ?? " "
            }
            if basePresenter.hidesBackButton {
                navigationItem.hidesBackButton = true
            } else {
                let item = UIBarButtonItem(title: backButtonTitle, style: .plain, target: nil, action: nil)
                item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.Pago.blackBodyText.color, NSAttributedString.Key.font: UIFont.Pago.semiBold17.font], for: .normal)
                prevVC.navigationItem.backBarButtonItem = item
            }
        }
        
        if let coordinator = navigationController.topViewController?.transitionCoordinator {
            coordinator.notifyWhenInteractionChanges { [weak self] context in
                if !context.isCancelled {
                    self?.basePresenter.didFinishInteractivePop()
                }
            }
        }
    }
}
