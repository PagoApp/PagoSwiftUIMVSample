//
//  
//  PagoLabelModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
//import CommonExtensions
import UIKit
import Foundation

public struct PagoLabelModel: Model {
    public var text: String
    public var imagePlaceholders: [PagoImagePlaceholderModel]?
    public var placeholders: [PagoPlaceholderModel]?
    public var style = PagoLabelStyle()
    public var hasAction: Bool = false
    public var accessibility = PagoAccessibility(isAccessibilityElement: true, accessibilityTraits: UIAccessibilityTraits.staticText)
    
    public init(text: String, imagePlaceholders: [PagoImagePlaceholderModel]? = nil, placeholders: [PagoPlaceholderModel]? = nil, style: PagoLabelStyle = PagoLabelStyle(), hasAction: Bool = false, accessibility: PagoAccessibility = PagoAccessibility(isAccessibilityElement: true, accessibilityTraits: UIAccessibilityTraits.staticText)) {
        
        self.text = text
        self.imagePlaceholders = imagePlaceholders
        self.placeholders = placeholders
        self.style = style
        self.hasAction = hasAction
        self.accessibility = accessibility
    }
}

public struct ContentPriorityBase {
    public let priority: UILayoutPriority
    public let axis: NSLayoutConstraint.Axis
    
    public init(priority: UILayoutPriority, axis: NSLayoutConstraint.Axis) {
        
        self.priority = priority
        self.axis = axis
    }
}

public struct PagoSize {
    public var width: CGFloat?
    public var height: CGFloat?
    
    public init(width: CGFloat? = nil, height: CGFloat? = nil) {
        
        self.width = width
        self.height = height
    }
}

public struct PagoLabelStyle: BaseViewStyle {
    public var textColorType: UIColor.Pago = .sdkDarkGray
    public var fontType: UIFont.Pago = .regular15
    public var isAllCaps: Bool = false
    public var paragraphStyle: PagoParagraphStyle?
    public var size: PagoSize?
    public var backgroundColorType: UIColor.Pago = .clear
    public var tintColorType: UIColor.Pago?
    public var alignment: NSTextAlignment = .left
    public var lineBreakMode: NSLineBreakMode = .byWordWrapping
    public var numberOfLines: Int = 1
    public var contentCompressionResistance: ContentPriorityBase?
    public var contentHuggingPriority: ContentPriorityBase?
    public var borderStyle: BorderStyle?
    public var cornerRadius: Int?
    public var isStriked: Bool = false
    public var inset: UIEdgeInsets = UIEdgeInsets.zero
    public var shadowStyle: ShadowStyle?
    
    public init(textColorType: UIColor.Pago = .sdkDarkGray, fontType: UIFont.Pago = .regular15, isAllCaps: Bool = false, paragraphStyle: PagoParagraphStyle? = nil, size: PagoSize? = nil, backgroundColorType: UIColor.Pago = .clear, tintColorType: UIColor.Pago? = nil, alignment: NSTextAlignment = .left, lineBreakMode: NSLineBreakMode = .byWordWrapping, numberOfLines: Int = 1, contentCompressionResistance: ContentPriorityBase? = nil, contentHuggingPriority: ContentPriorityBase? = nil, borderStyle: BorderStyle? = nil, cornerRadius: Int? = nil, isStriked: Bool = false, inset: UIEdgeInsets = UIEdgeInsets.zero, shadow: ShadowStyle? = nil) {
        
        
        self.textColorType = textColorType
        self.fontType = fontType
        self.isAllCaps = isAllCaps
        self.paragraphStyle = paragraphStyle
        self.size = size
        self.backgroundColorType = backgroundColorType
        self.tintColorType = tintColorType
        self.alignment = alignment
        self.lineBreakMode = lineBreakMode
        self.numberOfLines = numberOfLines
        self.contentHuggingPriority = contentHuggingPriority
        self.contentCompressionResistance = contentCompressionResistance
        self.borderStyle = borderStyle
        self.cornerRadius = cornerRadius
        self.isStriked = isStriked
        self.inset = inset
        self.shadowStyle = shadow
    }
    
}

