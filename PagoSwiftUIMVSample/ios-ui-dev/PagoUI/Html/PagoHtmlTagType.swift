//
//  PagoHtmlTagType.swift
//  PagoUISDK
//
//  Created by Cosmin Iulian on 27.09.2023.
//

import UIKit

public enum PagoHtmlTagType {
    
    //TODO: - add cases if needed
    case bold
    
    internal var startTag: String {
        switch self {
        case .bold: return "<b>"
        }
    }
    internal var endTag: String {
        switch self {
        case .bold: return "</b>"
        }
    }
}
