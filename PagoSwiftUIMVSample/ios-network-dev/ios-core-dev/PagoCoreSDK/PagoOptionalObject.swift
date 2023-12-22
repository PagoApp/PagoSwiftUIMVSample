//
//  PagoOptionalObject.swift
//  PagoCoreSDK
//
//  Created by Gabi on 19.07.2022.
//

import Foundation

public struct PagoOptionalObject<Base: Codable>: Codable {
    
    public let value: Base?

    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.value = try container.decode(Base.self)
        } catch {
            self.value = nil
        }
    }
}
