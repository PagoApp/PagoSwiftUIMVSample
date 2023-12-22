//
//  PagoDataPreloadManager.swift
//  PagoCoreSDK
//
//  Created by Bogdan on 08.06.2023.
//

import Foundation

/**
 * The PagoDataPreloadManager class is responsible for managing data preloading operations.
 * It is designed as a singleton and provides a way to preload data using the provided [PagoDataPreload] implementations.
 *
 * @param uiConfigPreload The implementation of [PagoDataPreload] for handling the UI data preloading.
 */

public class PagoDataPreloadManager {
    
    private static var shouldStartSDK: Bool = false
    
    private var uiConfigPreload: PagoDataPreload? = nil
    
    private var preloadOperation: PagoUIOperationPreload? = nil
    private var retryPreloadOperation: PagoUIOperationPreload? = nil
    
    private lazy var preloadOperationQueue: OperationQueue = {
        
        let operationQueue = OperationQueue()
        operationQueue.qualityOfService = .utility
        return operationQueue
    }()
        
    /**
     * Initialize the instance of `PagoDataPreloadManager` and also sets the`dataPreloadManager` of the `PagoSDKManager`.
     *
     * @param uiConfigPreload The implementation of `PagoDataPreload` for handling the UI data preloading.
     */
    init(uiConfigPreload: PagoDataPreload? = PagoUIPreload()) {
        
        self.uiConfigPreload = uiConfigPreload
    }
    
    /**
     * Preloads data using the specified version.
     *
     * @param version The version of the data to be preloaded.
     */
    internal func preloadData(version: String) {
        
        guard let configPreload = uiConfigPreload else { return }
        
        //NOTE: fresh start -> cancel all operations in progress
        preloadOperationQueue.cancelAllOperations()
        
        preloadOperation = buildPreloadOperation(version: version, download: configPreload.preloadData)
        if let op = preloadOperation {
            preloadOperationQueue.addOperation(op)
        }
    }
    
    /**
     * Retries the preloading process using the specified version.
     *
     * @param version The version of the data to be preloaded.
     */
    public func checkRetryPreload(version: String) {
        
        guard let configPreload = uiConfigPreload else { return }
        
        //NOTE: do not retry the preloading op if a preload is already in progress
        guard !(preloadOperation?.isExecuting ?? false) else { return }
        
        //NOTE: if shouldRetry is false and if the data is already downloaded it return, aka do not fire another download process
        guard configPreload.shouldRetryPreload || configPreload.getPreloadedData() == nil else { return }
        
        retryPreloadOperation = buildPreloadOperation(version: version, download: configPreload.retryPreload)
        if let op = retryPreloadOperation {
            preloadOperationQueue.addOperation(op)
        }
    }
    
    private func buildPreloadOperation(version: String, download: @escaping (String)->(Data?)) -> PagoUIOperationPreload {
                
        let op = PagoUIOperationPreload(version: version, download: download)
        op.completionBlock = {
            
            guard !op.isCancelled else { return }
            
            if let data = op.downloadedData, !data.isEmpty {
                PagoDataPreloadManager.shouldStartSDK = true
            }
        }
        
        return op
    }
    
    public func checkStartSDK(success: @escaping (Data)->(), failure: @escaping (PagoSDKError)->()) {
        
        let completionOperation = BlockOperation{
            if let config = self.uiConfigPreload?.getPreloadedData(), PagoDataPreloadManager.shouldStartSDK {
                DispatchQueue.main.async {
                    success(config)
                }
            } else {
                failure(.DATA_PRELOAD_ERROR)
            }
        }
        
        //NOTE: if an operation is already in progress wait for it to finish
        for op in preloadOperationQueue.operations {
            if op.isExecuting {
                completionOperation.addDependency(op)
            }
        }
        preloadOperationQueue.addOperation(completionOperation)
    }
}
