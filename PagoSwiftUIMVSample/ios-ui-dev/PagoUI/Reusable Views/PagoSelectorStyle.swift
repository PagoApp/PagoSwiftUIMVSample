//
//  PagoSelectorStyle.swift
//  PagoUISDK
//
//  Created by Bogdan on 31.03.2023.
//

import Foundation
import UIKit

public struct PagoSelectorStyle {
    
    private static var _custom: PagoSelectorStyle?
    public static var custom: PagoSelectorStyle {
        if _custom == nil {
            _custom = PagoSelectorStyle.customConfig()
        }
        return _custom!
    }
    public var selectorStyle: PagoTextFieldStyle
    public var selectorIconColor: UIColor.Pago
    public var selectorFilledLabelStyle: PagoLabelStyle
    public var selectorTitleLabelStyle: PagoLabelStyle
    public var selectorHintLabelStyle: PagoLabelStyle
    public var selectorErrorLabelStyle: PagoLabelStyle
    
    init(selectorStyle: PagoTextFieldStyle, selectorIconColor: UIColor.Pago, selectorFilledLabelStyle: PagoLabelStyle, selectorTitleLabelStyle: PagoLabelStyle, selectorHintLabelStyle: PagoLabelStyle, selectorErrorLabelStyle: PagoLabelStyle) {
        self.selectorStyle = selectorStyle
        self.selectorIconColor = selectorIconColor
        self.selectorFilledLabelStyle = selectorFilledLabelStyle
        self.selectorTitleLabelStyle = selectorTitleLabelStyle
        self.selectorHintLabelStyle = selectorHintLabelStyle
        self.selectorErrorLabelStyle = selectorErrorLabelStyle
    }
    
    //NOTE: used when changing the theme
    public static func resetSelector() {
        _custom = nil
    }
}

extension PagoSelectorStyle {
    
    static func customConfig() -> PagoSelectorStyle {
        
        let selectorTextFieldStyle = PagoTextFieldStyle(isTitleUppercased: false, backgroundColor: .white, textDetailColor: .sdkLightGray, titleColor: .sdkLightGray, titleInvalidColor: .sdkDarkRed, placeholderColor: .sdkLightGray, textFieldColor: .sdkDarkGray, textFieldInvalidColor: .sdkDarkRed, textFieldDefaultLineColor: .sdkLightGray, textFieldInvalidLineColor: .sdkDarkRed, titleFont: .regular12, detailFont: .regular12, shadowStyle: ShadowStyle(), cornerRadius: 10)
        let selectorIconColor = UIColor.Pago.sdkLightGray
        let selectorFilledLabelStyle = PagoLabelStyle(textColorType: .sdkLightGray, fontType: .regular12)
        let selectorTitleLabelStyle = PagoLabelStyle(textColorType: .sdkLightGray, fontType: .regular12)
        let selectorHintLabelStyle = PagoLabelStyle(textColorType: .sdkLightGray, fontType: .regular16)
        let selectorErrorLabelStyle = PagoLabelStyle(textColorType: .redNegative, fontType: .regular12)
        var selectorStyle = PagoSelectorStyle(selectorStyle: selectorTextFieldStyle, selectorIconColor: selectorIconColor, selectorFilledLabelStyle: selectorFilledLabelStyle, selectorTitleLabelStyle: selectorTitleLabelStyle, selectorHintLabelStyle: selectorHintLabelStyle, selectorErrorLabelStyle: selectorErrorLabelStyle)
        let selector = PagoUIConfigurator.customConfig.selector
        let labelStyles = PagoUIConfigurator.customConfig.labelStyles
        if let fontKey = selector.filledLabelStyleKey,
           let fontConfig = labelStyles[fontKey] {
            let weight = (fontConfig.fontStyle == .regular) ? UIFont.Weight.regular : UIFont.Weight.bold
            let sizeConfig = fontConfig.textSize ?? 16
            if let colorHex = fontConfig.textColor?.colorHex {
                selectorStyle.selectorFilledLabelStyle.textColorType = UIColor.Pago.custom(colorHex)
            }
            selectorStyle.selectorFilledLabelStyle.fontType = UIFont.Pago.customConfig(CGFloat(sizeConfig), weight)
        }
        if let fontKey = selector.titleLabelStyleKey,
           let fontConfig = labelStyles[fontKey] {
            let weight = (fontConfig.fontStyle == .regular) ? UIFont.Weight.regular : UIFont.Weight.bold
            let sizeConfig = fontConfig.textSize ?? 12
            if let colorHex = fontConfig.textColor?.colorHex {
                selectorStyle.selectorTitleLabelStyle.textColorType = UIColor.Pago.custom(colorHex)
            }
            selectorStyle.selectorTitleLabelStyle.fontType = UIFont.Pago.customConfig(CGFloat(sizeConfig), weight)
        }
        if let fontKey = selector.hintLabelStyleKey,
           let fontConfig = labelStyles[fontKey] {
            let weight = (fontConfig.fontStyle == .regular) ? UIFont.Weight.regular : UIFont.Weight.bold
            let sizeConfig = fontConfig.textSize ?? 16
            if let colorHex = fontConfig.textColor?.colorHex {
                selectorStyle.selectorHintLabelStyle.textColorType = UIColor.Pago.custom(colorHex)
            }
            selectorStyle.selectorHintLabelStyle.fontType = UIFont.Pago.customConfig(CGFloat(sizeConfig), weight)
        }
        if let fontKey = selector.errorLabelStyleKey,
           let fontConfig = labelStyles[fontKey] {
            let weight = (fontConfig.fontStyle == .regular) ? UIFont.Weight.regular : UIFont.Weight.bold
            let sizeConfig = fontConfig.textSize ?? 12
            if let colorHex = fontConfig.textColor?.colorHex {
                selectorStyle.selectorErrorLabelStyle.textColorType = UIColor.Pago.custom(colorHex)
            }
            selectorStyle.selectorErrorLabelStyle.fontType = UIFont.Pago.customConfig(CGFloat(sizeConfig), weight)
        }
        if let iconColorHex = selector.iconColor?.colorHex {
            selectorStyle.selectorIconColor = UIColor.Pago.custom(iconColorHex)
        }
        if let colorHex = selector.backgroundColor?.colorSolidHex {
            selectorStyle.selectorStyle.backgroundColor = UIColor.Pago.custom(colorHex)
        }
        if let cornerRadius = selector.cornerRadius {
            selectorStyle.selectorStyle.cornerRadius = CGFloat(cornerRadius)
        }
        if let borderColorHex = selector.border?.color?.colorHex,
           let width = selector.border?.width {
            let borderColor = UIColor.Pago.custom(borderColorHex)
            let borderWidth = CGFloat(width)
            selectorStyle.selectorStyle.borderStyle = BorderStyle(colorType: borderColor, width: borderWidth)
        }
        if let shadowConfig = selector.shadow {
            let radius = Double(shadowConfig.blur ?? 0)/2
            let offsetConfig = Double(shadowConfig.offset ?? 0)
            let offset = CGSize(width: offsetConfig, height: offsetConfig)
            selectorStyle.selectorStyle.shadowStyle = ShadowStyle(radius: radius, offset: offset)
        }
        return selectorStyle
    }
}
