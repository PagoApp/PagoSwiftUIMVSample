//
//  PagoBaseSDK.swift
//  PagoBaseSDK
//
//  Created by Gabi on 11.05.2022.
//

import Foundation

public class PagoCore {
    
    private var configurator: PagoConfigurator?
    internal var token: PagoToken?
    
    public var langLocale: PagoLocale? {
        return configurator?.langLocale
    }
    
    public var country: PagoCountry? {
        return configurator?.country
    }
    
    public var baseUrl: String? {
        return configurator?.config.baseUrl
    }
    
    public var appId: String? {
        return configurator?.config.appId
    }
    
    public var authHeader: String? {
        return configurator?.config.authHeader
    }

    public var tokenDataSource: PagoTokenDataSource? {
        return configurator?.tokenDataSource
    }

    public var tokenPrefix: String? {
        return configurator?.config.tokenPrefix
    }
    

    public init(config: PagoConfigurator, token: PagoToken) {
        
        self.configurator = config
        self.token = token
    }
    
    public func update(locale: PagoLocale) {
        
        self.configurator?.update(locale: locale)
    }

}
