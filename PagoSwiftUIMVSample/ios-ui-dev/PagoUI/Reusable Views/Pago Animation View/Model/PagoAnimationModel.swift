//
//  
//  PagoLoadedAnimationModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation

public struct PagoLoadedAnimationModel: Model {
    
    public let animationType: PagoAnimationModel
    public let loop: Bool
    public let style: PagoAnimationStyle
    public let accessibility = PagoAccessibility(isAccessibilityElement: false, accessibilityTraits: UIAccessibilityTraits.none)
    
    public init(animationType: PagoAnimationModel, loop: Bool, style: PagoAnimationStyle, accessibility: PagoAccessibility = PagoAccessibility(isAccessibilityElement: false, accessibilityTraits: UIAccessibilityTraits.none), animationUrl: String? = nil) {
        
        self.animationType = animationType
        self.loop = loop
        self.style = style
    }
}

public struct PagoDataAnimation: PagoAnimationModel {
    
    public let animation: UIImage.PagoAnimation
    public let bundle: Bundle?
    
    public init(animation: UIImage.PagoAnimation) {
        
        self.animation = animation
        self.bundle = nil
    }
    
    public init(animation: UIImage.PagoAnimation, bundle: Bundle) {
        
        self.animation = animation
        self.bundle = bundle
    }
}

public struct PagoBackendAnimation: PagoAnimationModel {
    
    public let url: String
    public let placeholder: UIImage.PagoAnimation

    public init(url: String, placeholder: UIImage.PagoAnimation) {
        
        self.url = url
        self.placeholder = placeholder
    }
}

public protocol PagoAnimationModel: Model {}

public struct PagoAnimationStyle: BaseStyle {
    
    public let size: CGSize
    public let backgroundColorType: UIColor.Pago
    
    public init(size: CGSize, backgroundColorType: UIColor.Pago = .clear) {
        
        self.size = size
        self.backgroundColorType = backgroundColorType
    }
}
