//
//  Sequence+Extension.swift
//  PagoApiClient
//
//  Created by Andrei Chirita on 25.05.2022.
//

import Foundation

extension Sequence {
    public func failingFlatMap<T>(transform: (Self.Iterator.Element) throws -> T?) rethrows -> [T]? {
        var result: [T] = []
        for element in self {
            guard let transformed = try transform(element) else { return nil }
            result.append(transformed)
        }
        return result
    }
}

extension Sequence where Element: Hashable {
    public func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
