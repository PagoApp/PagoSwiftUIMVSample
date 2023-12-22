//
//  PagoConfirmationAlertPredicate.swift
//  Pago
//
//  Created by Gabi Chiosa on 30.03.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation

public struct PagoConfirmationAlertPredicate: PagoPredicate {
    
    let title: String
    let message: String
    
    public init(title: String, message: String) {
        
        self.title = title
        self.message = message
    }
}
