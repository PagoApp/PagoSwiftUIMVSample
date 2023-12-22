//
//  
//  PagoInfoScreenCoordinator.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

protocol PagoInfoScreenCoordinatorDelegate: AnyObject {
    func didPresentedWithSuccess()
    func didFailedPresenting()
}

extension PagoInfoScreenCoordinatorDelegate {
    func didFailedPresenting() {}
}

public class PagoInfoScreenCoordinator: BaseCoordinator {

    weak var delegate: PagoInfoScreenCoordinatorDelegate?
    public var controller: PagoInfoScreenViewController!
    private var presenter: PagoInfoScreenPresenter!
    private var mainCompletion: (()->())?
    private var secondaryCompletion: (()->())?
    private var dismissCompletion: (()->())?
    private var closeHandler: (()->())?
    private var customDismiss: (()->())?
    private var detailHandler: (()->())?
    private var footerHandler: (()->())?
    private var navigationController: UINavigationController!
    private let navigationPresenter: UIViewController?
    
    public init(navigationPresenter: UIViewController? = nil, navigationController: UINavigationController = UINavigationController()) {
        self.navigationPresenter = navigationPresenter
        self.navigationController = navigationController
        self.navigationController.navigationBar.makeItTransparent()
    }

    public func start(predicate: PagoInfoScreenBasePredicate, mainCompletion: @escaping ()->(), secondaryCompletion: @escaping ()->() = {}, dismissCompletion: @escaping ()->() = {}, customDismiss: (()->())? = nil, detailHandler: @escaping ()->() = {}, footerHandler: @escaping ()->() = {}, closeHandler: (()->())? = nil) {
        
        self.closeHandler = closeHandler
        self.detailHandler = detailHandler
        self.dismissCompletion = dismissCompletion
        self.mainCompletion = mainCompletion
        self.secondaryCompletion = secondaryCompletion
        self.footerHandler = footerHandler
        self.customDismiss = customDismiss
        let navigationModel = PagoNavigationModel(type: .none, isSnapping: false)
        let navigationBarPresenter = PagoNavigationPresenter(model: navigationModel)
        presenter = PagoInfoScreenPresenter(navigation: navigationBarPresenter, predicate: predicate)
        presenter.delegate = self
        controller = PagoInfoScreenViewController(presenter: presenter)
        controller.delegate = self
        
        if let navigationPresenter = navigationPresenter {
            navigationController.pushViewController(controller, animated: false)
            guard !navigationController.isBeingPresented && navigationPresenter.presentedViewController == nil else {
                delegate?.didFailedPresenting()
                return
            }
            
            if predicate.isFullScreen {
                navigationController.modalPresentationStyle = .fullScreen
                if #available(iOS 13.0, *) {
                    navigationController.isModalInPresentation = true
                }
            }
            navigationPresenter.present(navigationController, animated: true) { [weak self] in
                self?.delegate?.didPresentedWithSuccess()
            }
        } else {
            navigationController.pushViewController(controller, animated: true)
        }
    }
    
    func restartDelay() {
        presenter.startDelay()
    }
   
    public func stop() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if let customDismiss = self.customDismiss {
                customDismiss()
            } else if let navigationPresenter = self.navigationPresenter {
                navigationPresenter.dismiss(animated: true)
            } else {
                self.navigationController.popViewController(animated: true)
            }
            DispatchQueue.main.async { [weak self] in
                self?.dismissCompletion?()
            }
        }
    }
}

extension PagoInfoScreenCoordinator: PagoInfoScreenDelegate {
    
    func dismissScreen() {
        
        if closeHandler == nil {
            stop()
        } else {
            closeHandler?()
        }
    }
    
    func didDismissScreen() {
        
        dismissCompletion?()
    }
}

extension PagoInfoScreenCoordinator: PagoInfoScreenPresenterDelegate {
    
    func didSelectMainAction() {
        
        mainCompletion?()
    }
    
    func didSelectSecondaryAction() {
        
        secondaryCompletion?()
    }
    
    func didTapDetail() {
        
        detailHandler?()
    }
    
    func didTapFooter() {
        footerHandler?()
    }
}
