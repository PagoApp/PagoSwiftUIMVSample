//
//  PagoCustomConfig.swift
//  PagoUISDK
//
//  Created by Bogdan on 07.03.2023.
//

import Foundation

internal struct PagoColorConfig: Codable {
    
    var colorHex: String?
}

internal struct PagoSolidColorConfig: Codable {
    
    var colorSolidHex: String?
    var colorGradientStartHex: String?
    var colorGradientEndHex: String?
}

internal struct PagoShadowConfig: Codable {
    
    var offset: Int32?
    var blur: Int32?
}

internal struct PagoBorderConfig: Codable {
    
    var color: PagoColorConfig?
    var width: Int32?
    var cornerRadius: Int?
}


internal struct PagoHeightConfig: Codable {
    
    var height: Int32?
}

 struct PagoUIConfig: Codable {
    
    internal enum CodingKeys: String, CodingKey {
        case theme, labelStyles, input, buttons, selector, talon, pagoSwitch = "switch", checkbox, stepCard, statusLabels, indicator
    }

    var theme: PagoThemeConfig = PagoThemeConfig()
    var labelStyles: [String: PagoLabelConfig] = [:]
    var input: PagoTextFieldConfig = PagoTextFieldConfig()
    var buttons: PagoButtonsConfig = PagoButtonsConfig()
    var selector: PagoSelectorConfig = PagoSelectorConfig()
    var talon: PagoTalonConfig = PagoTalonConfig()
    var pagoSwitch: PagoSwitchConfig = PagoSwitchConfig()
    var checkbox: PagoCheckboxConfig = PagoCheckboxConfig()
    var stepCard: PagoStepCardConfig = PagoStepCardConfig()
    var statusLabels: PagoStatusLabelConfig = PagoStatusLabelConfig()
    var indicator = PagoIndicatorConfig()
}
