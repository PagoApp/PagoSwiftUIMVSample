//
//  
//  PagoDatePickerModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

public struct PagoDatePickerModel: Model {

    public var selectedValue: Date?
    public var style = PagoDatePickerStyle()

    init(selectedValue: Date? = Date(), style: PagoDatePickerStyle = PagoDatePickerStyle()) {

        self.selectedValue = selectedValue
        self.style = style
        self.selectedValue = style.minDate ?? Date()
    }
}
