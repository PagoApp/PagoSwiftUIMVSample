//
//  
//  PagoCheckboxModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 29/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation

public struct PagoCheckboxModel: Model {
    
    public var title: String?
    public var highlightedText: String?
    public var isSelected = false
    public var style: PagoCheckboxStyle
    public var hasInfo = false
    public var askForConfirmation = false
    public let transitionTime: Double = 0.15
    public var isUserInteractionEnabled: Bool = true
    public var accessibility = PagoAccessibility(isAccessibilityElement: false, accessibilityTraits: UIAccessibilityTraits.button)
    public var imageModel: PagoLoadedImageViewModel? = nil

    public init(title: String? = nil, highlightedText: String? = nil, isSelected: Bool = false, style: PagoCheckboxStyle, hasInfo: Bool = false, askForConfirmation: Bool = false, transitionTime: Double = 0.15, isUserInteractionEnabled: Bool = true, accessibility: PagoAccessibility) {
        
        self.title = title
        self.highlightedText = highlightedText
        self.isSelected = isSelected
        self.style = style
        self.askForConfirmation = askForConfirmation
        self.hasInfo = hasInfo
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.accessibility = accessibility
    }
}
