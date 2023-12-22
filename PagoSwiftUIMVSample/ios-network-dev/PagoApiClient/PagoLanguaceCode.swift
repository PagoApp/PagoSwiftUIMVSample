//
//  LanguaceCode.swift
//  Pago
//
//  Created by Andrei Chirita on 10/05/2019.
//  Copyright © 2019 cleversoft. All rights reserved.
//

import UIKit


//public enum PagoCountryPickerMode {
//    case language
//    case country
//}

//public enum PagoLanguageCode: String {
//    case en, ro, pl, hr, en_pl, it, en_it
//    case hu_ro = "hu"
//}

//extension PagoLanguageCode {
//    public func currency() -> String {
//
//        return "Lei"
////        switch self {
////        case .ro, .hu_ro : return "Lei"
////        case .pl : return "zł"
////        case .en, .en_pl, .en_it :
////            if PagoConfig.shared.target == .ro {
////                return "Lei"
////            } else {
////                if PagoCountryManager.shared.courierCountryCode == .it {
////                    return "€"
////                } else if PagoCountryManager.shared.courierCountryCode == .pl {
////                    return "zł"
////                } else {
////                    return "Lei"
////                }
////            }
////        case .hr : return "Kuna"
////        case .it : return "€"
////        }
//    }
//}
//
//extension PagoLanguageCode {
//
//    public var image: UIImage? {
//        return UIImage(named: imageName)
//    }
//
//    public var name: String {
//        switch self {
//        case .en, .en_pl, .en_it: return "English"
//        case .ro: return "Română"
//        case .pl: return "Polski"
//        case .hr: return "Croatian"
//        case .it: return "Italiano"
//        case .hu_ro: return "Hungarian"
//        }
//    }
//
//    public var imageName: String {
//        switch self {
//        case .en, .en_pl, .en_it: return "flag-uk"
//        case .ro: return "flag-ro"
//        case .pl: return "flag-pl"
//        case .hr: return "flag-hr"
//        case .it: return "flag-it"
//        case .hu_ro: return "flag-hu"
//        }
//    }
//
//    public var code : String {
//        switch self {
//        case .ro: return "ro"
//        case .en, .en_pl, .en_it: return "en"
//        case .pl: return "pl"
//        case .hr: return "hr"
//        case .it: return "it"
//        case .hu_ro: return "hu"
//        }
//    }
//
//    public var iso: String {
//
//        return "en_RO"
//
////        switch self {
////            return "en_RO"
//
////        case .ro: return "ro_RO"
////        case .hu_ro: return "hu_RO"
////        case .en, .en_pl, .en_it:
////            if PagoConfig.shared.target == .ro {
////                return "en_RO"
////            } else {
////                if PagoCountryManager.shared.courierCountryCode == .it {
////                    return "en_IT"
////                } else if PagoCountryManager.shared.courierCountryCode == .pl {
////                    return "en_PL"
////                } else {
////                    return "en_RO"
////                }
////            }
////        case .pl: return "pl_PL"
////        case .it: return "it_IT"
////        default : return "en_EN"
////        }
//    }
//}
