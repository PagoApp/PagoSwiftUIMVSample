//
//  PagoCountryManager.swift
//  Pago
//
//  Created by Andrei Chirita on 06/05/2019.
//  Copyright © 2019 cleversoft. All rights reserved.
//

import Foundation
import CoreTelephony
@_implementationOnly import PagoCoreSDK

public class PagoCountryManager : NSObject {
    
    public static var shared : PagoCountryManager = {
        let instance = PagoCountryManager()
        return instance
    }()
    

//    private var countryCode : PagoCountry?
//    public var languageCode : PagoLocale?
    //{
//        didSet {
//            PagoApiClientManager.shared.resetManager()
//        }
    //}
    
    public var providerCode: String? {
        let networkInfo = CTTelephonyNetworkInfo()
        let carrier = networkInfo.subscriberCellularProvider
        let stringCode = carrier?.isoCountryCode
        return stringCode?.lowercased()
    }
    
    lazy public var didSelectPrefferedCountry: Bool = PagoKeychainManager().getBool("PrefferedCountry_V2") != nil

    override init() {
    }
    
//    public var courierCountryCode : PagoLanguageCode? {
//        get {
//            if let code = countryCode {
//                return code
//            } else if let strCode = UserDefaults.standard.string(forKey: "PrefferedCountry_V2"), let code = PagoLanguageCode(rawValue: strCode) {
//                countryCode = code
//                return countryCode
//            } else {
//                countryCode = detectCountry()
//                return countryCode
//            }
//        }
//        set {
//            self.countryCode = newValue
//        }
//    }
    

    func detectCountry() -> PagoCountry? {
               
        return .ro
//        if PagoConfig.shared.target == .ro {
//            return .ro
//        } else {
//            if providerCode == "ro" {
//                if PagoConfig.shared.target == .ro {
//                    return .ro
//                } else {
//                    return nil
//                }
//            } else if providerCode == "pl" {
//                return .pl
//            } else if providerCode == "hr" {
//                return .hr
//            } else if providerCode == "it" {
//                return .it
//            } else if PagoConfig.shared.target == .ro {
//                //NOTE(Qsa): Added this to prevent wrong providers call when you first isntall the app with a fresh account
//                return .ro
//            } else {
//                return nil
//            }
//        }
    }
    
//    public func saveUserSelection(country: PagoLanguageCode, language: PagoLanguageCode) {
//        courierCountryCode = country
//        UserDefaults.standard.setValue(country.rawValue, forKey: "PrefferedCountry_V2")
//        languageCode = language
//    }
    
//    public var isPoland: Bool {
//        return courierCountryCode == .pl || courierCountryCode == .en_pl
//    }
    
}
