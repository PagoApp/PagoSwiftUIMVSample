//
//  PagoTextFieldStyle.swift
//  Pago
//
//  Created by Gabi Chiosa on 29/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation

public struct PagoTextFieldStyle {

    private static var _custom: PagoTextFieldStyle?
    public static var custom: PagoTextFieldStyle {
        if _custom == nil {
            _custom = PagoTextFieldStyle.customConfig()
        }
        return _custom!
    }
    public var isTitleUppercased: Bool = true
    public var backgroundColor: UIColor.Pago = .white
    public var iconBackgroundColor: UIColor.Pago = .sdkLightBgYellow
    public var textAnimationDuration = 0.3
    public var textErrorColor = UIColor.Pago.sdkDarkRed
    public var textDetailColor = UIColor.Pago.sdkLightGray
    public var titleColor = UIColor.Pago.sdkLightGray
    public var titleInvalidColor = UIColor.Pago.sdkDarkRed
    public var placeholderColor = UIColor.Pago.sdkLightGray
    public var textFieldColor = UIColor.Pago.sdkDarkGray
    public var textFieldInvalidColor = UIColor.Pago.sdkDarkRed
    public var textFieldDefaultLineColor = UIColor.Pago.sdkLightGray
    public var textFieldInvalidLineColor = UIColor.Pago.sdkDarkRed
    public var titleFont = UIFont.Pago.regular12
    public var detailFont = UIFont.Pago.regular12
    public var textFieldFont = UIFont.Pago.regular16
    public var textFieldOffset: CGFloat = 8
    public var textFieldContentType = UITextContentType(rawValue: "")
    public var textFieldAlignment: NSTextAlignment = .left
    public var detailNumberOfLines = 2
    public var autocapitalizationType: UITextAutocapitalizationType = .none
    public var autocorrectionType: UITextAutocorrectionType = .default
    public var keyboardType: UIKeyboardType = .default
    public var isSecureTextEntry: Bool = false
    public var isUserInteractionEnabled: Bool = true
    public var returnKeyType: UIReturnKeyType  = .next
    public var borderStyle: BorderStyle?
    public var isHidden: Bool = false
    public var titleSpace: CGFloat = 8
    public var toolbarButton: UIBarButtonItem.SystemItem?
    public var datePickerStyle: PagoTextFieldDatePickerStyle? = nil
    public var shadowStyle: ShadowStyle? = nil
    public var cornerRadius: CGFloat = 12
    
    public init(isTitleUppercased: Bool = true,
                backgroundColor: UIColor.Pago = .white,
                iconBackgroundColor: UIColor.Pago = .sdkLightBgYellow,
                textDetailColor: UIColor.Pago = UIColor.Pago.sdkLightGray,
                titleColor: UIColor.Pago = UIColor.Pago.sdkLightGray,
                titleInvalidColor: UIColor.Pago = .sdkDarkRed,
                placeholderColor: UIColor.Pago = UIColor.Pago.sdkLightGray,
                textFieldColor: UIColor.Pago = UIColor.Pago.sdkDarkGray,
                textFieldInvalidColor: UIColor.Pago = UIColor.Pago.sdkDarkRed,
                textFieldDefaultLineColor: UIColor.Pago = UIColor.Pago.sdkLightGray,
                textFieldInvalidLineColor: UIColor.Pago = UIColor.Pago.sdkDarkRed,
                titleFont: UIFont.Pago = UIFont.Pago.regular12,
                detailFont: UIFont.Pago = UIFont.Pago.regular12,
                textFieldContentType: UITextContentType = UITextContentType(rawValue: ""),
                textFieldFont: UIFont.Pago = UIFont.Pago.regular16,
                textFieldAlignment: NSTextAlignment = .left,
                detailNumberOfLines: Int = 2,
                autocorrectionType : UITextAutocorrectionType = .default,
                autocapitalizationType: UITextAutocapitalizationType = .none,
                keyboardType: UIKeyboardType = .default,
                isSecureTextEntry: Bool = false,
                isUserInteractionEnabled: Bool = true,
                returnKeyType: UIReturnKeyType  = .next,
                borderStyle: BorderStyle? = nil,
                isHidden: Bool = false,
                titleSpace: CGFloat = 8,
                toolbarButton: UIBarButtonItem.SystemItem? = nil,
                datePickerStyle: PagoTextFieldDatePickerStyle? = nil,
                shadowStyle: ShadowStyle? = nil,
                cornerRadius: CGFloat = 12) {
        
        self.isTitleUppercased = isTitleUppercased
        self.backgroundColor = backgroundColor
        self.iconBackgroundColor = iconBackgroundColor
        self.textDetailColor = textDetailColor
        self.titleColor = titleColor
        self.titleInvalidColor = titleInvalidColor
        self.placeholderColor = placeholderColor
        self.textFieldColor = textFieldColor
        self.textFieldInvalidColor = textFieldInvalidColor
        self.textFieldDefaultLineColor = textFieldDefaultLineColor
        self.textFieldInvalidLineColor = textFieldInvalidLineColor
        self.titleFont = titleFont
        self.detailFont = detailFont
        self.textFieldFont = textFieldFont
        self.textFieldContentType = textFieldContentType
        self.textFieldAlignment = textFieldAlignment
        self.detailNumberOfLines = detailNumberOfLines
        self.autocorrectionType = autocorrectionType
        self.autocapitalizationType = autocapitalizationType
        self.keyboardType = keyboardType
        self.isSecureTextEntry = isSecureTextEntry
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.returnKeyType = returnKeyType
        self.borderStyle = borderStyle
        self.isHidden = isHidden
        self.titleSpace = titleSpace
        self.toolbarButton = toolbarButton
        self.datePickerStyle = datePickerStyle
        self.shadowStyle = shadowStyle
        self.cornerRadius = cornerRadius
    }
    
