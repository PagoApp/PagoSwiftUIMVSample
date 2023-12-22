//
//  
//  PagoTermsAndConditionsCoordinator.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit

public class PagoTermsAndConditionsCoordinator: BaseCoordinator {
    
    private var controller: PagoTermsAndConditionsViewController!
    private let navigationController: UINavigationController
    private let navigationPresenter: UIViewController
    private var mainCompletion: ((Bool?)->())?
    private var secondaryCompletion: (()->())?
    private var stopCompletion: (()->())?
    private var customDismiss: (()->())?
    private var dismissOnContinue: Bool = true
    private var presenter: PagoTermsAndConditionsPresenter!
    private var isCheckboxSelected: Bool? = nil
	private var infoCoordinator: PagoInfoAlertCoordinator?
	
    public init(navigationPresenter: UIViewController) {
        
        self.navigationPresenter = navigationPresenter
        self.navigationController = UINavigationController()
        self.navigationController.navigationBar.makeItFlatWhite()
    }
   
    public func start(predicate: PagoTermsAndConditionsPredicate, main: ((Bool?)->())? = nil, secondary: (()->())? = nil, stopCompletion: (()->())? = nil, customDismiss: (()->())? = nil, dismissOnContinue: Bool = true) {

        self.mainCompletion = main
        self.secondaryCompletion = secondary
        self.stopCompletion = stopCompletion
        self.customDismiss = customDismiss
        self.dismissOnContinue = dismissOnContinue
        let navigationModel = PagoNavigationModel(type: .none)
        let titleNavigationPresenter = PagoNavigationPresenter(model: navigationModel)
        presenter = PagoTermsAndConditionsPresenter(navigation: titleNavigationPresenter, predicate: predicate)
        presenter.delegate = self
        controller = PagoTermsAndConditionsViewController(presenter: presenter)
        navigationController.pushViewController(controller, animated: false)
        setupPresentationStyle(predicate: predicate)
        navigationPresenter.present(navigationController, animated: true)
    }

    private func setupPresentationStyle(predicate: PagoTermsAndConditionsPredicate) {

        switch predicate.modalPresentationStyle {
        case .pageSheet:
            navigationController.modalPresentationStyle = UIModalPresentationStyle.pageSheet
        case .fullScreen:
            navigationController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        default:
            navigationController.modalPresentationStyle = UIModalPresentationStyle.pageSheet
        }
    }
    
    public func stop(completion: (()->())? = nil) {
        
        if let customDismiss = customDismiss {
            customDismiss()
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.navigationController.dismiss(animated: true) {
                    completion?()
                }
            }
        }
    }
    
    public func showLoadingScreen() {
        
        presenter.showLoadingScreen()
    }
    
    public func hideLoadingScreen() {
        
        presenter.hideLoadingScreen()
    }
}

extension PagoTermsAndConditionsCoordinator: PagoTermsAndConditionsPresenterDelegate {
    
    func dismissScreen() {

        stop()
    }

    func didDismissScreen() {

        stopCompletion?()
    }
    
    func didTapMainAction(isCheckboxSelected: Bool) {

        self.isCheckboxSelected = isCheckboxSelected
        if self.dismissOnContinue {
            stop { [weak self] in
                guard let self = self,
                      let mainCompletion = self.mainCompletion else { return }
                
                mainCompletion(self.isCheckboxSelected)
            }
        } else {
            mainCompletion?(self.isCheckboxSelected)
        }
    }
    
    func didTapSecondaryAction() {
        
        stop { [weak self] in
            self?.secondaryCompletion?()
        }
    }
	
	func handleDisabledTap(predicate: PagoInfoAlertPredicate) {
		
		infoCoordinator = PagoInfoAlertCoordinator(navigationPresenter: controller)
		infoCoordinator?.start(predicate: predicate)
	}
}
