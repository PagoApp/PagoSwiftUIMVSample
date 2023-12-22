//
//  PagoStepCardConfig.swift
//  PagoUISDK
//
//  Created by Bogdan on 08.03.2023.
//

import Foundation

internal struct PagoStepCardConfig: Codable {
    
    internal enum CodingKeys: String, CodingKey {
        case titleTextStyleKey = "titleTextStyle", bodyTextStyleKey = "bodyTextStyle", stepTextStyleKey = "stepTextStyle", cornerRadius, backgroundColor, shadow, border, numberBackgroundColor }
    
    //NOTE: default values for BT
    var titleTextStyleKey: String = "blackBold16"
    var bodyTextStyleKey: String = "greyRegular14"
    var stepTextStyleKey: String = "blackBold16"
    var cornerRadius: Int = 10
    var backgroundColor: PagoSolidColorConfig = PagoSolidColorConfig(colorSolidHex: "#FFFFFF")
    var shadow: PagoShadowConfig = PagoShadowConfig(offset: 2, blur: 10)
    var border: PagoBorderConfig = PagoBorderConfig(width: 0)
    var numberBackgroundColor: PagoSolidColorConfig = PagoSolidColorConfig(colorSolidHex: "#F3F3F3")
}
