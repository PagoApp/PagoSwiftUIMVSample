//
//  
//  PagoDropDownButtonPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 20/07/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

open class PagoDropDownButtonPresenter: BasePresenter {

    public var model: PagoDropDownButtonModel {
        get { return (self.baseModel as! PagoDropDownButtonModel) }
        set { baseModel = newValue }
    }
    
    private var view: PresenterView? { return basePresenterView }
    
    
    public var style: PagoDropDownOptionStyle {
        return model.style
    }
    
    public var options: Int {
        return model.options.count
    }

    public var selectedIndex: Int {
        return model.selectedIndex
    }
    
    public var optionsPositionY: Double {
        return Double(-1 * selectedIndex * style.optionHeight)
    }
    
    public var optionsCollapsedHeight: Double {
        return Double(options * style.optionHeight)
    }
    
    public var optionsExpandedHeight: Double {
        return Double(options * style.optionExpandedHeight)
    }
    
    public func select(index: Int) {
        model.selectedIndex = index
    }
    
    public func title(at index: Int) -> String? {
        
        guard index < model.options.count else { return nil }
        return model.options[index].title
    }
    
}
