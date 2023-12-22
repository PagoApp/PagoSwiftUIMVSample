//
//  File.swift
//  Pago
//
//  Created by Gabi Chiosa on 30.03.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation
import UIKit

public class PagoInfoAlertCoordinator: BasePresentedCoordinator {
    
    public var navigationPresenter: BaseViewController
    public var baseController: BaseViewController? {
        return controller
    }
    private var presenter: PagoInfoAlertPresenter!
    private var interactiveDismissCompletion: (()->())?
    private var controller: PagoInfoAlertViewController!
    
    public init(navigationPresenter: BaseViewController) {
        
        self.navigationPresenter = navigationPresenter
    }

    public func start(predicate: PagoInfoAlertPredicate, interactiveDismissCompletion: (()->())? = nil) {
 
        self.interactiveDismissCompletion = interactiveDismissCompletion
        presenter = PagoInfoAlertPresenter(predicate: predicate)
        presenter.delegate = self
        controller = PagoInfoAlertViewController(presenter: presenter)
        controller.modalPresentationStyle = .overCurrentContext
        if #available(iOS 13.0, *) {
            controller.isModalInPresentation = true
        }
        navigationPresenter.present(controller, animated: true)
    }
}

extension PagoInfoAlertCoordinator: PagoBaseAlertPresenterDelegate {
    
    public func dismiss() {
        
        stop(animated: true) { [weak self] in
            self?.interactiveDismissCompletion?()
        }
    }
}
