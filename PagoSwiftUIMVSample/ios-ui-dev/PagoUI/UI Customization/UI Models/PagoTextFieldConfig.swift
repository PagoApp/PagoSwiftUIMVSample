//
//  PagoTextViewConfig.swift
//  PagoUISDK
//
//  Created by Bogdan on 08.03.2023.
//

import Foundation

internal struct PagoTextFieldConfig: Codable {
    
    internal enum CodingKeys: String, CodingKey {
        case isTopHintUppercase,
             topHintStyleKey = "topHintStyle",
             inlineHintStyleKey = "inlineHintStyle",
             bottomHintStyleKey = "bottomHintStyle",
             inputStyleKey = "inputStyle",
             errorStyleKey = "errorStyle",
             iconColor, iconBackgroundColor, backgroundColor, cornerRadius, textColor, underlineColor, underlineErrorColor, underlineFocusColor, border, shadow }
    
    var isTopHintUppercase: Bool = false
    var topHintStyleKey: String = "topHintStyle"
    var inlineHintStyleKey: String = "greyRegular16"
    var bottomHintStyleKey: String = "greyRegular12"
    var inputStyleKey: String = "blackRegular16"
    var errorStyleKey: String = "redRegular12"
    var iconColor: PagoColorConfig = PagoColorConfig(colorHex: "#614C00")
    var iconBackgroundColor: PagoSolidColorConfig = PagoSolidColorConfig(colorSolidHex: "#FFECA9")
    var backgroundColor: PagoSolidColorConfig = PagoSolidColorConfig(colorSolidHex: "#FFFFFF")
    var cornerRadius: Int = 12
    var textColor: PagoColorConfig? = PagoColorConfig(colorHex: "#666666")
    var underlineColor: PagoColorConfig = PagoColorConfig(colorHex: "#666666")
    var underlineErrorColor: PagoColorConfig = PagoColorConfig(colorHex: "#E0132B")
    var underlineFocusColor: PagoColorConfig = PagoColorConfig(colorHex: "#FBC400")
    var border: PagoBorderConfig = PagoBorderConfig(width: 0)
    var shadow: PagoShadowConfig = PagoShadowConfig(offset: 2, blur: 10)
}

