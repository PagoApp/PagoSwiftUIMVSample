//
//  
//  PagoButtonModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 29/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import Foundation
import UIKit

public struct PagoButtonModel: Model {

    public var title: String?
    public var highlightedText: String?
    public var imageView: PagoLoadedImageViewModel?
    public var isEnabled: Bool = true
    public var isSelfSized: Bool = false
    public var index: Int = 0
    public var style: PagoButtonStyle
    public var highlightedStyle: PagoButtonStyle?
    public var inactiveStyle: PagoButtonStyle?
    public var badge: PagoBadgePredicate?

    //TODO: This will be removed after we deprecate old widht/height configuration
    public mutating func setWidth(_ width: CGFloat) {
        self.style.width = width
        self.highlightedStyle?.width = width
        self.inactiveStyle?.width = width
    }
    
    //TODO: This will be removed after we deprecate old widht/height configuration
    public mutating func setHeight(_ height: CGFloat) {
        self.style.height = height
        self.highlightedStyle?.height = height
        self.inactiveStyle?.height = height
    }
    //NOTE(Qsa): If we don't provide a custom text for accessibility, we will just add the button's title
    public var accessibility = PagoAccessibility(isAccessibilityElement: true, accessibilityTraits: UIAccessibilityTraits.button)
    
    public init(title: String? = nil, highlightedText: String? = nil, imageView: PagoLoadedImageViewModel? = nil, isEnabled: Bool = true, isSelfSized: Bool = false, index: Int = 0, style: PagoButtonStyle,  highlightedStyle: PagoButtonStyle? = nil, inactiveStyle: PagoButtonStyle? = nil, badge: PagoBadgePredicate? = nil, width: CGFloat? = nil, height: CGFloat? = nil, accessibility: PagoAccessibility = PagoAccessibility(isAccessibilityElement: true, accessibilityTraits: UIAccessibilityTraits.button)) {
        
        self.title = title
        self.highlightedText = highlightedText
        self.imageView = imageView
        self.isEnabled = isEnabled
        self.isSelfSized = isSelfSized
        self.index = index
        self.style = style
        self.highlightedStyle = highlightedStyle
        self.inactiveStyle = inactiveStyle
        self.badge = badge
        //TODO: Should remove this later. width/height must come through the style, not the model
        self.style.width = width
        self.inactiveStyle?.width = width
        self.highlightedStyle?.width = width
        self.style.height = height
        self.inactiveStyle?.height = height
        self.highlightedStyle?.height = height

        self.accessibility = accessibility
    }
}

extension PagoButtonModel {
    
    public enum Pago {
        case main, secondary, tertiary, underlined, mainRed, small, warningSmall, white, attention
    }
    
    public init(title: String? = nil, highlightedText: String? = nil, imageView: PagoLoadedImageViewModel? = nil, isEnabled: Bool = true, isSelfSized: Bool = false, highlightedStyle: PagoButtonStyle? = nil, type: Pago, badge: PagoBadgePredicate? = nil, height: CGFloat? = nil, width: CGFloat? = nil) {
        
        self.title = title
        self.highlightedText = highlightedText
        self.imageView = imageView
        self.isEnabled = isEnabled
        self.isSelfSized = isSelfSized
        self.badge = badge

        switch type {
        case .main:
            style = PagoButtonStyle.style(for: .mainActive)
            inactiveStyle = PagoButtonStyle.style(for: .mainInactive)
        case .secondary:
            style = PagoButtonStyle.style(for: .secondaryActive)
            inactiveStyle = PagoButtonStyle.style(for: .secondaryInactive)
        case .tertiary:
            style = PagoButtonStyle.style(for: .tertiaryActive)
            inactiveStyle = PagoButtonStyle.style(for: .tertiaryInactive)
        case .underlined:
            style = PagoButtonStyle.style(for: .underlinedActive)
            inactiveStyle = PagoButtonStyle.style(for: .underlinedInactive)
        case .mainRed:
            style = PagoButtonStyle.style(for: .mainRed)
            inactiveStyle = PagoButtonStyle.style(for: .mainInactive)
        case .small:
            style = PagoButtonStyle.style(for: .primarySmall)
        case .warningSmall:
            style = PagoButtonStyle.style(for: .warningSmall)
        case .white:
            style = PagoButtonStyle.style(for: .white)
        case .attention:
            style = PagoButtonStyle.style(for: .attention)
        }
        
        ///Use old width/height set as a fallback if we don't have it from the UI Config
        if let height = height, style.height == nil {
            style.height = height
        }
        if let width = width, style.width == nil {
            style.width = width
        }
    }
}
