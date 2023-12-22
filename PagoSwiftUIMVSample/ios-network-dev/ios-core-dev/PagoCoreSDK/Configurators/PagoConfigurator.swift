//
//  PagoConfigurator.swift
//  PagoSDK
//
//  Created by Gabi on 11.05.2022.
//

import Foundation

public class PagoConfigurator {
    
    internal let jsonConfig: PagoJSONConfig
    internal let config: PagoConfig
    internal var langLocale: PagoLocale
    internal let country: PagoCountry
    internal let logConfigurator: PagoLogConfigurator
    public var tokenDataSource: PagoTokenDataSource?

    public init(config jsonConfig: PagoJSONConfig, tokenDataSource: PagoTokenDataSource, langLocale: PagoLocale = .ro, logConfigurator: PagoLogConfigurator = PagoLogConfigurator()) throws {
            
        self.langLocale = langLocale
        self.tokenDataSource = tokenDataSource
        self.jsonConfig = jsonConfig
        self.logConfigurator = logConfigurator
        self.country = .ro
        self.config = try PagoConfig(data: jsonConfig.config)
        PagoSDKManager.dataPreloadManager = PagoDataPreloadManager()
        PagoSDKManager.dataPreloadManager?.preloadData(version: self.config.appId)
    }
    
    internal func update(locale: PagoLocale) {
        self.langLocale = locale
    }
}
