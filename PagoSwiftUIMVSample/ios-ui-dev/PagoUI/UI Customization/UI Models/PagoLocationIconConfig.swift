//
//  PagoLocationIconConfig.swift
//  PagoUISDK
//
//  Created by Gabi on 18.10.2023.
//

import Foundation
import UIKit

internal struct PagoLocationIconConfig: Codable {
    
    internal var regular: PagoLocationIconTypeConfig = PagoLocationIconTypeConfig(color: PagoColorConfig(colorHex: "#000000"), background: PagoColorConfig(colorHex: "#000000"), border: nil)
    internal var disabled: PagoLocationIconTypeConfig = PagoLocationIconTypeConfig(color: PagoColorConfig(colorHex: "#000000"))
    internal var selected: PagoLocationIconTypeConfig = PagoLocationIconTypeConfig(color: PagoColorConfig(colorHex: "#0000FF"), border: PagoBorderConfig(color: PagoColorConfig(colorHex: "#0000FF"), cornerRadius: 12))
    internal var deselected: PagoLocationIconTypeConfig = PagoLocationIconTypeConfig(color: PagoColorConfig(colorHex: "#0000FF"), border: PagoBorderConfig(color: PagoColorConfig(colorHex: "#0000FF"), cornerRadius: 12))
    
    internal var toStyle: PagoLocationIconStyle {
        
        return PagoLocationIconStyle(regular: regular.toStyle, disabled: disabled.toStyle, selected: selected.toStyle, deselected: deselected.toStyle)
    }
}
    
internal struct PagoLocationIconTypeConfig: Codable {
    var color: PagoColorConfig
    var background: PagoColorConfig?
    var border: PagoBorderConfig?
    
    internal var toStyle: PagoLocationIconStateStyle {
        
        let colorPago: UIColor.Pago
        if let colorHex = color.colorHex {
            colorPago = UIColor.Pago.custom(colorHex)
        } else {
            colorPago = .sdkBlackBodyText
        }
        
        var bgColorPago: UIColor.Pago?
        if let colorHex = background?.colorHex {
            bgColorPago = UIColor.Pago.custom(colorHex)
        }
        
        var borderStyle: BorderStyle?
        if let border = border, let borderColorHex = border.color?.colorHex {
            let color = UIColor.Pago.custom(borderColorHex)
            borderStyle = BorderStyle(colorType: color, width: CGFloat(border.width ?? 0))
        }
        
        return PagoLocationIconStateStyle(color: colorPago, 
                                          background: bgColorPago,
                                          border: borderStyle)
    }
}
