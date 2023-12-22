//
//  
//  PagoSwitchView.swift
//  PagoUISDK
//
//  Created by Gabi on 10.08.2022.
//

import UIKit

public class PagoSwitchView: BaseView {
    
    private lazy var pagoSwitch = UISwitch()
    
    var viewPresenter: PagoSwitchPresenter! {
        return (presenter as! PagoSwitchPresenter)
    }

    public init(presenter: PagoSwitchPresenter) {
        
        super.init(frame: .zero)
        setup(presenter: presenter)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }

    public func setup(presenter: PagoSwitchPresenter) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.presenter = presenter
        presenter.setView(mView: self)
        presenter.loadData()
        setupUI()
    }
    
    private func setupUI() {
        
        pagoSwitch.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pagoSwitch)
        pagoSwitch.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        pagoSwitch.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        pagoSwitch.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        pagoSwitch.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        pagoSwitch.addTarget(self, action: #selector(didSwitch), for: .valueChanged)
    }

    @objc private func didSwitch() {
        
        viewPresenter.didSwitch()
    }
}

extension PagoSwitchView: PagoSwitchPresenterView {
   
    public func update(isOn: Bool) {
        
        pagoSwitch.isOn = isOn
    }
    
    
    public func update(style: PagoSwitchStyle) {
        
        pagoSwitch.onTintColor = style.color.color
    }
}
