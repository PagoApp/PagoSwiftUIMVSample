//
//  
//  PagoAlertModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

public struct PagoAlertModel: PagoBaseAlertModel {

    var header: PagoStackedInfoModel?
    let options: [Model]
    var style: PagoAlertStyle?
    
    lazy var buttonStackModel: PagoStackedInfoModel = {
       
        let style = PagoStackedInfoStyle(distribution: .fill, alignment: .fill, axis: .horizontal, marginInset: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24))
        let model = PagoStackedInfoModel(models: [], style: style)
        return model
    }()
    
    public init(header: PagoStackedInfoModel? = nil, options: [Model], style: PagoAlertStyle? = nil) {
        
        self.header = header
        self.options = options
        self.style = style
    }
}

public struct PagoAlertStyle: BaseStyle {
    
    var optionsSpace: CGFloat
    var hasCustomIndex: Bool = false
    
    public init(optionsSpace: CGFloat, hasCustomIndex: Bool = false) {
        self.optionsSpace = optionsSpace
        self.hasCustomIndex = hasCustomIndex
    }
}
