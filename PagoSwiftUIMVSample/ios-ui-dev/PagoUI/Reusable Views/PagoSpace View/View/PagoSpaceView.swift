//
//  
//  PagoSpaceView.swift
//  Pago
//
//  Created by Gabi Chiosa on 19/03/2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//
import Foundation
import UIKit

open class PagoSpaceView: BaseView {
    
    private var viewPresenter: PagoSpacePresenter {
        return presenter as! PagoSpacePresenter
    }
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    public init(presenter: PagoSpacePresenter) {
        
        super.init(frame: .zero)
        setup(presenter: presenter)
    }

    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    public func setup(presenter: PagoSpacePresenter) {
        
        self.presenter = presenter
        presenter.setView(mView: self)
        presenter.loadData()
    }
}

extension PagoSpaceView: PagoSpacePresenterView {
    
    public func setup(size: CGSize) {
        
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
}
