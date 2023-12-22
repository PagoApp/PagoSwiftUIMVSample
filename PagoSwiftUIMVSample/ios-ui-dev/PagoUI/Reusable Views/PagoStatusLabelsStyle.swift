//
//  PagoStatusLabelsStyle.swift
//  PagoUISDK
//
//  Created by Alex Udrea on 03.04.2023.
//
import Foundation
import UIKit

public struct PagoStatusLabelsStyle {

    private static var _custom: PagoStatusLabelsStyle?
    public static var custom: PagoStatusLabelsStyle {
        if _custom == nil { _custom = PagoStatusLabelsStyle.configureLabels() }
        return _custom!
    }
    
    public var incompleteLabelStyle : PagoLabelStyle
    public var editableLabelStyle: PagoLabelStyle
    public var warningLabelStyle: PagoLabelStyle
    public var normalLabelStyle: PagoLabelStyle
    
    public init(incompleteLabelStyle: PagoLabelStyle, editableLabelStyle: PagoLabelStyle, warningLabelStyle: PagoLabelStyle, normalLabelStyle: PagoLabelStyle) {
        self.incompleteLabelStyle = incompleteLabelStyle
        self.editableLabelStyle = editableLabelStyle
        self.warningLabelStyle = warningLabelStyle
        self.normalLabelStyle = normalLabelStyle
    }
    
    public static func resetStatusLabelsStyle() {
        _custom = nil
    }

}

