//
//  
//  PagoTermsAndConditionsPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import WebKit

protocol PagoTermsAndConditionsPresenterView: BaseStackViewControllerPresenterView {
    
    func setupDismissButton()
    func setupWebPreviewOnly(presenter: PagoWebPresenter)
    func setupOptions(presenter stackPresenter: PagoStackedInfoPresenter, withWeb webPresenter: PagoWebPresenter)
    func setupNavigationBarVisibility(isHidden: Bool)
}

protocol PagoTermsAndConditionsPresenterDelegate: AnyObject {
    
    func dismissScreen()
    func didDismissScreen()
    func didTapMainAction(isCheckboxSelected: Bool)
    func didTapSecondaryAction()
	func handleDisabledTap(predicate: PagoInfoAlertPredicate)
}

class PagoTermsAndConditionsPresenter: ViewControllerPresenter {

    weak var delegate: PagoTermsAndConditionsPresenterDelegate?
    private var model: PagoTermsAndConditionsModel {
        get { return baseModel as! PagoTermsAndConditionsModel }
        set { baseModel = newValue }
    }
    private var repository: PagoTermsAndConditionsRepository { return baseRepository as! PagoTermsAndConditionsRepository }
    private var service = PagoTermsAndConditionsService()
    private var view: PagoTermsAndConditionsPresenterView? { return self.basePresenterView as? PagoTermsAndConditionsPresenterView }
    private let predicate: PagoTermsAndConditionsPredicate
    private var hasNoOptions: Bool { return model.labelModel == nil && model.mainModel == nil && model.secondaryModel == nil}
    private var mainActionPresenter: PagoButtonPresenter?
    private var secondaryActionPresenter: PagoButtonPresenter?
    private var acceptCheckboxPresenter: PagoCheckboxPresenter?
    private var webPresenter: PagoWebPresenter!
    private var stackPresenter: PagoStackedInfoPresenter!
    
    init(navigation: PagoNavigationPresenter, predicate: PagoTermsAndConditionsPredicate) {

        self.predicate = predicate    
        super.init(navigation: navigation)
        baseRepository = PagoTermsAndConditionsRepository()
    }
    
    override func loadData() {
        
        super.loadData()
        guard let repoModel = repository.getData(predicate: predicate) as? PagoTermsAndConditionsModel else { 
            return
        }
        update(model: repoModel)
        
        stackPresenter = PagoStackedInfoPresenter(model: model.stackModel)
        webPresenter = PagoWebPresenter(model: model.webModel)
        webPresenter.delegate = self
        
        view?.setupDismissButton()
        
        if hasNoOptions {
            view?.setupWebPreviewOnly(presenter: webPresenter)
        } else {
            view?.setupOptions(presenter: stackPresenter, withWeb: webPresenter)
        }

        if let infoModel = model.labelModel {
            let infoPresenter = PagoLabelPresenter(model: infoModel)
            stackPresenter.addLabel(presenter: infoPresenter)
        }

        if let acceptCheckboxModel = model.acceptCheckboxModel {
            let acceptCheckboxPresenter = PagoCheckboxPresenter(model: acceptCheckboxModel)
            acceptCheckboxPresenter.delegate = self
            stackPresenter.addCheckBox(presenter: acceptCheckboxPresenter)
            self.acceptCheckboxPresenter = acceptCheckboxPresenter
        }

        if let mainModel = model.mainModel {
            let mainActionPresenter = PagoButtonPresenter(model: mainModel)
            mainActionPresenter.delegate = self
            // enable action button according to the checkbox's state
            if let acceptCheckboxPresenter = acceptCheckboxPresenter {
                mainActionPresenter.isEnabled = acceptCheckboxPresenter.isSelected
            }
            stackPresenter.addButton(presenter: mainActionPresenter)
            self.mainActionPresenter = mainActionPresenter
        }

        if let secondaryModel = model.secondaryModel {
            let actionPresenter = PagoButtonPresenter(model: secondaryModel)
            actionPresenter.delegate = self
            stackPresenter.addButton(presenter: actionPresenter)
            self.secondaryActionPresenter = actionPresenter
        }

        view?.setupNavigationBarVisibility(isHidden: predicate.hidesNavigationBar)
    }
    
    public func dismissScreen() {
        
        delegate?.dismissScreen()
    }

    public func didDismissScreen() {

        delegate?.didDismissScreen()
    }
    
    public func showLoadingScreen() {
        
        view?.showOverlayLoading()
    }
    
    public func hideLoadingScreen() {
        
        view?.hideOverlayLoading()
    }
}

extension PagoTermsAndConditionsPresenter: PagoButtonPresenterDelegate {
    
    func didTap(button: PagoButtonPresenter) {
        
        switch button {
        case mainActionPresenter:
            if button.isEnabled {
                if let checkboxPresenter = self.acceptCheckboxPresenter {
                    delegate?.didTapMainAction(isCheckboxSelected: checkboxPresenter.isSelected)
                } else {
                    delegate?.didTapMainAction(isCheckboxSelected: false)
                }
            }
        case secondaryActionPresenter:
            delegate?.didTapSecondaryAction()
        default:
            break
        }
    }
}

extension PagoTermsAndConditionsPresenter: PagoCheckboxPresenterDelegate {

    public func didUpdate(presenter: PagoCheckboxPresenter) {

        mainActionPresenter?.isEnabled = presenter.isSelected
    }
	
	public func handleDisabledTap() {
		
		if let message = predicate.disabledCheckboxWarningText {
			let predicate = repository.getInfoAlertPredicate(message: message)
			delegate?.handleDisabledTap(predicate: predicate)
		}
	}
}

extension PagoTermsAndConditionsPresenter: PagoWebPresenterDelegate {
    
    func didReceiveJSCallBack(state: String) {}
    
    func decidePolicy(forURL: URL?, decisionHandler: @escaping (WKNavigationActionPolicy) -> ()) {
        decisionHandler(.allow)
    }
    
    func didFinish(url: URL?) {
        webPresenter.hideLoader()
    }
	
	func didScrollToBottom() {
		
		acceptCheckboxPresenter?.isUserInteractionEnabled = true
	}
}
