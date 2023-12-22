//
//  UIImageView+Extension.swift
//  Pago
//
//  Created by Gabi Chiosa on 23.02.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation
import UIKit

internal extension UIImageView {
    
    convenience init(pagoImage: UIImage.Pago) {
        
        self.init(image: UIImage(pagoImage: pagoImage))
    }
}
