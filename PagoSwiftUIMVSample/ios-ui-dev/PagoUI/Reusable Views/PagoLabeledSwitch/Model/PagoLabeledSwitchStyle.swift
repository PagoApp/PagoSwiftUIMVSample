//
//  PagoLabeledSwitchStyle.swift
//  PagoUISDK
//
//  Created by Gabi on 10.08.2022.
//

import Foundation
import UIKit

public struct PagoLabeledSwitchStyle: BaseStyle {
    
    var labelStyle: PagoLabelStyle
    var switchStyle: PagoSwitchStyle
    
    public init(labelStyle: PagoLabelStyle? = nil, switchStyle: PagoSwitchStyle? = nil) {
        
        if let labelStyle = labelStyle {
            self.labelStyle = labelStyle
        } else {
            let huggingPriority = ContentPriorityBase(priority: .init(rawValue: 251), axis: .horizontal)
            let style = PagoLabelStyle(textColorType: .sdkDarkGray, fontType: .regular14, alignment: .left, numberOfLines: 0, contentHuggingPriority: huggingPriority)
            self.labelStyle = style
        }
        if let switchStyle = switchStyle {
            self.switchStyle = switchStyle
        } else {
            self.switchStyle = PagoSwitchStyle(color: .sdkMainButtonColor)
        }
    }
    
}

extension PagoLabeledSwitchStyle {
    
    static func customLabelStyle(switchConfig: PagoSwitchConfig) -> PagoLabeledSwitchStyle {
        
        var labeledSwitchStyle = PagoLabeledSwitchStyle()
        if let primaryCheckedColorHex = switchConfig.primaryCheckedColor?.colorHex {
            let primaryCheckedColor = UIColor.Pago.custom(primaryCheckedColorHex)
            labeledSwitchStyle.switchStyle = PagoSwitchStyle(color: primaryCheckedColor)
        }
        let labelStyles = PagoUIConfigurator.customConfig.labelStyles
        if let fontConfig = labelStyles[switchConfig.textLabelStyleKey] {
            let weight = (fontConfig.fontStyle == .regular) ? UIFont.Weight.regular : UIFont.Weight.bold
            let sizeConfig = fontConfig.textSize ?? 12
            if let colorHex = fontConfig.textColor?.colorHex {
                labeledSwitchStyle.labelStyle.textColorType = UIColor.Pago.custom(colorHex)
            }
            let fontType = UIFont.Pago.customConfig(CGFloat(sizeConfig), weight)
            labeledSwitchStyle.labelStyle.fontType = fontType
        }
        return labeledSwitchStyle
    }
}
