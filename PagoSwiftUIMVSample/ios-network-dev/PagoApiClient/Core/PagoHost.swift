//
//  Host.swift
//  PagoApiClient
//
//  Created by Mihai Arosoaie on 10/12/2017.
//  Copyright © 2017 cleversoft. All rights reserved.
//

import Foundation

public enum PagoHost {
    case auth,
    api,
    romcard,
    romcardLive,
    custom(String)
    
    static var baseHost: String {
        return PagoApiSwitcher.mode.baseHost
    }
    
    public var value: String {
        switch self {
        case .auth: return PagoApiSwitcher.mode.auth
        case .api: return PagoApiSwitcher.mode.api
            
        case .romcard: return "https://www.activare3dsecure.ro/teste3d/cgi-bin/"
        case .romcardLive: return "https://www.secure11gw.ro/portal/cgi-bin/"
        case .custom(let value): return value
        }
    }
    
}

extension PagoHost: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String { return value }
    public var debugDescription: String { return value }
}
