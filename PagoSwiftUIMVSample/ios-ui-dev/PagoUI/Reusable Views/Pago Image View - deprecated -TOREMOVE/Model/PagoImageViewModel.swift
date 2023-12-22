//
//  
//  PagoImageModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import Foundation
import UIKit

public struct PagoImageViewModel: Model {
   
    public var imageType: UIImage.Pago
    public var style: PagoImageViewStyle
    public var accessibility: PagoAccessibility
    
    public init(imageType: UIImage.Pago, style: PagoImageViewStyle, accessibility: PagoAccessibility = PagoAccessibility(isAccessibilityElement: false, accessibilityTraits: UIAccessibilityTraits.image)) {
        
        self.imageType = imageType
        self.style = style
        self.accessibility = accessibility
    }
}

public struct PagoImageViewStyle: BaseViewStyle {
    
    public var size: CGSize?
    public var inset: UIEdgeInsets
    public var tintColorType: UIColor.Pago?
    public var backgroundColorType: UIColor.Pago
    public var contentMode: UIView.ContentMode
    public var cornerRadius: Int
    public var backgroundCornerRadius: Int
    public var borderStyle: BorderStyle?
    public var alpha: CGFloat
    public var isBlackAndWhite: Bool
    
    public init(size: CGSize? = nil, inset: UIEdgeInsets = UIEdgeInsets.zero, tintColorType: UIColor.Pago? = nil, backgroundColorType: UIColor.Pago = .clear, contentMode: UIView.ContentMode = .scaleAspectFit, cornerRadius: Int = 0, backgroundCornerRadius: Int = 0, borderStyle: BorderStyle? = nil, alpha: CGFloat = 1.0, isBlackAndWhite: Bool = false) {
        
        self.size = size
        self.inset = inset
        self.tintColorType = tintColorType
        self.backgroundColorType = backgroundColorType
        self.contentMode = contentMode
        self.cornerRadius = cornerRadius
        self.backgroundCornerRadius = backgroundCornerRadius
        self.borderStyle = borderStyle
        self.alpha = alpha
        self.isBlackAndWhite = isBlackAndWhite
    }
}
