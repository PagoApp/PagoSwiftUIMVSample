//
//  
//  PagoDatePickerPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import Foundation

public protocol PagoDatePickerPresenterDelegate: AnyObject {

    func didUpdate(presenter: PagoDatePickerPresenter)
}

public protocol PagoDatePickerPresenterView: PresenterView {

}

public class PagoDatePickerPresenter: BasePresenter {

    weak var delegate: PagoDatePickerPresenterDelegate?

    public var model: PagoDatePickerModel {
        get { return (self.baseModel as! PagoDatePickerModel) }
        set { self.baseModel = newValue }
    }

    public var selectedValue: Date? {
        get { return ( model.selectedValue) }
        set {
            model.selectedValue = newValue
            delegate?.didUpdate(presenter: self)
        }
    }

    public var style: PagoDatePickerStyle {
        get { return model.style }
        set { model.style = newValue }
    }

    /**
     NOTE: The default value is nil, which tells the date picker to use the current time zone as returned by local (NSTimeZone) or the time zone used by the date picker’s calendar.
     */
    public var timeZone: TimeZone? {
        return style.showLocalTime ? nil : TimeZone(identifier: "UTC")
    }

    public func didUpdate() {

        delegate?.didUpdate(presenter: self)
    }
    
}
