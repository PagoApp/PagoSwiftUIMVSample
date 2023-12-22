//
//  PagoIndicatorConfig.swift
//  PagoUISDK
//
//  Created by Doru-Andrei Erdei on 22.11.2023.
//

import Foundation

// MARK: - PagoIndicatorConfig

 internal struct PagoIndicatorConfig: Codable {

     enum CodingKeys: String, CodingKey {
         case activeColor, inactiveColor
     }

    var activeColor = PagoColorConfig(colorHex: "#1D69EC")
    var inactiveColor = PagoColorConfig(colorHex: "#C4C4C4")
}
