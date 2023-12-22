//
//  
//  PagoControllerModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 19/07/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation

// MARK: - PagoPageControllerModel

public struct PagoPageControllerModel: Model {
    
    let numberOfPages: Int
    var currentIndex = 0
    let style: PagoPageControllerStyle
    
    public init(numberOfPages: Int, currentIndex: Int = 0, style: PagoPageControllerStyle? = nil) {
        self.numberOfPages = numberOfPages
        self.currentIndex = currentIndex
        self.style = style ?? PagoPageControllerStyle(indicatorColor: .lightGrayInactive, currentIndicatorColor: .greenPositive, dividerColor: .clear)
    }
}

// MARK: - PagoPageControllerStyle

/// Defines a style for a ``PagoPageController``
///
public struct PagoPageControllerStyle {

    // MARK: Constants
    
    let indicatorColor: UIColor.Pago
    let currentIndicatorColor: UIColor.Pago
    let dividerColor: UIColor.Pago
    
    // MARK: Accessors
    
    /// Returns a ``PagoPageControllerStyle`` with the custom style from ``PagoUIConfigurator.customConfig.indicator``
    /// 
    public static var customStyle: PagoPageControllerStyle? {
        PagoPageControllerStyle(customStyle: PagoUIConfigurator.customConfig.indicator)
    }
    
    // MARK: Lifecycle
    
    init?(customStyle: PagoIndicatorConfig) {
        if let activeColor = customStyle.activeColor.colorHex,
           let inactiveColor = customStyle.inactiveColor.colorHex {
            self.indicatorColor = UIColor.Pago.custom(inactiveColor)
            self.currentIndicatorColor = UIColor.Pago.custom(activeColor)
            self.dividerColor = UIColor.Pago.clear
        } else {
            return nil
        }
    }
    
    /// Instantiates a new ``PagoPageControllerStyle``
    /// - parameter indicatorColor: The color for the page controller indicator
    /// - parameter currentIndicatorColor: The color for the selected page controller indicator
    /// - parameter dividerColor: The color the the page controller divider
    ///
    public init(
        indicatorColor: UIColor.Pago,
        currentIndicatorColor: UIColor.Pago,
        dividerColor: UIColor.Pago
    ) {
        self.indicatorColor = indicatorColor
        self.currentIndicatorColor = currentIndicatorColor
        self.dividerColor = dividerColor
    }
}
