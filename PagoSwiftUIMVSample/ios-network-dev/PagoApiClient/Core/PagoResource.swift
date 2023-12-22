//
//  Resource.swift
//  PagoApiClient
//
//  Created by Mihai Arosoaie on 10/12/2017.
//  Copyright © 2017 cleversoft. All rights reserved.
//

import Foundation


public struct PagoResource<A> {
    public let path: String
    public let parse: (Data) -> PagoApiClientResult<A>
    public let method: PagoHTTPMethod
    public let host:PagoHost
    public let authType: PagoAuthenticationType
    public let params: PagoJSONDictionary?
    public let encoding: PagoParameterEncoding
    
    public init(path: String, parse: @escaping (Data) -> PagoApiClientResult<A>, method:PagoHTTPMethod = .get, host:PagoHost = .api, authType:PagoAuthenticationType = .basic, params: PagoJSONDictionary? = nil, encoding:PagoParameterEncoding = PagoURLEncoding()) {
        self.path = path
        self.parse = parse
        self.method = method
        self.host = host
        self.authType = authType
        self.params = params
        self.encoding = encoding
    }
}
