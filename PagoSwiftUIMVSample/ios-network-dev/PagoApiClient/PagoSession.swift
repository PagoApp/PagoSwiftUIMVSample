//
//  PagoSession.swift
//  Pago
//
//  Created by Mihai Arosoaie on 09/08/16.
//  Copyright © 2016 timesafe. All rights reserved.
//

import Foundation

public class PagoSession {
    public var refreshToken: PagoJWT
    public var accessToken: PagoJWT
    public var anonymous: Bool {
        return false
    }
    
    public init(accessToken: PagoJWT, refreshToken: PagoJWT) {
        self.refreshToken = refreshToken
        self.accessToken = accessToken
    }
    
}

extension PagoSession: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        return "\(refreshToken)\n\(accessToken)"
    }
    
    public var debugDescription: String {
        return description
    }
}
