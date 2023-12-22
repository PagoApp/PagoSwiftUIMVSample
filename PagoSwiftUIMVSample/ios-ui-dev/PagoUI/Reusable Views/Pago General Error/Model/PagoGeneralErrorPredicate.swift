//
//  PagoGeneralErrorPredicate.swift
//  Pago
//
//  Created by Gabi Chiosa on 30.03.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation

public struct PagoGeneralErrorPredicate: PagoPredicate {
    
    let title: String
    let message: String
    let action: String
    
    public init(title: String? = nil, message: String? = nil, action: String? = nil) {
        
        self.title = title ?? "General error title"
        self.message = message ?? "General error message"
        self.action = action ?? "General error action"
    }
}
