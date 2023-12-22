//
//  PagoButtonStyle.swift
//  Pago
//
//  Created by Gabi Chiosa on 19/07/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import Foundation
import UIKit

public struct PagoButtonStyle {
    
    public var font: UIFont.Pago = .regular15
    public var textColor: UIColor.Pago
    public var backgroundColor: UIColor.Pago
    public var startBackgroundColor: UIColor.Pago?
    public var endBackgroundColor: UIColor.Pago?
    public var cornerRadius: Int = 0
    public var isUnderlined: Bool = false
    public var placeholderStyle: HighlightedStyle?
    public var shadowStyle: ShadowStyle?
    public var borderStyle: BorderStyle?
    public var numberOfLines: Int = 0
    public var upperCase: Bool = false
    public var horizontalMargins: Int = 24
    public var height: CGFloat?
    public var width: CGFloat?
    
    public init(font: UIFont.Pago = .regular16, textColor: UIColor.Pago = .sdkLightGray, backgroundColor: UIColor.Pago = .clear, startBackgroundColor: UIColor.Pago? = nil, endBackgroundColor: UIColor.Pago? = nil, cornerRadius: Int = 0, isUnderlined: Bool = false, placeholderStyle: HighlightedStyle? = nil, shadowStyle: ShadowStyle? = nil, borderStyle: BorderStyle? = nil, numberOfLines: Int = 0, upperCase: Bool = false, horizontalMargins: Int = 24, height: CGFloat? = nil, width: CGFloat? = nil) {
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.startBackgroundColor = startBackgroundColor
        self.endBackgroundColor = endBackgroundColor
        self.cornerRadius = cornerRadius
        self.isUnderlined = isUnderlined
        self.placeholderStyle = placeholderStyle
        self.shadowStyle = shadowStyle
        self.borderStyle = borderStyle
        self.numberOfLines = numberOfLines
        self.upperCase = upperCase
        self.horizontalMargins = horizontalMargins
        self.width = width
        self.height = height
    }

}

public struct HighlightedStyle {
    public var colorType: UIColor.Pago
    public var fontType: UIFont.Pago
    public var isUnderlined: Bool = false
    
    public init(colorType: UIColor.Pago, fontType: UIFont.Pago, isUnderlined: Bool = false) {
        
        self.colorType = colorType
        self.fontType = fontType
        self.isUnderlined = isUnderlined
    }
}


public struct BorderStyle {
    public var colorType: UIColor.Pago = .dividers
    public var width: CGFloat = 2
    
    public init(colorType: UIColor.Pago = .dividers, width: CGFloat = 2) {
        self.colorType = colorType
        self.width = width
    }
}

public struct ShadowStyle {
    public var opacity: Float = 0.2
    public var radius: CGFloat = 3
    public var offset: CGSize = CGSize(width: 0.0, height: 3.0)
    public var colorType: UIColor.Pago = .blackBodyText
    
    public init(opacity: Float = 0.1, radius: CGFloat = 4, offset: CGSize = CGSize(width: 0.0, height: 0.0), colorType: UIColor.Pago = .blackBodyText) {
        self.opacity = opacity
        self.radius = radius
        self.offset = offset
        self.colorType = colorType
    }
}

public extension PagoButtonStyle {
    
    enum Pago: CaseIterable {
        case mainActive, mainInactive, secondaryActive, tertiaryActive, tertiaryInactive, secondaryInactive, underlinedActive, underlinedInactive, mainRed, primarySmall, warningSmall, white, attention
    }
    
    static func style(for type: Pago, isSelfSized: Bool = false) -> PagoButtonStyle {
        
        let buttonsConfig = PagoUIConfigurator.customConfig.buttons
        switch type {
        case .mainInactive:
            return customStyle(buttonConfig: buttonsConfig.deactivatedButton, defaultHeight: 48)
        case .mainActive, .secondaryInactive:
            return customStyle(buttonConfig: buttonsConfig.primaryButton, defaultHeight: 48)
        case .secondaryActive:
            return customStyle(buttonConfig: buttonsConfig.secondaryButton, defaultHeight: 48)
        case .tertiaryActive:
            return customStyle(buttonConfig: buttonsConfig.tertiaryButton)
        case .tertiaryInactive:
            return customStyle(buttonConfig: buttonsConfig.tertiaryDeactivatedButton)
        case .underlinedActive:
            return PagoButtonStyle(font: .semiBold17, textColor: .blueHighlight, backgroundColor: .clear, isUnderlined: true)
        case .underlinedInactive:
            return PagoButtonStyle(font: .semiBold17, textColor: .grayTertiaryText, backgroundColor: .clear, isUnderlined: true)
        case .mainRed:
            return customStyle(buttonConfig: buttonsConfig.warningButton, defaultHeight: 48)
        case .primarySmall:
            return customStyle(buttonConfig: buttonsConfig.primarySmallButton)
        case .warningSmall:
            return customStyle(buttonConfig: buttonsConfig.warningSmallButton)
        case .white:
            return customStyle(buttonConfig: buttonsConfig.whiteButton, defaultHeight: 48)
        case .attention:
            return customStyle(buttonConfig: buttonsConfig.attentionButton)
        }
    }
    
    internal static func customStyle(buttonConfig: PagoButtonConfig, defaultHeight: CGFloat? = nil) -> PagoButtonStyle {
        
        var buttonStyle = PagoButtonStyle()
        if let textColorHex = buttonConfig.textColor.colorHex {
            buttonStyle.textColor = UIColor.Pago.custom(textColorHex)
        }
        if let backgroundColorHex = buttonConfig.backgroundColor.colorSolidHex {
            buttonStyle.backgroundColor = UIColor.Pago.custom(backgroundColorHex)
        }
        if let colorGradientStartHex = buttonConfig.backgroundColor.colorGradientStartHex {
            buttonStyle.startBackgroundColor = UIColor.Pago.custom(colorGradientStartHex)
        }
        if let colorGradientEndHex = buttonConfig.backgroundColor.colorGradientEndHex {
            buttonStyle.endBackgroundColor = UIColor.Pago.custom(colorGradientEndHex)
        }
        if let cornerRadius = buttonConfig.cornerRadius {
            buttonStyle.cornerRadius = cornerRadius
        }
        let shadowConfig = buttonConfig.shadow
        let radius = Double(shadowConfig.blur ?? 0)/2
        let offsetConfig = Double(shadowConfig.offset ?? 0)
        let offset = CGSize(width: offsetConfig, height: offsetConfig)
        buttonStyle.shadowStyle = ShadowStyle(radius: radius, offset: offset)
        
        let upperCase = buttonConfig.allCaps
        buttonStyle.upperCase = upperCase ?? false
        buttonStyle.horizontalMargins = PagoUIConfigurator.customConfig.buttons.marginHorizontal
        
        if let height = buttonConfig.height {
            buttonStyle.height = CGFloat(height)
        } else if let defaultHeight = defaultHeight {
            buttonStyle.height = CGFloat(defaultHeight)
        }
        
        if let width = buttonConfig.width {
            buttonStyle.height = CGFloat(width)
        }
        
        let fontRawValue = buttonConfig.font
        let font = PagoButtonFontType(rawValue: fontRawValue)
        let fontStyle: UIFont.Pago = font == .bold ? .bold15 : .regular15
        buttonStyle.font = fontStyle
        
        return buttonStyle
    }
}

