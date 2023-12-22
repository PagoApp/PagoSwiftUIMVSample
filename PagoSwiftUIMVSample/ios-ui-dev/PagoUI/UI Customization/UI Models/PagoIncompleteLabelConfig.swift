//
//  PagoIncompleteLabelConfig.swift
//  PagoUISDK
//
//  Created by Bogdan on 08.03.2023.
//

import Foundation

internal struct PagoStatusLabelStateModel: Codable {
    
    internal enum CodingKeys: String, CodingKey {
        case textStyleKey = "textStyle", backgroundColor, border, cornerRadius }
    
    var textStyleKey: String = "blackRegular14"
    var backgroundColor: PagoSolidColorConfig = PagoSolidColorConfig(colorSolidHex: "#FFECA9")
    var border: PagoBorderConfig = PagoBorderConfig(color: nil, width: 0)
    var cornerRadius: Int = 15
}

internal struct PagoStatusLabelConfig: Codable {
     
    var incompleteState: PagoStatusLabelStateModel = PagoStatusLabelStateModel()
    var editableState: PagoStatusLabelStateModel = PagoStatusLabelStateModel()
    var warningState: PagoStatusLabelStateModel = PagoStatusLabelStateModel()
    var normalState: PagoStatusLabelStateModel = PagoStatusLabelStateModel()
}
