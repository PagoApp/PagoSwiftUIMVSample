//
//  
//  PagoSpaceModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 19/03/2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//

import UIKit

public struct PagoSpaceModel: Model {
    public let size: CGSize
    
    public init(size: CGSize) {
        self.size = size
    }
    
    public init(width: CGFloat, height: CGFloat) {
        self.size = CGSize(width: width, height: height)
    }
}
