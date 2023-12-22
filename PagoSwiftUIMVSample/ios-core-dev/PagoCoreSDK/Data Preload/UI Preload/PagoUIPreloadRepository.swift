//
//  PagoUIPreloadRepository.swift
//  PagoCoreSDK
//
//  Created by Bogdan on 08.06.2023.
//

import Foundation

class PagoUIPreloadRepository: PagoDataPreloadRepository {
    
    var dataPreloadAPI: PagoDataPreloadAPI = PagoUIPreloadAPI()
    var retryDelay: TimeInterval = 1.0
    
    func getaDataWithRetry(requestURLString: String, retries: Int) -> Data? {
        
        //we should not call this on the main thread
        if Thread.isMainThread {
            return nil
        }
        
        let data = dataPreloadAPI.getData(requestURLString: requestURLString)
        if let data = data, !data.isEmpty {
            return data
        } else if retries > 0 {
            Thread.sleep(forTimeInterval: 1)
            return self.getaDataWithRetry(requestURLString: requestURLString, retries: retries - 1)
        }
        
        return nil
    }
    
    func saveDataToInternalStorage<T>(input: T, fileName: String) throws {
        
        guard let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw PagoException.invalid("Failed to get documents directory path")
        }
        if let data = input as? Data {
            let filePath = dirPath.appendingPathComponent(fileName)
            try data.write(to: filePath)
        }
    }
    
    func readDataFromInternalStorage<T>(fileName: String) throws -> T? {
        
        guard let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw PagoException.invalid("Failed to get documents directory path")
        }
        let filePath = dirPath.appendingPathComponent(fileName)
        let output = try Data(contentsOf: filePath)
        return output as? T
    }
}
