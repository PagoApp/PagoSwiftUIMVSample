//
//  
//  PagoBadgeButtonModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 12/04/2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//

public struct PagoBadgeModel: Model {
    public var badge: PagoLabelModel
    
    init(badge: PagoLabelModel) {
        self.badge = badge
    }
}

public enum PagoBadgePosition {
    case bottomLeft, bottomRight
    case topLeft, topRight
}