    //NOTE: used when changing the theme
    public static func resetTextField() {
        _custom = nil
    }
}

public struct PagoTextFieldDatePickerStyle {
    public var current: Date = Date()
    public let minDate: Date?
    public let maxDate: Date?
    
    public init(current: Date = Date(), minDate: Date? = nil, maxDate: Date? = nil) {
        
        self.minDate = minDate
        self.maxDate = maxDate
        self.current = current
    }
}

extension PagoTextFieldStyle {
    
    public init(textFieldContentType: UITextContentType = UITextContentType(rawValue: ""),
                textFieldAlignment: NSTextAlignment = .left,
                detailNumberOfLines: Int = 2,
                autocorrectionType : UITextAutocorrectionType = .default,
                autocapitalizationType: UITextAutocapitalizationType = .none,
                keyboardType: UIKeyboardType = .default,
                isSecureTextEntry: Bool = false,
                isUserInteractionEnabled: Bool = true,
                returnKeyType: UIReturnKeyType  = .next,
                isHidden: Bool = false,
                titleSpace: CGFloat = 8,
                toolbarButton: UIBarButtonItem.SystemItem? = nil,
                datePickerStyle: PagoTextFieldDatePickerStyle? = nil) {
        
        self = PagoTextFieldStyle.custom
        self.textFieldContentType = textFieldContentType
        self.textFieldAlignment = textFieldAlignment
        self.detailNumberOfLines = detailNumberOfLines
        self.autocorrectionType = autocorrectionType
        self.autocapitalizationType = autocapitalizationType
        self.keyboardType = keyboardType
        self.isSecureTextEntry = isSecureTextEntry
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.returnKeyType = returnKeyType
        self.isHidden = isHidden
        self.titleSpace = titleSpace
        self.toolbarButton = toolbarButton
        self.datePickerStyle = datePickerStyle
    }
    
