//
// Created by LoredanaBenedic on 13.04.2023.
//

import Foundation

internal struct PagoCheckboxConfig: Codable {

    internal enum CodingKeys: String, CodingKey {
        case textStyleKey = "textStyle", errorTextStyleKey = "errorTextStyle", uncheckedColor, errorColor, checkedColor, cornerRadius, disabledBackgroundColor, errorBackgroundColor, backgroundColor }

    var textStyleKey: String = "blackRegular14"
    var errorTextStyleKey: String = "redRegular14"
    var uncheckedColor: PagoColorConfig? = PagoColorConfig(colorHex: "#C6C6C6")
    var errorColor: PagoColorConfig? = PagoColorConfig(colorHex: "#E0132B")
    var checkedColor: PagoColorConfig? = PagoColorConfig(colorHex: "#FBC400")
    var cornerRadius: Int = 8
    var disabledBackgroundColor: PagoSolidColorConfig? = PagoSolidColorConfig(colorSolidHex: "#F3F3F3")
    var errorBackgroundColor: PagoSolidColorConfig? = PagoSolidColorConfig(colorSolidHex: "#FCE7EA")
    var backgroundColor: PagoSolidColorConfig? = PagoSolidColorConfig(colorSolidHex: "#FFECA9")
    var backgroundInset: Int = 16
}
