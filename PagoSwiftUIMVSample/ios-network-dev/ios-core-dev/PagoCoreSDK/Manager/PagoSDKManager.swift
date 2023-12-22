//
//  PagoSDKManager.swift
//  PagoRCASDK
//
//  Created by Gabi on 15.07.2022.
//

import Foundation

public protocol PagoSDKManagerDelegate {
    
    func updateLanguage(lang: PagoLocale, country: PagoCountry)
}

public class PagoSDKManager {
    
    public var sharedCore: PagoCore?
    public static let shared = PagoSDKManager()
    
    public var delegate: PagoSDKManagerDelegate?
    
    public static var isConfigured: Bool {
        return shared.sharedCore != nil
    }
    
    public static var currentLocale: PagoLocale {
        return shared.sharedCore?.langLocale ?? .ro
    }
    
    public static var authHeader: String? {
        return shared.sharedCore?.authHeader
    }
    
    public static var token: PagoToken? {
        return shared.sharedCore?.token
    }
    
    public static var dataPreloadManager: PagoDataPreloadManager? = nil
    
    public static func setup(config: PagoConfigurator, token: PagoToken) {
        
        let core = PagoCore(config: config, token: token)
        shared.sharedCore = core
    }
    
    public static func update(lang: PagoLocale) {
        
        shared.sharedCore?.update(locale: lang)
        if let country = shared.sharedCore?.country {
            shared.delegate?.updateLanguage(lang: lang, country: country)
        }
    }
}
