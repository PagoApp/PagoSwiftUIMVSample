//
//
//  PagoSearchBarModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 30/07/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

public struct PagoSearchBarModel: Model {
    
    public var text: String?
    public var placeholder: String?
    public let style = PagoSearchBarStyle()
    
    public init(text: String? = nil, placeholder: String? = nil) {
        
        self.text = text
        self.placeholder = placeholder
    }
    
    public var image: UIImage {
        let tintColor = style.searchIndicatorColor.color
        return style.searchIcon.image?.tint(with: tintColor) ?? UIImage()
    }
}
