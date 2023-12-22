//
//  CustomJSONEncoding.swift
//  PagoApiClient
//
//  Created by Mihai Arosoaie on 10/12/2017.
//  Copyright © 2017 cleversoft. All rights reserved.
//

import Foundation


public struct PagoCustomJSONEncoding: PagoParameterEncoding {
    public init() { }
    public func encode(_ urlRequest: PagoURLRequestConvertible, with parameters: PagoParameters?) throws -> URLRequest {
        
        guard var mutableRequest = urlRequest.urlRequest else {
            throw PagoAFError.parameterEncodingFailed(reason: .missingURL)
        }
        guard let parameters = parameters else { return mutableRequest }
        
        let options = JSONSerialization.WritingOptions()
        var data = try JSONSerialization.data(withJSONObject: parameters, options: options)
        if var string = String(data: data, encoding: String.Encoding.utf8) {
            string = string.replacingOccurrences(of: "\\/", with: "/")
            if let fixedData = string.data(using: String.Encoding.utf8) {
                data = fixedData
            }
        }
        mutableRequest.httpBody = data
        mutableRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return mutableRequest
        
    }
}
