//
//  
//  PagoAlertCoordinator.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

public class PagoAlertCoordinator: BaseCoordinator {
    
    public var controller: PagoAlertViewController!
    var navigationPresenter: UIViewController!
    
    private var presenter: PagoAlertPresenter!
    private var tapHandler: ((Int)->())?
    private var dismissHandler: (()->())?
    private var dateHandler: ((Date?)->())?
    private var hiddenBottomBar: Bool = false
    
    public init(navigationPresenter: UIViewController) {
        
        self.navigationPresenter = navigationPresenter
    }

    public func start(model: PagoAlertModel, selfDismisses: Bool = true, tapHandler: @escaping (Int)->(), dismissHandler: (()->())? = nil, dateHandler: ((Date?)->())? = nil) {

        self.dismissHandler = dismissHandler
        self.tapHandler = tapHandler
        self.dateHandler = dateHandler
        presenter = PagoAlertPresenter(model: model)
        presenter.delegate = self
        presenter.isSelfDismissing = selfDismisses
        controller = PagoAlertViewController(presenter: presenter)
        controller.modalPresentationStyle = .overCurrentContext
        if #available(iOS 13.0, *) {
            controller.isModalInPresentation = true
        }
        navigationPresenter.present(controller, animated: true)
    }
    
    func stop(completion: (()->())? = nil) {
        
        navigationPresenter.dismiss(animated: true) {
            completion?()
        }
    }
    
    func showLoader() {
        
        presenter.showLoader()
    }
    
    func hideLoader() {
        
        presenter.hideLoader()
    }
}

extension PagoAlertCoordinator: PagoAlertPresenterDelegate {
    
    public func dismiss() {
        
        stop { [weak self] in
            self?.dismissHandler?()
        }
    }
    
    public func didTap(index: Int, dismiss: Bool) {
        
        if dismiss {
            stop { [weak self] in
                self?.tapHandler?(index)
            }
        } else {
            tapHandler?(index)
        }
    }

    public func didChangeDate(date: Date?) {

        dateHandler?(date)
    }
}
