//
//  
//  PagoCircleModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 15/09/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation

public struct PagoCircleModel: Model {
    public var style: PagoCircleStyle
    public var defaultStyle: PagoUpdateStyle
    public var highlightStyle: PagoUpdateStyle
    public var errorStyle: PagoUpdateStyle
    public var verifiedStyle: PagoUpdateStyle
    public let accessibility = PagoAccessibility(isAccessibilityElement: false, accessibilityTraits: UIAccessibilityTraits.none)
    
    public init(style: PagoCircleStyle, defaultStyle: PagoUpdateStyle, highlightStyle: PagoUpdateStyle, errorStyle: PagoUpdateStyle, verifiedStyle: PagoUpdateStyle) {
        
        self.style = style
        self.defaultStyle = defaultStyle
        self.highlightStyle = highlightStyle
        self.errorStyle = errorStyle
        self.verifiedStyle = verifiedStyle
    }
}

public struct PagoUpdateStyle {
    public let tintColorType: UIColor.Pago
    public var updates: [CGFloat]?
    public let duration: CGFloat
    
    public init(tintColorType: UIColor.Pago, updates: [CGFloat]? = nil, duration: CGFloat) {
        self.tintColorType = tintColorType
        self.updates = updates
        self.duration = duration
    }
}

public enum PagoCircleStyleType: String {
    case normal, filled, verified, error
}

public struct PagoCircleStyle {
    public let viewSize: CGSize
    public let circleRadius: CGFloat
    
    public init(viewSize: CGSize, circleRadius: CGFloat) {
        self.viewSize = viewSize
        self.circleRadius = circleRadius
    }
}
