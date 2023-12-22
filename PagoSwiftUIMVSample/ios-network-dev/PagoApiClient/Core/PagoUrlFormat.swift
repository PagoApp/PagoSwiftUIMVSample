//
//  UrlFormat.swift
//  PagoApiClient
//
//  Created by Mihai Arosoaie on 10/12/2017.
//  Copyright © 2017 cleversoft. All rights reserved.
//

import Foundation

public enum PagoUrlFormat: String {
    case live, test
    
    var auth: String {
        switch self {
        case .test:
            return "/authentication"
        case .live:
            return "/authentication"
        }
        
    }
    
    var api: String {
        switch self {
        case .test:
            return ""
        case .live:
            return ""
        }
    }
}