    public static func customConfig() -> PagoTextFieldStyle {
        
        var textFieldStyle = PagoTextFieldStyle(isTitleUppercased: true,
                                                backgroundColor: .white,
                                                textDetailColor: UIColor.Pago.sdkLightGray,
                                                titleColor: UIColor.Pago.sdkLightGray,
                                                titleInvalidColor: .sdkDarkRed,
                                                placeholderColor: UIColor.Pago.sdkLightGray,
                                                textFieldColor: UIColor.Pago.sdkDarkGray,
                                                textFieldInvalidColor: UIColor.Pago.sdkDarkRed,
                                                textFieldDefaultLineColor: UIColor.Pago.sdkLightGray,
                                                textFieldInvalidLineColor: UIColor.Pago.sdkDarkRed,
                                                titleFont: UIFont.Pago.regular12,
                                                detailFont: UIFont.Pago.regular12,
                                                textFieldContentType: UITextContentType(rawValue: ""),
                                                textFieldFont: UIFont.Pago.regular16,
                                                textFieldAlignment: .left,
                                                detailNumberOfLines: 2,
                                                autocorrectionType : .default,
                                                autocapitalizationType: .none,
                                                keyboardType: .default,
                                                isSecureTextEntry: false,
                                                isUserInteractionEnabled: true,
                                                returnKeyType: .next,
                                                borderStyle: nil,
                                                isHidden: false,
                                                titleSpace:  8,
                                                toolbarButton: nil,
                                                datePickerStyle: nil,
                                                shadowStyle: nil,
                                                cornerRadius: 12)
        
        let textfieldConfig = PagoUIConfigurator.customConfig.input
        let labelStyles = PagoUIConfigurator.customConfig.labelStyles
        if let titleStyle = labelStyles[textfieldConfig.topHintStyleKey],
            let isAllCaps = titleStyle.isAllCaps {
            textFieldStyle.isTitleUppercased = isAllCaps
        }
        if let iconBackgroundColorHex = textfieldConfig.iconBackgroundColor.colorSolidHex {
            textFieldStyle.iconBackgroundColor = UIColor.Pago.custom(iconBackgroundColorHex)
        }
        if let fontConfig = labelStyles[textfieldConfig.topHintStyleKey] {
            let weight = (fontConfig.fontStyle == .regular) ? UIFont.Weight.regular : UIFont.Weight.bold
            if let colorHex = fontConfig.textColor?.colorHex,
               let sizeConfig = fontConfig.textSize {
                let textFontColor = UIColor.Pago.custom(colorHex)
                let textFontType = UIFont.Pago.customConfig(CGFloat(sizeConfig), weight)
                textFieldStyle.placeholderColor = textFontColor
                textFieldStyle.titleColor = textFontColor
                textFieldStyle.titleFont = textFontType
            }
        }
        if let fontConfig = labelStyles[textfieldConfig.inputStyleKey] {
            let weight = (fontConfig.fontStyle == .regular) ? UIFont.Weight.regular : UIFont.Weight.bold
            if let colorHex = fontConfig.textColor?.colorHex,
               let sizeConfig = fontConfig.textSize {
                let inputTextColor = UIColor.Pago.custom(colorHex)
                let inputFontType = UIFont.Pago.customConfig(CGFloat(sizeConfig), weight)
                textFieldStyle.textFieldColor = inputTextColor
                textFieldStyle.textFieldFont = inputFontType
            }
        }
        if let fontConfig = labelStyles[textfieldConfig.errorStyleKey] {
            if let colorHex = fontConfig.textColor?.colorHex {
                let textErrorColor = UIColor.Pago.custom(colorHex)
                textFieldStyle.textFieldInvalidColor = textErrorColor
                textFieldStyle.textErrorColor = textErrorColor
            }
        }
        if let underlineColorHex = textfieldConfig.underlineColor.colorHex {
            textFieldStyle.textFieldDefaultLineColor = UIColor.Pago.custom(underlineColorHex)
        }
        if let underlineErrorColorHex = textfieldConfig.underlineErrorColor.colorHex {
            textFieldStyle.textFieldInvalidLineColor = UIColor.Pago.custom(underlineErrorColorHex)
        }
        textFieldStyle.cornerRadius = CGFloat(textfieldConfig.cornerRadius)
        if let borderColorHex = textfieldConfig.border.color?.colorHex,
           let width = textfieldConfig.border.width {
            let borderColor = UIColor.Pago.custom(borderColorHex)
            let borderWidth = CGFloat(width)
            textFieldStyle.borderStyle = BorderStyle(colorType: borderColor, width: borderWidth)
        }
        if let radius = textfieldConfig.shadow.blur,
           let offsetConfig = textfieldConfig.shadow.offset {
            let offset = CGSize(width: Double(offsetConfig), height: Double(offsetConfig))
            textFieldStyle.shadowStyle = ShadowStyle(radius: Double(radius)/2, offset: offset)
        }
        return textFieldStyle
    }
}
