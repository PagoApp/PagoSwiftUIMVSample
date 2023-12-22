//
//  PagoLabelWCountdown.swift
//  Pago
//
//  Created by Gabi Chiosa on 21.06.2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//
import Foundation
import UIKit

open class PagoLabelWCountdown: BaseView {

    private var label: PagoLabel!
    private var viewPresenter: PagoLabelWCountdownPresenter { return (presenter as! PagoLabelWCountdownPresenter) }

    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    public init(presenter: PagoLabelWCountdownPresenter) {
        
        super.init(frame: .zero)
        setupUI()
        setup(presenter: presenter)
    }
    
    public func setup(presenter: PagoLabelWCountdownPresenter) {
        
        self.presenter = presenter
        self.presenter.setView(mView: self)
        presenter.loadData()
    }
    
    private func setupUI() {

        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        label = PagoLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

extension PagoLabelWCountdown: PagoLabelWCountdownPresenterView {
    
    public func setupLabel(presenter: PagoLabelPresenter) {
        
        label.setup(presenter: presenter)
    }
}