public struct PagoPlaceholderModel: Model {
    public var text: String
    public var style = PagoPlaceholderStyle()
    public var replacement: [String: [NSAttributedString.Key: Any]] {
        return [text: style.attributedStyle]
    }
    
    public init(text: String, style: PagoPlaceholderStyle = PagoPlaceholderStyle()) {
        
        self.text = text
        self.style = style
    }
}

public struct PagoParagraphStyle {
    public let zeroLineSpace: Bool
    public let alignment: NSTextAlignment
    public let lineBreakMode: NSLineBreakMode
    
    public init(zeroLineSpace: Bool, alignment: NSTextAlignment, lineBreakMode: NSLineBreakMode) {
        
        self.zeroLineSpace = zeroLineSpace
        self.alignment = alignment
        self.lineBreakMode = lineBreakMode
    }
}

public struct PagoImagePlaceholderModel: Model {
    public var key: String
    public var image: UIImage.Pago
    public var xOffset: CGFloat?
    public var yOffset: CGFloat = -4
    public var width: CGFloat?
    public var height: CGFloat = 20
    
    public init(key: String, image: UIImage.Pago, xOffset: CGFloat? = nil, yOffset: CGFloat = -4, width: CGFloat? = nil, height: CGFloat = 20) {
        
        self.key = key
        self.image = image
        self.xOffset = xOffset
        self.yOffset = yOffset
        self.width = width
        self.height = height
    }
}

extension PagoImagePlaceholderModel {
    
    static var moneyTransferImagePlaceholders: [PagoImagePlaceholderModel]  {
        let pagoWhitePlaceholder  = PagoImagePlaceholderType.logoWhite.getModel(yOffset: -6, height: 20)
        let pagoPlaceholder = PagoImagePlaceholderType.logo.getModel(yOffset: -6, height: 20)
        let coinsPlaceholder = PagoImagePlaceholderType.coin.getModel()
        let visaPlaceholder  = PagoImagePlaceholderType.visaCard.getModel(width: 22, height: 15)
        let visaBluePlaceholder  = PagoImagePlaceholderType.visaLogoBlue.getModel(yOffset: -1, height: 14)
        let mastercardPlaceholder  = PagoImagePlaceholderType.masterCard.getModel(width: 22, height: 15)
        let placeholders: [PagoImagePlaceholderModel] = [pagoWhitePlaceholder, pagoPlaceholder, coinsPlaceholder, visaPlaceholder, mastercardPlaceholder, visaBluePlaceholder]
        return placeholders
    }
}

extension PagoImagePlaceholderModel {
    func toReplacement() -> String.AttributedStringReplacement {
        return String.AttributedStringReplacement(key: self.key, image: self.image.image ?? UIImage(), xOffset: self.xOffset, yOffset: self.yOffset, width: self.width, height: self.height)
    }
}

public struct PagoPlaceholderStyle {
    public var textColorType: UIColor.Pago?
    public var fontType: UIFont.Pago?
    public var underlined: Bool = false
    public var attributedURL: URL?
    
    public var attributedStyle: [NSAttributedString.Key: Any] {
        return NSAttributedString.toAttributes(font: fontType, color: textColorType, underlined: underlined, link: attributedURL)
    }
    
    public init(textColorType: UIColor.Pago? = nil, fontType: UIFont.Pago? = nil, underlined: Bool = false, attributedURL: URL? = nil) {
        self.textColorType = textColorType
        self.fontType = fontType
        self.underlined = underlined
        self.attributedURL = attributedURL
    }
}

public enum PagoImagePlaceholderType {
    
    case logo, logoWhite
    case moneyBag
    case coin
    case visaCard, visaCardWhite
    case visaLogoBlue
    case masterCard
    case freemiumPremiumIcon
    
