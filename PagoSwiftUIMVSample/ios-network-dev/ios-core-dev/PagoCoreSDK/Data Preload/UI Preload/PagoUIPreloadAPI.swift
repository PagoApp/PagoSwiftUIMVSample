//
//  PAGOUIPRELOADAPI.swift
//  PagoCoreSDK
//
//  Created by Bogdan on 08.06.2023.
//

import Foundation

internal class PagoUIPreloadAPI: PagoDataPreloadAPI {
            
    func getData(requestURLString: String) -> Data? {
        
        guard let configURL = URL(string: requestURLString) else {
            return nil
        }
        guard let data = try? Data(contentsOf: configURL) else {
            return nil
        }
        return data
    }
}
