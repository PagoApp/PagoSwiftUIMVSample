//
//  PagoOperationPreload.swift
//  PagoCoreSDK
//
//  Created by Bogdan on 16.06.2023.
//

import Foundation

/**
 * Defines the contract for a data preloading operation.
 */
protocol PagoOperationPreload: Operation {
    
    /**
     * The version of the configuration.
     */
    var version: String { get set }
    
    /**
     * The download call.
     */
    var download: (String)->(Data?) { get set }
    
    /**
     * The data that has been downloaded.
     */
    var downloadedData: Data? { get set }
}
