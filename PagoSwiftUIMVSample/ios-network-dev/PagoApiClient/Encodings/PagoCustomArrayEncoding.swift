//
//  CustomArrayEncoding.swift
//  PagoApiClient
//
//  Created by Andrei Chirita on 01/08/2018.
//  Copyright © 2018 cleversoft. All rights reserved.
//

import Foundation


private let arrayParametersKey = "arrayParametersKey"

extension Array {
    /// Convert the receiver array to a `Parameters` object.
    public func asParameters() -> PagoParameters {
        return [arrayParametersKey: self]
    }
}
public struct PagoCustomArrayEncoding: PagoParameterEncoding {
    

    public let options: JSONSerialization.WritingOptions

    public init(options: JSONSerialization.WritingOptions = []) {
        self.options = options
    }
    
    public func encode(_ urlRequest: PagoURLRequestConvertible, with parameters: PagoParameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let parameters = parameters,
            let array = parameters[arrayParametersKey] else {
                return urlRequest
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: array, options: options)
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.httpBody = data
            
        } catch {
            throw PagoAFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
        
        return urlRequest
    }
}
