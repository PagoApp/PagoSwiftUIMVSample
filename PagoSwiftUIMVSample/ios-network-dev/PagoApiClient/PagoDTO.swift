//
//  DTO.swift
//  Pago
//
//  Created by Mihai Arosoaie on 05/08/16.
//  Copyright © 2016 timesafe. All rights reserved.
//

import Foundation

public protocol PagoDTO {
    var dictionary : [String: Any] {get}
    init?(dictionary: [String: Any])
    static func modelsFromDictionaryArray(_ array:[[String: Any]]) -> [Self]
}
