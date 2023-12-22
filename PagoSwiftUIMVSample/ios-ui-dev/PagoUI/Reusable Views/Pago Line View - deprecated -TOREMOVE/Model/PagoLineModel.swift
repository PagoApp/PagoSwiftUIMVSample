//
//  
//  PagoLineModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 31/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit
import Foundation

public struct PagoLineModel: Model {
    public var style = PagoLineStyle()
    
    public init(style: PagoLineStyle = PagoLineStyle()) {
        self.style = style
    }
}

public struct PagoLineStyle: BaseStyle {
    public var color: UIColor.Pago = .redNegative
    public var height: CGFloat = 2
    public var leftInset: CGFloat = 0
    public var rightInset: CGFloat = 0
    
    public init(color: UIColor.Pago = .redNegative, height: CGFloat = 2, leftInset: CGFloat = 0, rightInset: CGFloat = 0) {
        
        self.color = color
        self.height = height
        self.leftInset = leftInset
        self.rightInset = rightInset
    }
}
