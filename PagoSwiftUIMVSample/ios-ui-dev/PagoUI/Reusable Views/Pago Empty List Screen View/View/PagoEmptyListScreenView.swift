//
//  
//  PagoEmptyListScreenView.swift
//  Pago
//
//  Created by Gabi Chiosa on 11.11.2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//
import UIKit

public class PagoEmptyListScreenView: BaseView {
    
    weak var containerView: UIView?
    
    var viewPresenter: PagoEmptyListScreenPresenter! { return (presenter as! PagoEmptyListScreenPresenter) }

    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    public init(presenter: PagoEmptyListScreenPresenter, container: UIView) {
        
        super.init(frame: .zero)
        self.containerView = container
        setup(presenter: presenter)
    }

    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    public func setup(presenter: PagoEmptyListScreenPresenter) {
        
        presenter.setView(mView: self)
        presenter.loadData()
        self.presenter = presenter
        presenter.setupActionView()
        backgroundColor = UIColor.Pago.clear.color
    }
}

extension PagoEmptyListScreenView: PagoEmptyListScreenPresenterView {
    
    public func setup(stack: PagoStackedInfoPresenter) {
        
        let stackView = PagoStackedInfoView(presenter: stack)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    public func setupToTop(stack: PagoStackedInfoPresenter) {

        if let superView = containerView {
            let stackView = PagoStackedInfoView(presenter: stack)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            superView.addSubview(stackView)
            stackView.topAnchor.constraint(equalTo: superView.topAnchor, constant: 80).isActive = true
            stackView.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 24).isActive = true
            stackView.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -24).isActive = true
        }
    }
    
    public func setupToBottom(action: PagoButtonPresenter) {

        if let superView = containerView {
            let buttonView = PagoButton(presenter: action)
            buttonView.translatesAutoresizingMaskIntoConstraints = false
            superView.addSubview(buttonView)
            buttonView.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 24).isActive = true
            buttonView.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -24).isActive = true
            buttonView.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -40).isActive = true
        }
    }
    
    public func hide() {
        
        self.alpha = 0
        self.isHidden = true
    }
    
    public func show() {
        
        self.alpha = 1
        self.isHidden = false
    }
}
