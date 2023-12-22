//
//  
//  PagoTermsAndConditionsViewController.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

public class PagoTermsAndConditionsViewController: BaseStackViewController {

    private var webView: PagoWebView!
    private var optionsStackView: PagoStackedInfoView!
    
    var presenter: PagoTermsAndConditionsPresenter {
        return basePresenter as! PagoTermsAndConditionsPresenter
    }
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.presentationController?.delegate = self
        view.backgroundColor = .white
        presenter.setView(mView: self)
        presenter.loadData()        
    }

    @objc func dismissScreenAction() {
        
        presenter.dismissScreen()
    }
}

extension PagoTermsAndConditionsViewController: UIAdaptivePresentationControllerDelegate {

    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {

        presenter.didDismissScreen()
    }
}

extension PagoTermsAndConditionsViewController: PagoTermsAndConditionsPresenterView {
    
    func setupNavigationBarVisibility(isHidden: Bool) {
        
        navigationController?.setNavigationBarHidden(isHidden, animated: false)
    }

    func setupDismissButton() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.closeButton(self, action: #selector(self.dismissScreenAction))
    }
    
    func setupWebPreviewOnly(presenter: PagoWebPresenter) {
        
        webView = PagoWebView(presenter: presenter)
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupOptions(presenter stackPresenter: PagoStackedInfoPresenter, withWeb webPresenter: PagoWebPresenter) {
        
        let margins = view.layoutMarginsGuide
        optionsStackView = PagoStackedInfoView(presenter: stackPresenter)
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(optionsStackView)
        optionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        optionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        optionsStackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        
        webView = PagoWebView(presenter: webPresenter)
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: optionsStackView.topAnchor).isActive = true
    }
}
