//
//  PagoLabelWCountdownModel.swift
//  Pago
//
//  Created by Andrei Chirita on 04.06.2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//

import Foundation

public struct PagoLabelWCountdownModel: Model {
    
    var format: PagoLabelWCountdownFormat = .explicit
    let text: String
    var label: PagoLabelModel
    var endDate: Date
    
    public init(format: PagoLabelWCountdownFormat = .explicit, text: String, label: PagoLabelModel, endDate: Date) {
        
        self.format = format
        self.text = text
        self.label = label
        self.endDate = endDate
    }
}

public enum PagoLabelWCountdownFormat {
    case explicit, simple
}
