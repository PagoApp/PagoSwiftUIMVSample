//
//  PagoDataPreloadAPI.swift
//  PagoCoreSDK
//
//  Created by Bogdan on 08.06.2023.
//

import Foundation

protocol PagoDataPreloadAPI {
    
    /**
     * An abstract class that represents the data preload API.
     * It provides methods for fetching data, as well as saving and reading data from the internal storage.
     *
     * @param requestURLString The request URL String.
     * @return downloaded `Data`
     */
    func getData(requestURLString: String) -> Data?
}
