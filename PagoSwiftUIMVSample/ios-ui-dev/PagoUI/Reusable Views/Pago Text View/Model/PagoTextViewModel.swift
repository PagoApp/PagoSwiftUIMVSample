//
//
//  PagoTextModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 13/05/2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//

import UIKit

public struct PagoTextViewModel: Model {

    public var text: String?
    public var textLimit: Int = 30
    public var placeholder: PagoLabelModel?
    public var counter: PagoLabelModel?
    public var style = PagoTextViewStyle()
    public var counterFormat: String = "%d / %d"
    public var accessibility = PagoAccessibility(isAccessibilityElement: true, accessibilityTraits: UIAccessibilityTraits.staticText)
    
    public init(text: String? = nil, textLimit: Int = 30, placeholder: PagoLabelModel? = nil, counter: PagoLabelModel? = nil, style: PagoTextViewStyle = PagoTextViewStyle(), counterFormat: String = "%d / %d", accessibility: PagoAccessibility = PagoAccessibility(isAccessibilityElement: true, accessibilityTraits: UIAccessibilityTraits.staticText)) {
        
        self.text = text
        self.textLimit = textLimit
        self.placeholder = placeholder
        self.counter = counter
        self.style = style
        self.counterFormat = counterFormat
        self.accessibility = accessibility
    }
}

public class PagoTextViewStyle: BaseViewStyle {
    public var textColorType: UIColor.Pago = .blackBodyText
    public var fontType: UIFont.Pago = .regular15
    public var backgroundColorType: UIColor.Pago = .white
    public var tintColorType: UIColor.Pago?
    public var alignment: NSTextAlignment = .left
    public var lineBreakMode: NSLineBreakMode = .byWordWrapping
    public var numberOfLines: Int?
    public var borderStyle: BorderStyle?
    public var cornerRadius: Int?
    public var inset: UIEdgeInsets = UIEdgeInsets.zero
    public var width: CGFloat?
    public var height: CGFloat?
    public var showsCounter: Bool = false
    public let counterStyle: PagoLabelStyle
    
    public init(textColorType: UIColor.Pago = .blackBodyText, fontType: UIFont.Pago = .regular15, backgroundColorType: UIColor.Pago = .white, tintColorType: UIColor.Pago? = nil, alignment: NSTextAlignment = .left, lineBreakMode: NSLineBreakMode = .byWordWrapping, numberOfLines: Int? = nil, borderStyle: BorderStyle? = nil, cornerRadius: Int? = nil, inset: UIEdgeInsets = UIEdgeInsets.zero, width: CGFloat? = nil, height: CGFloat? = nil, showsCounter: Bool = false) {
        
        self.textColorType = textColorType
        self.fontType = fontType
        self.backgroundColorType = backgroundColorType
        self.tintColorType = tintColorType
        self.alignment = alignment
        self.lineBreakMode = lineBreakMode
        self.numberOfLines = numberOfLines
        self.borderStyle = borderStyle
        self.cornerRadius = cornerRadius
        self.inset = inset
        self.width = width
        self.height = height
        self.showsCounter = showsCounter
        self.counterStyle = PagoLabelStyle(textColorType: .grayTertiaryText, fontType: .regular11, alignment: .right, numberOfLines: 1)
    }
}
