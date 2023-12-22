//
//  NSNumber+Extensions.swift
//  PagoApiClient
//
//  Created by Andrei Chirita on 26.05.2022.
//

import Foundation

internal extension NSNumber {
    
    var twoUnitAndDecimalsPlaces:String {
        return NSNumber.twoUnitAndDecimalsPlacesFormatter.string(from: self) ?? ""
    }
    
    @nonobjc
    static let twoUnitAndDecimalsPlacesFormatter:NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.currencyCode = ""
        formatter.currencySymbol = ""
        formatter.alwaysShowsDecimalSeparator = true
        formatter.decimalSeparator = "."
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.minimumIntegerDigits = 2
        return formatter
    }()
    
    var twoDecimals:String {
        return NSNumber.twoDecimalsFormatter.string(from: self) ?? ""
    }
    
    @nonobjc
    static let twoDecimalsFormatter:NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.currencyCode = ""
        formatter.currencySymbol = ""
        formatter.alwaysShowsDecimalSeparator = true
        formatter.decimalSeparator = "."
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.minimumIntegerDigits = 1

        return formatter
    }()
}
