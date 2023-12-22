//
//  EncodedData.swift
//  PagoApiClient
//
//  Created by Mihai Arosoaie on 10/12/2017.
//  Copyright © 2017 cleversoft. All rights reserved.
//

import Foundation


public struct PagoEncodedData: PagoParameterEncoding {
    let contentType: String?
    let data: Data
    public init(contentType: String?, data: Data) {
        self.contentType = contentType
        self.data = data
    }
    
    public func encode(_ urlRequest: PagoURLRequestConvertible, with parameters: PagoParameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = self.data
        let contentTypeKey = "Content-Type"
        if let contentType = self.contentType {
            request.setValue(contentType, forHTTPHeaderField: contentTypeKey)
        } else {
            request.allHTTPHeaderFields?.removeValue(forKey: contentTypeKey)
        }
        
        return request
    }
}
