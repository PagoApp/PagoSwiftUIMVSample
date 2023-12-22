//
//  File.swift
//  Pago
//
//  Created by Gabi Chiosa on 30.03.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation
import UIKit

public class PagoGeneralErrorCoordinator: BaseCoordinator {
 
    var controller: PagoGeneralErrorViewController!
    var navigationPresenter: UIViewController!

    private var presenter: PagoGeneralErrorPresenter!
    private var tapHandler: ((Action)->())?
    private var interactiveDismissCompletion: (()->())?
    private var customDismiss: (()->())?
    
    public enum Action {
        case main
    }
    
    public init(navigationPresenter: UIViewController) {
        
        self.navigationPresenter = navigationPresenter
    }

    //TODO: Should refactor and add start/stop rules
    public func start(predicate: PagoGeneralErrorPredicate = PagoGeneralErrorPredicate(), tapHandler: @escaping (Action)->(), interactiveDismissCompletion: (()->())? = nil, customDismiss: (()->())? = nil) {
 
        self.customDismiss = customDismiss
        self.interactiveDismissCompletion = interactiveDismissCompletion
        self.tapHandler = tapHandler
        presenter = PagoGeneralErrorPresenter(predicate: predicate)
        presenter.delegate = self
        controller = PagoGeneralErrorViewController(presenter: presenter)
        controller.modalPresentationStyle = .overCurrentContext
        if #available(iOS 13.0, *) {
            controller.isModalInPresentation = true
        }
        navigationPresenter.present(controller, animated: true)
    }
    
    public func stop(completion: (()->())? = nil) {

        navigationPresenter.dismiss(animated: true) {
            completion?()
        }
    }
}

extension PagoGeneralErrorCoordinator: PagoGeneralErrorPresenterDelegate {

    public func dismiss() {
        
        if let customDismiss = customDismiss {
            customDismiss()
        } else {
            stop { [weak self] in
                self?.interactiveDismissCompletion?()
            }
        }
    }
    
    public func didTapOk() {
        
        stop { [weak self] in
            self?.tapHandler?(.main)
        }
    }

}
