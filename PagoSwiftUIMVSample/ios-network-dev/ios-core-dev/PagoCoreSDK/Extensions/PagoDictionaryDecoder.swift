//
//  Decodable+Extension.swift
//  PagoCoreSDK
//
//  Created by Bogdan on 04.05.2023.
//

import Foundation

public class PagoDictionaryDecoder {
    
     public static func decode<T: BasePagoCodable>(dictionary: [AnyHashable : Any]) -> T? {
        
        let decoder = JSONDecoder()
        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            return nil
        }
    }
}
