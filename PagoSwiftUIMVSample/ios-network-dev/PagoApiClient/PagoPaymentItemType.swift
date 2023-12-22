//
//  PaymentItemType.swift
//  PagoApiClient
//
//  Created by Mihai Arosoaie on 10/12/2017.
//  Copyright © 2017 cleversoft. All rights reserved.
//

import Foundation


public enum PagoPaymentItemType: String {
    
    case invoice, provider, vignette, prepay, insurance, freemium, insuranceTravel
    
    struct Constants {
        static let invoiceList = "invoiceList"
        static let prepayList = "prepayList"
        static let vignetteList = "vignetteList"
        static let rcaList = "insurance"
        static let providerList = "invoiceList"
        static let freemiumList = "freemiumList"
        static let insuranceTravel = "insurance_travel"
    }
    
    var listName: String {
        switch self {
        case .provider:
            return Constants.providerList
        case .invoice:
            return Constants.invoiceList
        case .prepay:
            return Constants.prepayList
        case .vignette:
            return Constants.vignetteList
        case .insurance:
            return Constants.rcaList
        case .freemium:
            return Constants.freemiumList
        case .insuranceTravel:
            return Constants.insuranceTravel
        }
        
    }
    
    init?(listName: String) {
        switch listName {
        case Constants.invoiceList:
            self = .invoice
        case Constants.prepayList:
            self = .prepay
        case Constants.vignetteList:
            self = .vignette
        case Constants.rcaList:
            self = .insurance
        case Constants.freemiumList:
            self = .freemium
        case Constants.insuranceTravel:
            self = .insuranceTravel
        default:
            return nil
        }
    }
}