extension PagoStatusLabelsStyle {
    public static func configureLabels() -> PagoStatusLabelsStyle {
        let statusLabelsConfig = PagoUIConfigurator.customConfig.statusLabels

        var incompleteStyle = PagoLabelStyle(textColorType: .sdkButtonTitleColor, fontType: .regular14, backgroundColorType: .sdkButtonColor, borderStyle: nil, cornerRadius: 14)
        
        var backgroundColor = UIColor.Pago.sdkButtonColor
        if let backgroundColorHex = statusLabelsConfig.incompleteState.backgroundColor.colorSolidHex {
            backgroundColor = UIColor.Pago.custom(backgroundColorHex)
        }
        incompleteStyle.backgroundColorType = backgroundColor
        
        var cornerRadius: Int  = statusLabelsConfig.incompleteState.cornerRadius
        incompleteStyle.cornerRadius = cornerRadius
        
        var borderColorType : UIColor.Pago = .clear
        var borderColorWidth : CGFloat = 0
        if let borderColorHex = statusLabelsConfig.incompleteState.border.color?.colorHex, let borderWidth = statusLabelsConfig.incompleteState.border.width{
            borderColorType = .custom(borderColorHex)
            borderColorWidth = CGFloat(borderWidth)
        }
        if borderColorWidth > 0 {
            incompleteStyle.borderStyle = BorderStyle(colorType: borderColorType, width: borderColorWidth)
        }
        
        let labelStyles = PagoUIConfigurator.customConfig.labelStyles
        var textStyleKey = statusLabelsConfig.incompleteState.textStyleKey
        if  let fontConfig = labelStyles[textStyleKey] {
            let weight: UIFont.Weight = (fontConfig.fontStyle == .regular) ? .regular : .bold
            let sizeConfig = fontConfig.textSize ?? 12
            if let colorHex = fontConfig.textColor?.colorHex {
                incompleteStyle.textColorType = UIColor.Pago.custom(colorHex)
            }
            incompleteStyle.fontType = UIFont.Pago.customConfig(CGFloat(sizeConfig), weight)
        }

        var editableStyle = PagoLabelStyle(textColorType: .sdkDarkGray, fontType: .regular14, backgroundColorType: .white, borderStyle: BorderStyle(colorType: .sdkLightGray, width: 1), cornerRadius: 14)
        
        backgroundColor = UIColor.Pago.sdkButtonColor
        if let backgroundColorHex = statusLabelsConfig.editableState.backgroundColor.colorSolidHex {
            backgroundColor = UIColor.Pago.custom(backgroundColorHex)
        }
        editableStyle.backgroundColorType = backgroundColor
        
        cornerRadius = statusLabelsConfig.editableState.cornerRadius
        editableStyle.cornerRadius = Int(cornerRadius)
        
        if let borderColorHex = statusLabelsConfig.editableState.border.color?.colorHex, let borderWidth = statusLabelsConfig.editableState.border.width{
            borderColorType = .custom(borderColorHex)
            borderColorWidth = CGFloat(borderWidth)
        }
        if borderColorWidth > 0 {
            editableStyle.borderStyle = BorderStyle(colorType: borderColorType, width: borderColorWidth)
        }
        
        textStyleKey = statusLabelsConfig.editableState.textStyleKey
        if  let fontConfig = labelStyles[textStyleKey] {
            let weight: UIFont.Weight = (fontConfig.fontStyle == .regular) ? .regular : .bold
            let sizeConfig = fontConfig.textSize ?? 12
            if let colorHex = fontConfig.textColor?.colorHex {
                editableStyle.textColorType = UIColor.Pago.custom(colorHex)
            }
            editableStyle.fontType = UIFont.Pago.customConfig(CGFloat(sizeConfig), weight)
        }
        
        var warningStyle = PagoLabelStyle(textColorType: .sdkDarkRed, fontType: .regular14, backgroundColorType: .sdkBgRed, borderStyle: nil, cornerRadius: 14)
        
        backgroundColor = UIColor.Pago.sdkButtonColor
        if let backgroundColorHex = statusLabelsConfig.warningState.backgroundColor.colorSolidHex {
            backgroundColor = UIColor.Pago.custom(backgroundColorHex)
        }
        warningStyle.backgroundColorType = backgroundColor
        
        cornerRadius = statusLabelsConfig.warningState.cornerRadius
        warningStyle.cornerRadius = Int(cornerRadius)
        
        if let borderColorHex = statusLabelsConfig.incompleteState.border.color?.colorHex, let borderWidth = statusLabelsConfig.incompleteState.border.width{
            borderColorType = .custom(borderColorHex)
            borderColorWidth = CGFloat(borderWidth)
        }
        if borderColorWidth > 0 {
            warningStyle.borderStyle = BorderStyle(colorType: borderColorType, width: borderColorWidth)
        }
        
        textStyleKey = statusLabelsConfig.warningState.textStyleKey
        if  let fontConfig = labelStyles[textStyleKey] {
            let weight: UIFont.Weight = (fontConfig.fontStyle == .regular) ? .regular : .bold
            let sizeConfig = fontConfig.textSize ?? 12
            if let colorHex = fontConfig.textColor?.colorHex {
                warningStyle.textColorType = UIColor.Pago.custom(colorHex)
            }
            warningStyle.fontType = UIFont.Pago.customConfig(CGFloat(sizeConfig), weight)
        }
        
        
        var normalStyle = PagoLabelStyle(textColorType: .sdkDarkGray, fontType: .regular14, backgroundColorType: .sdkLightBgGray, borderStyle: nil, cornerRadius: 14)
        
        backgroundColor = UIColor.Pago.sdkButtonColor
        if let backgroundColorHex = statusLabelsConfig.normalState.backgroundColor.colorSolidHex {
            backgroundColor = UIColor.Pago.custom(backgroundColorHex)
        }
        normalStyle.backgroundColorType = backgroundColor
        
        cornerRadius = statusLabelsConfig.normalState.cornerRadius

        normalStyle.cornerRadius = Int(cornerRadius)
        
        if let borderColorHex = statusLabelsConfig.normalState.border.color?.colorHex, let borderWidth = statusLabelsConfig.normalState.border.width{
            borderColorType = .custom(borderColorHex)
            borderColorWidth = CGFloat(borderWidth)
        }
        if borderColorWidth > 0 {
            normalStyle.borderStyle = BorderStyle(colorType: borderColorType, width: borderColorWidth)
        }
        textStyleKey = statusLabelsConfig.normalState.textStyleKey
        if  let fontConfig = labelStyles[textStyleKey] {
            let weight: UIFont.Weight = (fontConfig.fontStyle == .regular) ? .regular : .bold
            let sizeConfig = fontConfig.textSize ?? 12
            if let colorHex = fontConfig.textColor?.colorHex {
                normalStyle.textColorType = UIColor.Pago.custom(colorHex)
            }
            normalStyle.fontType = UIFont.Pago.customConfig(CGFloat(sizeConfig), weight)
        }
        
        return PagoStatusLabelsStyle(incompleteLabelStyle: incompleteStyle, editableLabelStyle: editableStyle, warningLabelStyle: warningStyle, normalLabelStyle: normalStyle)
    }
}
