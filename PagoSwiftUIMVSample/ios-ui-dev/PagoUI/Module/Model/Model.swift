//
//  Model.swift
//  Pago
//
//  Created by Bogdan-Gabriel Chiosa on 05/12/2019.
//  Copyright © 2019 cleversoft. All rights reserved.
//

import UIKit

public protocol Model {}

public struct PagoAccessibility {
    
    let isAccessibilityElement: Bool
    let accessibilityTraits: UIAccessibilityTraits
    var accessibilityLabel: String?
    
    public static let none: PagoAccessibility = PagoAccessibility(isAccessibilityElement: false, accessibilityTraits: UIAccessibilityTraits.none)
    
    public init(isAccessibilityElement: Bool, accessibilityTraits: UIAccessibilityTraits, accessibilityLabel: String? = nil) {
        
        self.isAccessibilityElement = isAccessibilityElement
        self.accessibilityTraits = accessibilityTraits
        self.accessibilityLabel = accessibilityLabel
    }
    
}
