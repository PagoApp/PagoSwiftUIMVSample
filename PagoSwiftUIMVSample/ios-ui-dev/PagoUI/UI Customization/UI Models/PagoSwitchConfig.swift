//
//  PagoSwitchConfig.swift
//  PagoUISDK
//
//  Created by Bogdan on 08.03.2023.
//

import Foundation

internal struct PagoSwitchConfig: Codable {
    
    internal enum CodingKeys: String, CodingKey {
        case secondaryUncheckedColor, secondaryCheckedColor, primaryUncheckedColor, primaryCheckedColor, textLabelStyleKey = "textLabelStyle" }
    
    var secondaryUncheckedColor: PagoColorConfig? = PagoColorConfig(colorHex: "#B0B0B0")
    var secondaryCheckedColor: PagoColorConfig? = PagoColorConfig(colorHex: "#FFECA9")
    var primaryUncheckedColor: PagoColorConfig? = PagoColorConfig(colorHex: "#ECECEC")
    var primaryCheckedColor: PagoColorConfig? = PagoColorConfig(colorHex: "#FBC400")
    var textLabelStyleKey: String = "blackRegular14"
}
