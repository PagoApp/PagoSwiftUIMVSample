//
//  PagoCodable.swift
//  PagoCoreSDK
//
//  Created by Gabi on 26.07.2022.
//

import Foundation

public protocol BasePagoCodable: Codable, Equatable {
    func toJson() throws -> Data
    func toDictionary() -> [String: Any]
}

public extension BasePagoCodable {
    
    func toJson() throws -> Data {
        let jsonEncoder = JSONEncoder()
        let jsonResultData = try jsonEncoder.encode(self)
        return jsonResultData
    }
    
    func toDictionary() -> [String: Any] {
        let data = try? toJson()
        guard let data = data, let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
}
