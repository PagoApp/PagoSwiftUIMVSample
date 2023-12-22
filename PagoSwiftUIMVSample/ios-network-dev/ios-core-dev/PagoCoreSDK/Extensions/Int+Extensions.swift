//
//  Int+Extensions.swift
//  PagoCoreSDK
//
//  Created by Gabi on 16.08.2022.
//

import Foundation

extension Int64: IntToString {
    
    public var toString: String {
        return "\(self)"
    }
}

extension Int32: IntToString {
    
    public var toString: String {
        return "\(self)"
    }
}

extension Int: IntToString {
    
    public var toString: String {
        return "\(self)"
    }
}

public protocol IntToString {
    var toString: String { get }
}
