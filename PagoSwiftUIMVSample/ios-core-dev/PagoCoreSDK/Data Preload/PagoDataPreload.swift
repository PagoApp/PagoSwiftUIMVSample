//
//  PagoDataPreload.swift
//  PagoCoreSDK
//
//  Created by Bogdan on 08.06.2023.
//

import Foundation

/**
 * Defines the contract for a data preloading use case.
 */
protocol PagoDataPreload {
    
    /**
     * Determine whether the data preload should be retried.
     */
    var shouldRetryPreload: Bool { get set }
    
    /**
     * Preloads data with the specified version.
     * @param version The version of the data to be preloaded.
     * @return downloaded `Data`
     */
    func preloadData(version: String) -> Data?
    
    /**
     * Retries data preload with the specified version.
     * @param version The version of the data to be preloaded.
     * @return downloaded `Data`
     */
    func retryPreload(version: String) -> Data?
    
    /**
     * Returns the preloaded data.
     * @return downloaded `Data`
     */
    func getPreloadedData() -> Data?
}
