//
//  PagoSelectorConfig.swift
//  PagoUISDK
//
//  Created by Bogdan on 08.03.2023.
//

import Foundation

public struct PagoSelectorConfig: Codable {
    
    internal enum CodingKeys: String, CodingKey {
        case filledLabelStyleKey = "filledLabelStyle", titleLabelStyleKey = "titleLabelStyle", hintLabelStyleKey = "hintLabelStyle", errorLabelStyleKey = "errorLabelStyle", iconColor, backgroundColor, cornerRadius, border, shadow }
    
    var filledLabelStyleKey: String? = "blackRegular16"
    var titleLabelStyleKey: String? = "greyRegular14"
    var hintLabelStyleKey: String? = "greyRegular16"
    var errorLabelStyleKey: String? = "redRegular14"
    var iconColor: PagoColorConfig? = PagoColorConfig(colorHex: "#666666")
    var backgroundColor: PagoSolidColorConfig? = PagoSolidColorConfig(colorSolidHex: "#FFFFFF")
    var cornerRadius: Int? = 10
    var border: PagoBorderConfig? = nil
    var shadow: PagoShadowConfig? = PagoShadowConfig(offset: 2, blur: 10)
}
