//
//  
//  PagoBadgeButtonView.swift
//  Pago
//
//  Created by Gabi Chiosa on 12/04/2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//
import UIKit
import Foundation

open class PagoBadge: BaseView {
    

    private var badge: PagoLabel!
    
    private var viewPresenter: PagoBadgePresenter! { return (presenter as! PagoBadgePresenter) }

    public override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    public init(presenter: PagoBadgePresenter) {
        
        super.init(frame: .zero)
        setup(presenter: presenter)
    }

    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    public func setup(presenter: PagoBadgePresenter) {
        
        self.presenter = presenter
        presenter.setView(mView: self)
        presenter.loadData()
    }
}

extension PagoBadge: PagoBadgePresenterView {
    
    public func setup(badge: PagoLabelPresenter, background: UIColor.Pago) {
        
        self.badge = PagoLabel(presenter: badge)
        self.badge.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.badge)
        self.badge.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6).isActive = true
        self.badge.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6).isActive = true
        self.badge.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        self.badge.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.backgroundColor = background.color
    }
    
    public func show() {
        
        DispatchQueue.main.async { [weak self] in
            self?.isHidden = false
        }
    }
    
    public func hide() {
        
        DispatchQueue.main.async { [weak self] in
            self?.isHidden = true
        }
    }
}
