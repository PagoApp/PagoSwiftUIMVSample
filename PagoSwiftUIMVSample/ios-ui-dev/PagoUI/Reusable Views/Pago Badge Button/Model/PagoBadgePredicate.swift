//
//  PagoBadgePredicate.swift
//  Pago
//
//  Created by Gabi Chiosa on 12/04/2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//

import UIKit

public struct PagoBadgePredicate: PagoPredicate {
    public var text: String
    public let textColor: UIColor.Pago
    public let backgroundColor: UIColor.Pago
    public var position: PagoBadgePosition = .bottomLeft
    
    public init(text: String, textColor: UIColor.Pago, backgroundColor: UIColor.Pago, position: PagoBadgePosition = .bottomLeft) {
        
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.position = position
    }
}
