//
//  
//  PagoSearchBarPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 30/07/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit

public protocol PagoSearchBarPresenterView: PresenterView {

}

open class PagoSearchBarPresenter: BasePresenter {

    public var text: String? {
        return model.text
    }
    
    public var placeholder: String? {
        return model.placeholder
    }
   
    public var style: PagoSearchBarStyle {
        return model.style
    }
    
    public var image: UIImage {
        return model.image
    }
    
    public var model: PagoSearchBarModel {
        get { return (self.baseModel as! PagoSearchBarModel) }
        set { baseModel = newValue }
    }
    
    private var view: PagoSearchBarPresenterView? { return basePresenterView as? PagoSearchBarPresenterView }
    
    public func update(text: String?, placeholder: String?) {
        
        model.text = text
        model.placeholder = placeholder
        view?.reloadView()
    }

}
