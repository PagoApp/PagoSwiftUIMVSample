//
//
//  PagoImagePresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

open class PagoImageViewPresenter: BasePresenter {

    public var model: PagoImageViewModel {
        get { baseModel as! PagoImageViewModel }
        set { baseModel = newValue }
    }
    public var imageType: UIImage.Pago { return model.imageType }
    public var style: PagoImageViewStyle { return model.style }
    public var accessibility: PagoAccessibility { return model.accessibility }
    private var view: PresenterView? { return basePresenterView }
    
    public override func update(model: Model) {
        
        super.update(model: model)
        view?.reloadView()
    }
    
    public func update(style: PagoImageViewStyle) {
        
        model.style = style
        view?.reloadView()
    }
    
    public func update(image: UIImage.Pago?) {

        model.imageType = image ?? .none
        view?.reloadView()
    }
    
    public func reload() {
        
        view?.reloadView()
    }
}
