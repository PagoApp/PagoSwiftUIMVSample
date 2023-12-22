//
//  PagoButtonConfig.swift
//  PagoUISDK
//
//  Created by Bogdan on 08.03.2023.
//

import Foundation

internal enum PagoButtonFontType: String {
    
    case bold
    case regular
}

internal struct PagoButtonConfig: Codable {
    
    var cornerRadius: Int? = 8
    var shadow: PagoShadowConfig = PagoShadowConfig(offset: 0, blur: 0)
    var textColor: PagoColorConfig = PagoColorConfig(colorHex: "#222222")
    var backgroundColor: PagoSolidColorConfig = PagoSolidColorConfig(colorSolidHex: "#FBC400")
    var allCaps: Bool? = false
    var height: Int32?
    var width: Int32?
    var font: String = "regular"
}

internal struct PagoButtonsConfig: Codable {
    
    var marginHorizontal: Int = 24
    
    var primaryButton: PagoButtonConfig = PagoButtonConfig(
        textColor: PagoColorConfig(
            colorHex: "#222222"
        ),
        backgroundColor: PagoSolidColorConfig(
            colorSolidHex: "#FBC400"
        ),
        height: 48
    )
    
    var primarySmallButton: PagoButtonConfig = PagoButtonConfig(
        textColor: PagoColorConfig(
            colorHex: "#614C00"
        ),
        backgroundColor: PagoSolidColorConfig(
            colorSolidHex: "#FFECA9"
        ),
        height: 48
    )
    
    var secondaryButton: PagoButtonConfig = PagoButtonConfig(
        textColor: PagoColorConfig(
            colorHex: "#FFECA9"
        ),
        backgroundColor: PagoSolidColorConfig(
            colorSolidHex: "#00FFFFFF"
        ),
        height: 48
    )
    
    var tertiaryButton: PagoButtonConfig = PagoButtonConfig(
        textColor: PagoColorConfig(
            colorHex: "#036FD3"
        ),
        backgroundColor: PagoSolidColorConfig(
            colorSolidHex: "#00FFFFFF"
        ),
        height: 48
    )
    
    var tertiaryDeactivatedButton: PagoButtonConfig = PagoButtonConfig(
        textColor: PagoColorConfig(
            colorHex: "#666666"
        ),
        backgroundColor: PagoSolidColorConfig(
            colorSolidHex: "#00FFFFFF"
        ),
        height: 48
    )
    
    var deactivatedButton: PagoButtonConfig = PagoButtonConfig(
        textColor: PagoColorConfig(
            colorHex: "#666666"
        ),
        backgroundColor: PagoSolidColorConfig(
            colorSolidHex: "#E5E5E5"
        ),
        height: 48
    )
    
    var warningButton: PagoButtonConfig = PagoButtonConfig(
        textColor: PagoColorConfig(
            colorHex: "#FFFFFF"
        ),
        backgroundColor: PagoSolidColorConfig(
            colorSolidHex: "#E0132B"
        ),
        height: 48
    )
    
    var warningSmallButton: PagoButtonConfig = PagoButtonConfig(
        textColor: PagoColorConfig(
            colorHex: "#E0132B"
        ),
        backgroundColor: PagoSolidColorConfig(
            colorSolidHex: "#FCE7EA"
        ),
        height: 48
    )
    
    var whiteButton: PagoButtonConfig = PagoButtonConfig(
        textColor: PagoColorConfig(
            colorHex: "#222222"
        ),
        backgroundColor: PagoSolidColorConfig(
            colorSolidHex: "#FFFFFF"
        ),
        height: 48
    )
    
    var attentionButton: PagoButtonConfig = PagoButtonConfig(
        textColor: PagoColorConfig(
            colorHex: "#AD5700"
        ),
        backgroundColor: PagoSolidColorConfig(
            colorSolidHex: "#FFF4D5"
        ),
        height: 48
    )
}
