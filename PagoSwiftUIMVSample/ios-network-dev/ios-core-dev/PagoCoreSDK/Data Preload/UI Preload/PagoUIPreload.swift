//
//  PagoUIPreload.swift
//  PagoCoreSDK
//
//  Created by Bogdan on 08.06.2023.
//

import Foundation

internal class PagoUIPreload: PagoDataPreload {
    
    private static let uiConfigUrl = "https://assets.pago.ro/sdk/%@/uiConfig.json"
    private static let uiConfigFileName = "UI_CONFIG.json"
    
    var uiPreloadRepository: PagoDataPreloadRepository = PagoUIPreloadRepository()
    
    var shouldRetryPreload: Bool = false
    
    func preloadData(version: String) -> Data? {
        
        let requestURLString = String(format: PagoUIPreload.uiConfigUrl, version)
        let data = uiPreloadRepository.getaDataWithRetry(requestURLString: requestURLString, retries: 3)
        if let data = data, !data.isEmpty {
            try? self.uiPreloadRepository.saveDataToInternalStorage(input: data, fileName: PagoUIPreload.uiConfigFileName)
            self.shouldRetryPreload = false
        } else {
            self.shouldRetryPreload = true
        }
        return data
    }
    
    func retryPreload(version: String) -> Data? {
        
        let requestURLString = String(format: PagoUIPreload.uiConfigUrl, version)
        let data = uiPreloadRepository.getaDataWithRetry(requestURLString: requestURLString, retries: 1)
        
        if let data = data, !data.isEmpty {
            try? self.uiPreloadRepository.saveDataToInternalStorage(input: data, fileName: PagoUIPreload.uiConfigFileName)
            self.shouldRetryPreload = false
            return data
        } else if let data = self.getPreloadedData() {
            self.shouldRetryPreload = false
            return data
        }
        return nil
    }
    
    func getPreloadedData() -> Data? {
        
        let preloadedData: Data? = try? uiPreloadRepository.readDataFromInternalStorage(fileName: PagoUIPreload.uiConfigFileName)
        return preloadedData
    }
}
