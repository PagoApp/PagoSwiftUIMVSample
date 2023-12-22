//
//  PagoLocationIconStyle.swift
//  PagoUISDK
//
//  Created by Gabi on 19.10.2023.
//

import UIKit

public struct PagoLocationIconStyle {
    
    public enum IconType {
        
        case regular, disabled, selected, deselected
    }
    
    public var regular: PagoLocationIconStateStyle = PagoLocationIconStateStyle(color: .redNegative, background: .clear, border: nil)
    public var disabled: PagoLocationIconStateStyle = PagoLocationIconStateStyle(color: .sdkLightGray)
    public var selected: PagoLocationIconStateStyle = PagoLocationIconStateStyle(color: .sdkMainButtonColor, border: BorderStyle(colorType: .sdkMainButtonColor, width: 2))
    public var deselected: PagoLocationIconStateStyle = PagoLocationIconStateStyle(color: .yellowWarning, border: BorderStyle(colorType: .sdkMainButtonColor, width: 2))
}


public struct PagoLocationIconStateStyle {
    public var color: UIColor.Pago
    public var background: UIColor.Pago?
    public var border: BorderStyle?
}
