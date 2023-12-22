//
//  Download.swift
//  Pago
//
//  Created by Mihai Arosoaie on 11/04/2017.
//  Copyright © 2017 timesafe. All rights reserved.
//

import Foundation

public struct PagoDownload: Prioritizable, Hashable {
    
    public var priority: Int = 10
    public var completionBlock: (Error?) -> ()
    public var localPath: String
    public var resource: PagoResource<Data>
    
    public var hashValue: Int {
        return resource.path.hashValue
    }
    
    public static func == (lhs: PagoDownload, rhs: PagoDownload) -> Bool {
        return lhs.resource.path == rhs.resource.path &&
            lhs.resource.method == rhs.resource.method
    }
    
    public init(priority: Int, completionBlock: @escaping (Error?)->(), localPath: String, resource: PagoResource<Data>) {
        self.priority = priority
        self.completionBlock = completionBlock
        self.localPath = localPath
        self.resource = resource
    }
    
}
