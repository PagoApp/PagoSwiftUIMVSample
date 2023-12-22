//
//  PagoProviderType.swift
//  Pago
//
//  Created by Gabi Chiosa on 10.11.2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//

import Foundation

enum PagoProviderType: String {
    case rds = "rds.crawler"
    case ghiseul = "ghiseul"
    case enel = "enel.crawler"
    case eon = "eon.crawler"
    case orange = "orange.crawler"
    case upcPolonia = "upc_polonia.crawler"
    case upc = "upc.crawler"
    case vodafone = "vodafone.crawler"
    case unknown
}
