//
//  PagoCheckboxStyle.swift
//  Pago
//
//  Created by Gabi Chiosa on 29/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

public enum PagoCheckboxType {
    case circleSingle, circleMultiple, roundedSquare
}
public enum PagoCheckBoxSize {
    case small, large, custom(value: Int)
    public var size: Int {
        switch self {
        case .small:
             return 16
        case .large:
            return 24
        case .custom(let value):
            return value
        }
    }
}

public enum PagoCheckboxState {
    case selectedState, deselectedState, errorState, disabledState
}

public struct PagoCheckboxCustomStyle {

    public let textStyle: PagoLabelStyle
    public let errorTextStyle: PagoLabelStyle
    public let checkedColor: UIColor.Pago
    public let uncheckedColor: UIColor.Pago
    public let errorColor: UIColor.Pago
    public let cornerRadius: Int
    public let backgroundColor: UIColor.Pago
    public let disabledBackgroundColor: UIColor.Pago
    public let errorBackgroundColor: UIColor.Pago

	public init(textStyle: PagoLabelStyle, errorTextStyle: PagoLabelStyle, checkedColor: UIColor.Pago, uncheckedColor: UIColor.Pago, errorColor: UIColor.Pago, cornerRadius: Int, backgroundColor: UIColor.Pago, disabledBackgroundColor: UIColor.Pago, errorBackgroundColor: UIColor.Pago) {
        self.textStyle = textStyle
        self.errorTextStyle = errorTextStyle
        self.checkedColor = checkedColor
        self.uncheckedColor = uncheckedColor
        self.errorColor = errorColor
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.disabledBackgroundColor = disabledBackgroundColor
        self.errorBackgroundColor = errorBackgroundColor
	}
}

public struct PagoCheckboxStateStyle: BaseStyle {

    public let state: PagoCheckboxState
    public let imageData: DataImageModel
    public let imageColorType: UIColor.Pago
    public let fontColorType: UIColor.Pago
    public let fontType: UIFont.Pago
    public var backgroundColor: UIColor.Pago = .clear

    public init(state: PagoCheckboxState, imageData: DataImageModel, imageColorType: UIColor.Pago, fontColorType: UIColor.Pago, fontType: UIFont.Pago, backgroundColor: UIColor.Pago = .clear) {

        self.state = state
        self.imageData = imageData
        self.imageColorType = imageColorType
        self.fontColorType = fontColorType
        self.fontType = fontType
        self.backgroundColor = backgroundColor
    }
}

public struct PagoCheckboxStyle: BaseStyle {

    public let selectedStateStyle: PagoCheckboxStateStyle
    public var deselectedStateStyle: PagoCheckboxStateStyle
    public var errorStateStyle: PagoCheckboxStateStyle?
    public var disabledStateStyle: PagoCheckboxStateStyle?
    private static var _custom: PagoCheckboxCustomStyle?
    public static var customStyle: PagoCheckboxCustomStyle {
        if _custom == nil { _custom = PagoCheckboxStyle.getCustomStyle(checkbox: PagoUIConfigurator.customConfig.checkbox) }
        return _custom!
    }
    public let imageSize: PagoCheckBoxSize
    public var size: PagoSize? = nil
    public var contentInset: UIEdgeInsets
    public var hasBackground: Bool

    public init(selectedStateStyle: PagoCheckboxStateStyle, deselectedStateStyle: PagoCheckboxStateStyle, errorStateStyle: PagoCheckboxStateStyle? = nil, disabledStateStyle: PagoCheckboxStateStyle? = nil, imageSize: PagoCheckBoxSize, size: PagoSize? = nil, contentInset: UIEdgeInsets = .zero, hasBackground: Bool = false) {

        self.selectedStateStyle = selectedStateStyle
        self.deselectedStateStyle = deselectedStateStyle
        self.errorStateStyle = errorStateStyle
        self.disabledStateStyle = disabledStateStyle
        self.imageSize = imageSize
        self.size = size
        self.contentInset = contentInset
        self.hasBackground = hasBackground

        if hasBackground && contentInset == .zero {
            let inset = CGFloat(PagoUIConfigurator.customConfig.checkbox.backgroundInset)
            self.contentInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        }
    }
    
    public static func resetCheckboxStyle() {
        _custom = nil
    }
}

extension PagoCheckboxStyle {

