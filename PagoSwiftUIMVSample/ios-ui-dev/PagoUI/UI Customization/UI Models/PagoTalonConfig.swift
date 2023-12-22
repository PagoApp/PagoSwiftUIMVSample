//
//  PagoTalonConfig.swift
//  PagoUISDK
//
//  Created by Bogdan on 08.03.2023.
//

import Foundation

internal struct PagoTalonConfig: Codable {
    
    internal enum CodingKeys: String, CodingKey {
        case talonBackgroundColor, talonLeftColor, talonRightColor, highlightColor, nextButton, prevButton, disabledButton, zoomButton, hintLabelStyleKey = "hintLabelStyle", filledLabelStyleKey = "filledLabelStyle" }
    
    var talonBackgroundColor: PagoColorConfig = PagoColorConfig(colorHex: "#FFECA9")
    var talonLeftColor: PagoColorConfig = PagoColorConfig(colorHex: "#F9FCF8")
    var talonRightColor: PagoColorConfig = PagoColorConfig(colorHex: "#FEFEF4")
    var highlightColor: PagoColorConfig = PagoColorConfig(colorHex: "#FBC400")
    var nextButton: PagoButtonConfig = PagoButtonConfig(cornerRadius: 0, textColor: PagoColorConfig(colorHex: "#222222"), backgroundColor: PagoSolidColorConfig(colorSolidHex: "#FBC400"))
    var prevButton: PagoButtonConfig = PagoButtonConfig(cornerRadius: 0, textColor: PagoColorConfig(colorHex: "#222222"), backgroundColor: PagoSolidColorConfig(colorSolidHex: "#E3B203"))
    var disabledButton: PagoButtonConfig = PagoButtonConfig(cornerRadius: 0, textColor: PagoColorConfig(colorHex: "#222222"), backgroundColor: PagoSolidColorConfig(colorSolidHex: "#E5E5E5"))
    var zoomButton: PagoButtonConfig = PagoButtonConfig(cornerRadius: 0, textColor: PagoColorConfig(colorHex: "#222222"), backgroundColor: PagoSolidColorConfig(colorSolidHex: "#FBC400"))
    var hintLabelStyleKey: String = "greyRegular16"
    var filledLabelStyleKey: String = "blackRegular16"
}
