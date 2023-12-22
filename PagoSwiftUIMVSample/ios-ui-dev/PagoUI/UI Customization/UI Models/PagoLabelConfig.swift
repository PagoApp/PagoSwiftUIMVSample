//
//  PagoLabelConfig.swift
//  PagoUISDK
//
//  Created by Bogdan on 08.03.2023.
//

import Foundation
import UIKit

internal enum PagoFontConfig: String, Codable {
    
    case regular, bold
    
    internal var fontWeight: UIFont.Weight {
        switch self {
        case .regular:
            return .regular
        case .bold:
            return .bold
        }
    }
}

internal struct PagoLabelConfig: Codable {
    var textSize: Int32?
    var textColor: PagoColorConfig?
    var fontStyle: PagoFontConfig?
    var isAllCaps: Bool? = false
}
