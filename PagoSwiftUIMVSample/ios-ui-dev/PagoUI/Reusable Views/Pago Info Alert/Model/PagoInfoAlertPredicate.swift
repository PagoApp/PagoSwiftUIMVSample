//
//  PagoInfoAlertPredicate.swift
//  Pago
//
//  Created by Gabi Chiosa on 30.03.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation

public struct PagoInfoAlertPredicate: PagoPredicate {
    
	let infoType: PagoInfoAlertType?
    let title: String?
    let message: String?
    
	public init(type: PagoInfoAlertType? = nil, title: String? = nil, message: String? = nil) {
        
		self.infoType = type
        self.title = title
        self.message = message
    }
}

public enum PagoInfoAlertType {
	
	case confirmation
	case warning
	case error
}
