//
//  
//  PagoControllerPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 19/07/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import Foundation
import UIKit

public class PagoPageControllerPresenter: BasePresenter {

    var model: PagoPageControllerModel {
        get { return (self.baseModel as! PagoPageControllerModel) }
        set { self.baseModel = newValue }
    }
    
    private var view: PresenterView? { return basePresenterView }

    public var numberOfPages: Int {
        return model.numberOfPages
    }
    
    public var indicatorColorType: UIColor.Pago {
        return model.style.indicatorColor
    }
    
    public var dividerColorType: UIColor.Pago {
        return model.style.dividerColor
    }
    
    public var currentIndicatorColorType: UIColor.Pago {
        return model.style.currentIndicatorColor
    }
    
    public var currentIndex: Int {
        return model.currentIndex
    }
    
    public func update(selected: Int) {
        model.currentIndex = selected
        view?.reloadView()
    }
}
