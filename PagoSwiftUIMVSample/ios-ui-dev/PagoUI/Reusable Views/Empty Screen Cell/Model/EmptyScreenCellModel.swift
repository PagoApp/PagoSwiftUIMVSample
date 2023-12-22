//
//  
//  EmptyScreenCellModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 15/03/2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//
import UIKit
import Foundation

public struct EmptyScreenCellModel: BaseCellModel {
    
    public let empty: EmptyScreenModel
    public var baseStyle: BaseCellStyle = EmptyScreenCellStyle()
    
    public init(empty: EmptyScreenModel, baseStyle: BaseCellStyle = EmptyScreenCellStyle()) {
        
        self.empty = empty
        self.baseStyle = baseStyle
    }
}

public struct EmptyScreenCellStyle: BaseCellStyle {
    
    public var backgroundColorType: UIColor.Pago = .lightGrayInactive
    
    public init(backgroundColorType: UIColor.Pago = .lightGrayInactive) {
        self.backgroundColorType = backgroundColorType
    }
}