    public static func stateStyle(for type: PagoCheckboxType, state: PagoCheckboxState) -> PagoCheckboxStateStyle {

        var imageData: DataImageModel
        var imageColor: UIColor.Pago
        var fontColor: UIColor.Pago
        var fontType: UIFont.Pago
        var backgroundColor: UIColor.Pago

        switch state {
        case .selectedState:
            switch type {
            case .roundedSquare:
                imageData = PagoIcon.squareCheckboxSelected.data
            case .circleSingle:
                imageData = PagoIcon.roundCheckboxSingleSelected.data
            case .circleMultiple:
                imageData = PagoIcon.roundCheckboxMultipleSelected.data
            }
            imageColor = PagoCheckboxStyle.customStyle.checkedColor
            fontColor = PagoCheckboxStyle.customStyle.textStyle.textColorType
            fontType = PagoCheckboxStyle.customStyle.textStyle.fontType
            backgroundColor = PagoCheckboxStyle.customStyle.backgroundColor
        case .deselectedState:
            switch type {
            case .roundedSquare:
                imageData = PagoIcon.squareCheckboxDeselected.data
            case .circleSingle, .circleMultiple:
                imageData = PagoIcon.roundCheckboxDeselected.data
            }
            imageColor = PagoCheckboxStyle.customStyle.uncheckedColor
            fontColor = PagoCheckboxStyle.customStyle.textStyle.textColorType
            fontType = PagoCheckboxStyle.customStyle.textStyle.fontType
            backgroundColor = PagoCheckboxStyle.customStyle.backgroundColor
        case .errorState:
            switch type {
            case .roundedSquare:
                imageData = PagoIcon.squareCheckboxDeselected.data
            case .circleSingle, .circleMultiple:
                imageData = PagoIcon.roundCheckboxDeselected.data
            }
            imageColor = PagoCheckboxStyle.customStyle.errorColor
            fontColor = PagoCheckboxStyle.customStyle.errorTextStyle.textColorType
            fontType = PagoCheckboxStyle.customStyle.errorTextStyle.fontType
            backgroundColor = PagoCheckboxStyle.customStyle.errorBackgroundColor
        case .disabledState:
            switch type {
            case .roundedSquare:
                imageData = PagoIcon.squareCheckboxDeselected.data
            case .circleSingle, .circleMultiple:
                imageData = PagoIcon.roundCheckboxDeselected.data
            }
            imageColor = PagoCheckboxStyle.customStyle.uncheckedColor
            fontColor = PagoCheckboxStyle.customStyle.textStyle.textColorType
            fontType = PagoCheckboxStyle.customStyle.textStyle.fontType
            backgroundColor = PagoCheckboxStyle.customStyle.disabledBackgroundColor
        }

        return PagoCheckboxStateStyle(state: state, imageData: imageData, imageColorType: imageColor, fontColorType: fontColor, fontType: fontType, backgroundColor: backgroundColor)
    }
}

extension PagoCheckboxStyle {

    internal static func getCustomStyle(checkbox: PagoCheckboxConfig) -> PagoCheckboxCustomStyle {

        let labelStyles = PagoUIConfigurator.customConfig.labelStyles
        var titleLabelStyle = PagoLabelStyle(textColorType: .sdkBlackBodyText, fontType: .regular14, alignment: .left, numberOfLines: 2)
        if let fontConfig = labelStyles[checkbox.textStyleKey] {
            let weight = (fontConfig.fontStyle == .regular) ? UIFont.Weight.regular : UIFont.Weight.bold
            let sizeConfig = fontConfig.textSize ?? 14
            if let colorHex = fontConfig.textColor?.colorHex {
                titleLabelStyle.textColorType = UIColor.Pago.custom(colorHex)
            }
            titleLabelStyle.fontType = UIFont.Pago.customConfig(CGFloat(sizeConfig), weight)
        }
        var titleLabelErrorStyle = PagoLabelStyle(textColorType: .sdkDarkRed, fontType: .regular14, alignment: .left, numberOfLines: 2)
        if let fontConfig = labelStyles[checkbox.errorTextStyleKey] {
            let weight = (fontConfig.fontStyle == .regular) ? UIFont.Weight.regular : UIFont.Weight.bold
            let sizeConfig = fontConfig.textSize ?? 14
            if let colorHex = fontConfig.textColor?.colorHex {
                titleLabelErrorStyle.textColorType = UIColor.Pago.custom(colorHex)
            }
            titleLabelErrorStyle.fontType = UIFont.Pago.customConfig(CGFloat(sizeConfig), weight)
        }
        var checkedColor = UIColor.Pago.sdkMainButtonColor
        if let colorHex = checkbox.checkedColor?.colorHex {
            checkedColor = UIColor.Pago.custom(colorHex)
        }
        var uncheckedColor = UIColor.Pago.sdkCheckBoxLightGray
        if let colorHex = checkbox.uncheckedColor?.colorHex {
            uncheckedColor = UIColor.Pago.custom(colorHex)
        }
        var errorColor = UIColor.Pago.sdkDarkRed
        if let colorHex = checkbox.errorColor?.colorHex {
            errorColor = UIColor.Pago.custom(colorHex)
        }
        var cornerRadius: Int = 8
        cornerRadius = checkbox.cornerRadius
        var backgroundColor = UIColor.Pago.sdkButtonColor
        if let colorHex = checkbox.backgroundColor?.colorSolidHex {
            backgroundColor = UIColor.Pago.custom(colorHex)
        }
        var disabledBackgroundColor = UIColor.Pago.sdkLightBgGray
        if let colorHex = checkbox.disabledBackgroundColor?.colorSolidHex {
            disabledBackgroundColor = UIColor.Pago.custom(colorHex)
        }
        var errorBackgroundColor = UIColor.Pago.sdkBgRed
        if let colorHex = checkbox.errorBackgroundColor?.colorSolidHex {
            errorBackgroundColor = UIColor.Pago.custom(colorHex)
        }
        return PagoCheckboxCustomStyle(textStyle: titleLabelStyle, errorTextStyle: titleLabelErrorStyle, checkedColor: checkedColor, uncheckedColor: uncheckedColor, errorColor: errorColor, cornerRadius: cornerRadius, backgroundColor: backgroundColor, disabledBackgroundColor: disabledBackgroundColor, errorBackgroundColor: errorBackgroundColor)
    }
}
