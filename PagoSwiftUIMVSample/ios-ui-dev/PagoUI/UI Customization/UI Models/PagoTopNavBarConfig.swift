//
//  PagoTopNavBarConfig.swift
//  PagoUISDK
//
//  Created by Gabi on 20.11.2023.
//

import Foundation
import UIKit


internal struct PagoTopNavBarTypeConfig: Codable {
    
    var indicatorColor: PagoColorConfig = PagoColorConfig(colorHex: "#FFFFFF")
    var backgroundColor: PagoColorConfig = PagoColorConfig(colorHex: "#F4F6FA")
    var selectedFontStyle: String = "blueBold14"
    var unselectedFontStyle: String = "blueBold14"

    internal var toStyle: PagoTopNavBarStateStyle {
        
        let indicatorColorPago: UIColor.Pago
        let backgroundColorPago: UIColor.Pago
       
        if let colorHex = indicatorColor.colorHex {
            indicatorColorPago = UIColor.Pago.custom(colorHex)
        } else {
            indicatorColorPago = .sdkDarkGray
        }
        
        if let colorHex = backgroundColor.colorHex {
            backgroundColorPago = UIColor.Pago.custom(colorHex)
        } else {
            backgroundColorPago = .white
        }
        
        let labelStyles = PagoUIConfigurator.customConfig.labelStyles
        let selectedFontStyleCustomPago = PagoLabelStyle.PagoCustomLabelStyle(rawValue: selectedFontStyle) ?? .redRegular14
        let unselectedFontStyleCustomPago = PagoLabelStyle.PagoCustomLabelStyle(rawValue: unselectedFontStyle) ?? .redRegular14
        
        let selectedFontStylePago = PagoLabelStyle.customConfig(for: selectedFontStyleCustomPago)
        let unselectedFontStylePago = PagoLabelStyle.customConfig(for: unselectedFontStyleCustomPago)

        return PagoTopNavBarStateStyle(indicatorColor: indicatorColorPago,
                                       backgroundColor: backgroundColorPago,
                                       selectedFontStyle: selectedFontStylePago,
                                       unselectedFontStyle: unselectedFontStylePago)

    }
}
