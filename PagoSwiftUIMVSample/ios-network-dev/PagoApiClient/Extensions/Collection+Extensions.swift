//
//  Collection+Extensions.swift
//  PagoApiClient
//
//  Created by Andrei Chirita on 26.05.2022.
//

import Foundation

extension Collection {

    internal subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

}
