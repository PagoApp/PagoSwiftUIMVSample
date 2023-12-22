//
//  PagoThemeConfig.swift
//  PagoUISDK
//
//  Created by Bogdan on 08.03.2023.
//

import Foundation

internal struct PagoThemeConfig: Codable {
    
    //NOTE: default values for BT
    var baseUrl: String = "https://assets.pago.ro/sdk/"
    var integratorPrefix: String = "bt/"
    var integratorName: String? = "Banca Transilvania"
    var applicationName: String = "BT Pay"
    var dateFormat: String = "dd.MM.yyyy"
    var shortDateFormat: String = "dd.MM"
    var toolbarTitleStyle: String = "blackBold18"
    var locationIcon: PagoLocationIconConfig = PagoLocationIconConfig()
    var tabNavbar: PagoTopNavBarTypeConfig?
    var primaryBackgroundColor: PagoColorConfig = PagoColorConfig(colorHex: "#FCFCFC")
    var secondaryBackgroundColor: PagoColorConfig = PagoColorConfig(colorHex: "#FFFFFF")
    var tertiaryBackgroundColor: PagoColorConfig = PagoColorConfig(colorHex: "#F3F3F3")
    var quaternaryBackgroundColor: PagoColorConfig = PagoColorConfig(colorHex: "#FFECA9")
    var initialsColor: PagoColorConfig = PagoColorConfig(colorHex: "#FFECA9")
    var warningBackgroundColor: PagoColorConfig? = PagoColorConfig(colorHex: "#FCE7EA")
    var iconsColor: PagoColorConfig = PagoColorConfig(colorHex: "#666666")
    var selectedIconsColor: PagoColorConfig = PagoColorConfig(colorHex: "#036FD3")
    var backButtonColor: PagoColorConfig = PagoColorConfig(colorHex: "#222222")
    var xBtnColor: PagoColorConfig = PagoColorConfig(colorHex: "#222222")
    var searchBarIconColor: PagoColorConfig = PagoColorConfig(colorHex: "#666666")
    var searchBarHintColor: PagoColorConfig = PagoColorConfig(colorHex: "#666666")
    var highlightedOfferColor: PagoColorConfig = PagoColorConfig(colorHex: "#F3F3F3")
    var offersCellShadow: PagoShadowConfig = PagoShadowConfig(offset: 2, blur: 10)
    var offersCellBorder: PagoBorderConfig = PagoBorderConfig(width: 0)
    var generalArrowsColor: PagoColorConfig = PagoColorConfig(colorHex: "#222222")
    var tabSelectedLineColor: PagoColorConfig = PagoColorConfig(colorHex: "#FBC400")
    var tabUnselectedLineColor: PagoColorConfig = PagoColorConfig(colorHex: "#FBC400")
    var generalDividerHeight: PagoHeightConfig? = PagoHeightConfig(height: 1)
    var generalDividerColor: PagoColorConfig = PagoColorConfig(colorHex: "#FFFFFF")
    var generalViewCornerRadius: Int32 = 12
}

 
