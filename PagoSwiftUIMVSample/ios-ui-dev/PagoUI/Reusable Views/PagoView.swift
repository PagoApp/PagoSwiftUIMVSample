//
//  PagoView.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import Foundation
import UIKit

open class PagoView: UIView {
    
    public func addShadow(style: ShadowStyle) {
        
        self.layer.shadowOffset = style.offset
        self.layer.shadowRadius = style.radius
        self.layer.shadowOpacity = style.opacity
        self.layer.shadowColor = style.colorType.cgColor
    }
}
