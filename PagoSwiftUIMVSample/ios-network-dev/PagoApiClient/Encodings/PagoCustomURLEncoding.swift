//
//  CustomURLEncoding.swift
//  PagoApiClient
//
//  Created by Mihai Arosoaie on 10/12/2017.
//  Copyright © 2017 cleversoft. All rights reserved.
//

import Foundation


public struct PagoCustomURLEncoding: PagoParameterEncoding {
    
    public init() {
        
    }
    
    public func encode(_ urlRequest: PagoURLRequestConvertible, with parameters: PagoParameters?) throws -> URLRequest {
        guard var mutableRequest = urlRequest.urlRequest else {
            throw PagoAFError.parameterEncodingFailed(reason: .missingURL)
        }
        guard let parameters = parameters else { return mutableRequest }
        
        let params = parameters.map { (s, v) -> String in
            return "\(s)=\(v)"
        }
        let bodyString = params.joined(separator: "&")
        mutableRequest.httpBody = bodyString.data(using: String.Encoding.utf8)
        mutableRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        return mutableRequest
    }
}
