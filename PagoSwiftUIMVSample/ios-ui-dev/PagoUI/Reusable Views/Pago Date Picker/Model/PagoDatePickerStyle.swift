//
//  
//  PagoDatePickerRepository.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

public struct PagoDatePickerStyle {
    
    var currentDate: Date = Date()
    let minDate: Date?
    let maxDate: Date?
    var datePickerMode = UIDatePicker.Mode.date
    var backgroundColor : UIColor.Pago = .clear
    var textColor: UIColor.Pago = .blackBodyText
    var size: PagoSize?
    var inset: UIEdgeInsets = UIEdgeInsets.zero
    var locale: Locale = Locale.current
    var showLocalTime = false

    init(currentDate: Date = Date(), minDate: Date? = nil, maxDate: Date? = nil, datePickerMode: UIDatePicker.Mode = .date, backgroundColor: UIColor.Pago = .clear, textColor: UIColor.Pago = .blackBodyText, size: PagoSize? = nil, inset: UIEdgeInsets = UIEdgeInsets.zero, locale: Locale = Locale.current, showLocalTime: Bool = false) {

        self.currentDate = currentDate
        self.minDate = minDate
        self.maxDate = maxDate
        self.datePickerMode = datePickerMode
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.size = size
        self.inset = inset
        self.locale = locale
        self.showLocalTime = showLocalTime
    }
}
