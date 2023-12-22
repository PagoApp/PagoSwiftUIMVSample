//
//  JWT.swift
//  Pago
//
//  Created by Mihai Arosoaie on 09/08/16.
//  Copyright © 2016 timesafe. All rights reserved.
//

import Foundation

public struct PagoJWT {

    var token: String
    var rawValue: String {
        return token
    }
    
    public init(token: String) {
        self.token = token
    }
}
