//
//  Data+Extensions.swift
//  Pago
//
//  Created by Mihai Arosoaie on 10/04/2017.
//  Copyright © 2017 timesafe. All rights reserved.
//

import Foundation


extension Data: PagoParameterEncoding {
    
    public func encode(_ urlRequest: PagoURLRequestConvertible, with parameters: PagoParameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = self
        return request
    }
    
    var utf8String: String? {
        return String(data: self, encoding: .utf8)
    }
    
    var bytes:[UInt8] {
        return self.withUnsafeBytes { (start) -> [UInt8] in
            return Array(UnsafeBufferPointer(start: start, count: self.count))
        }
    }
    
}
