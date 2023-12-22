//
//  PagoJSONValidator.swift
//  PagoCoreSDK
//
//  Created by Gabi on 27.05.2022.
//

import Foundation

internal struct PagoConfig {
    
    let baseUrl: String
    let appId: String
    let authHeader: String
    var tokenPrefix: String? = nil
    var requiredDataSourceProvider: Bool = true
    var defaultOcrFlag: Bool = false

    init(data: Data) throws {
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw PagoException.invalid("Corrupted config.json file. Contact the Pago team.")
        }
        
        let baseUrlKey = "hostUrl"
        let appIdKey = "appId"
        let authHeaderKey = "authHeader"
        let tokenPrefixKey = "tokenPrefix"
        let requiredDataSourceProviderKey = "requiredDataSourceProvider"
        let defaultOcrFlagKey = "defaultOcrFlag"

        guard let baseUrl = json[baseUrlKey] as? String else {
            throw PagoException.missing("Invalid host url. Contact the Pago team.")
        }
        
        guard let appId = json[appIdKey] as? String else {
            throw PagoException.missing("Invalid App ID. Contact the Pago team.")
        }
        
        guard let authHeader = json[authHeaderKey] as? String else {
            throw PagoException.missing("Invalid Auth Header. Contact the Pago team.")
        }

        if let tokenPrefix = json[tokenPrefixKey] as? String {
            self.tokenPrefix = tokenPrefix
        }
        
        if let requiredDataSourceProvider = json[requiredDataSourceProviderKey] as? Bool {
            self.requiredDataSourceProvider = requiredDataSourceProvider
        }
        
        if let defaultOcrFlag = json[defaultOcrFlagKey] as? Bool {
            self.defaultOcrFlag = defaultOcrFlag
        }

        self.baseUrl = baseUrl
        self.appId = appId
        self.authHeader = authHeader
    }
}
