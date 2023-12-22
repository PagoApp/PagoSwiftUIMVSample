//
//  
//  PagoStackedInfoModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation

public struct PagoStackedInfoModel: Model {
    public let models: [Model]
    public var hasAction: Bool = false
    public var index: Int?
    public var style = PagoStackedInfoStyle()
    public var accessibility = PagoAccessibility(isAccessibilityElement: false, accessibilityTraits: UIAccessibilityTraits.none)
    
    public init(models: [Model], hasAction: Bool = false, index: Int? = nil, style: PagoStackedInfoStyle = PagoStackedInfoStyle(), accessibility: PagoAccessibility = PagoAccessibility(isAccessibilityElement: false, accessibilityTraits: UIAccessibilityTraits.none)) {
        
        self.models = models
        self.hasAction = hasAction
        self.index = index
        self.style = style
        self.accessibility = accessibility
    }
}

public struct PagoStackedInfoStyle: BaseStyle {
    public var backgroundColor: UIColor.Pago = .clear
    public var stackBackgroundColor: UIColor.Pago = .clear
    public var marginBackgroundColor: UIColor.Pago = .clear
    public var distribution: UIStackView.Distribution = .fillProportionally
    public var alignment: UIStackView.Alignment = .fill
    public var axis: NSLayoutConstraint.Axis = .horizontal
    public var spacing: CGFloat = CGFloat(8)
    public var borderStyle: BorderStyle?
    public var cornerRadius: Int?
    public var inset: UIEdgeInsets = UIEdgeInsets.zero
    public var marginInset: UIEdgeInsets = UIEdgeInsets.zero
    public var shadowStyle: ShadowStyle?
    
    public init(backgroundColor: UIColor.Pago = .clear, stackBackgroundColor: UIColor.Pago = .clear, marginBackgroundColor: UIColor.Pago = .clear, distribution: UIStackView.Distribution = .fillProportionally, alignment: UIStackView.Alignment = .fill, axis: NSLayoutConstraint.Axis = .horizontal, spacing: CGFloat = CGFloat(8), borderStyle: BorderStyle? = nil, cornerRadius: Int? = nil, inset: UIEdgeInsets = UIEdgeInsets.zero, marginInset: UIEdgeInsets = UIEdgeInsets.zero, shadowStyle: ShadowStyle? = nil) {
        
        self.backgroundColor = backgroundColor
        self.stackBackgroundColor = stackBackgroundColor
        self.marginBackgroundColor = marginBackgroundColor
        self.distribution = distribution
        self.alignment = alignment
        self.axis = axis
        self.spacing = spacing
        self.borderStyle = borderStyle
        self.cornerRadius = cornerRadius
        self.inset = inset
        self.marginInset = marginInset
        self.shadowStyle = shadowStyle
    }
    
}