    public func getModel(xOffset: CGFloat? = nil, yOffset: CGFloat = -4, width: CGFloat? = nil, height: CGFloat = 20, keyUppercased: Bool = false) -> PagoImagePlaceholderModel {
        var image: UIImage.Pago!
        var placeholder: String!
        switch self {
        case .logoWhite:
            placeholder = "{pagoLogo}"
            image = .logoWhite
        case .logo:
            placeholder = "{pagoLogoBlue}"
            image = .logo
        case .moneyBag:
            placeholder = "{moneyBag}"
            image = .moneyBagIcon
        case .coin:
            image = .pagoCoin
            placeholder = "{pagoCoin}"
        case .visaLogoBlue:
            image = .visaLogo
            placeholder = "{visaLogoBlue}"
        case .visaCard:
            image = .visaCard
            placeholder = "{visaCard}"
        case .visaCardWhite:
            image = .visaWhite
            placeholder = "{visaCard}"
        case .masterCard:
            image = .masterCard
            placeholder = "{mastercardCard}"
        case .freemiumPremiumIcon:
            image = .freemiumStar
            placeholder = "{freemiumPremiumIcon}"
        }
        if keyUppercased {
            placeholder = placeholder.uppercased()
        }
        return PagoImagePlaceholderModel(key: placeholder, image: image, xOffset: xOffset, yOffset: yOffset, width: width, height: height)
    }
}

extension PagoLabelStyle {
    
    public enum PagoCustomLabelStyle: StringLiteralType {
        case topHintStyle, greyRegular10, greyRegular12, greyRegular14, greyBold12, greyBold14, blackBold14, blackRegular14, redRegular12, redRegular14, brownRegular14, blackBold16, blackRegular16, greyRegular16, blackBold20, blackBold24, blueBold14, redBold14
    }
    
    public init(customStyle: PagoCustomLabelStyle, paragraphStyle: PagoParagraphStyle? = nil, size: PagoSize? = nil, backgroundColorType: UIColor.Pago = .clear, tintColorType: UIColor.Pago? = nil, alignment: NSTextAlignment = .left, lineBreakMode: NSLineBreakMode = .byWordWrapping, numberOfLines: Int = 1, contentCompressionResistance: ContentPriorityBase? = nil, contentHuggingPriority: ContentPriorityBase? = nil, borderStyle: BorderStyle? = nil, cornerRadius: Int? = nil, isStriked: Bool = false, inset: UIEdgeInsets = UIEdgeInsets.zero, shadow: ShadowStyle? = nil) {
        
        self = PagoLabelStyle.customConfig(for: customStyle)
        self.paragraphStyle = paragraphStyle
        self.size = size
        self.backgroundColorType = backgroundColorType
        self.tintColorType = tintColorType
        self.alignment = alignment
        self.lineBreakMode = lineBreakMode
        self.numberOfLines = numberOfLines
        self.contentHuggingPriority = contentHuggingPriority
        self.contentCompressionResistance = contentCompressionResistance
        self.borderStyle = borderStyle
        self.cornerRadius = cornerRadius
        self.isStriked = isStriked
        self.inset = inset
        self.shadowStyle = shadow
    }
    
    public static func customConfig(for style: PagoCustomLabelStyle) -> PagoLabelStyle {
        
        var labelStyle = PagoLabelStyle()
        if let fontConfig = PagoUIConfigurator.customConfig.labelStyles[style.rawValue] {
            if let fontStyle = fontConfig.fontStyle,
               let size = fontConfig.textSize {
                let weight: UIFont.Weight = (fontStyle == .regular) ? .regular : .bold
                labelStyle.fontType = UIFont.Pago.customConfig(CGFloat(size), weight)
            }
            if let colorHex = fontConfig.textColor?.colorHex {
                labelStyle.textColorType = UIColor.Pago.custom(colorHex)
            }
            if let isAllCaps = fontConfig.isAllCaps {
                labelStyle.isAllCaps = isAllCaps
            }
        } else {
            //NOTE: warn that the style does not exist (should never happen)
            print("WARNING: label style not found")
        }
        return labelStyle
    }
}
