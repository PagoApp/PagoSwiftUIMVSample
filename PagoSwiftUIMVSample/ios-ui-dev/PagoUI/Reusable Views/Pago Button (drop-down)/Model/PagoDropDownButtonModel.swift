//
//  
//  PagoDropDownButtonModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 20/07/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit
import Foundation

public struct PagoDropDownButtonModel: Model {
    
    public var options: [PagoDropDownOptionModel]
    public var selectedIndex: Int
    public let style = PagoDropDownOptionStyle()
    
    public init(options: [PagoDropDownOptionModel], selectedIndex: Int) {
        
        self.options = options
        self.selectedIndex = selectedIndex
    }
}

public struct PagoDropDownOptionModel: Model {
    public var title: String
    
    public init(title: String) {
        self.title = title
    }
}

public struct PagoDropDownOptionStyle {
    
    public let animationSpeed = 0.2
    public let optionHeight = 46
    public let optionExpandedHeight = 58
    public let cornerRadiusExpanded = 29
    public let cornerRadius = 23
    public let optionWidth = 46
    public let optionExpandedWidth = 58
    public let backgroundColor: UIColor.Pago = .lightBlueBackground
    public let optionFont: UIFont.Pago = .semiBold13
    public let highlightedOptionColor: UIColor.Pago = .darkGraySecondaryText
    public let optionColor: UIColor.Pago = .grayTertiaryText
    public let selectedOptionColor: UIColor.Pago = .blueHighlight
}
