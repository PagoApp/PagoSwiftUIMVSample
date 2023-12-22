//
//  
//  PagoLinePresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 31/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

open class PagoLinePresenter: BasePresenter {

    public var model: PagoLineModel {
        get { (self.baseModel as! PagoLineModel) }
        set { baseModel = newValue}
    }
    public var style: PagoLineStyle { return model.style }
    public var view: PresenterView? { return basePresenterView }

    public func update(color: UIColor.Pago) {
        
        model.style.color = color
        view?.reloadView()
    }
}
