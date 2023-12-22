//
//  PagoDataPreloadRepository.swift
//  PagoCoreSDK
//
//  Created by Bogdan on 08.06.2023.
//

import Foundation

/**
 * A protocol that represents the data preload repository.
 * It provides methods for fetching data with retry logic, as well as saving and reading data from the internal storage.
 */
protocol PagoDataPreloadRepository {
    
    var dataPreloadAPI: PagoDataPreloadAPI { get set }
    var retryDelay: TimeInterval { get set }
    
    /**
     * Retrieves data with retry logic based on the provided request URL and number of retries.
     *
     * @param requestURLString The request URL String.
     * @param retries The number of retries.
     * @return downloaded `Data`
     */
    func getaDataWithRetry(requestURLString: String, retries: Int) -> Data? 
    
    func saveDataToInternalStorage<T>(input: T, fileName: String) throws
    func readDataFromInternalStorage<T>(fileName: String) throws -> T?
}
