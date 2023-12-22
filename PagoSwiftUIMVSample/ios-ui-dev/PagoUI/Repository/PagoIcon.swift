//
// Created by LoredanaBenedic on 22.04.2023.
//

import Foundation

internal enum PagoIcon: String {

    case squareCheckboxSelected, squareCheckboxDeselected
    case roundCheckboxMultipleSelected, roundCheckboxDeselected, roundCheckboxSingleSelected
    case warning
    
    internal var data: BackendImage {
        let baseUrl = PagoThemeStyle.custom.baseUrl
        let integratorPrefix = PagoThemeStyle.custom.integratorPrefix
        let base = "\(baseUrl)\(integratorPrefix)%@.png"
        switch self {
        case .squareCheckboxSelected:
            let url = String(format: base, "icon_checkbox_selected")
            return BackendImage(url: url, placeholderImageName: "")
        case .squareCheckboxDeselected:
            let url = String(format: base, "icon_checkbox_deselected")
            return BackendImage(url: url, placeholderImageName: "")
        case .roundCheckboxMultipleSelected:
            let url = String(format: base, "icon_rounded_checkbox_multiple_selected")
            return BackendImage(url: url, placeholderImageName: "")
        case .roundCheckboxDeselected:
            let url = String(format: base,"icon_rounded_checkbox_deselected")
            return BackendImage(url: url, placeholderImageName: "")
        case .roundCheckboxSingleSelected:
            let url = String(format: base, "icon_rounded_checkbox_selected")
            return BackendImage(url: url, placeholderImageName: "")
        case .warning:
            let url = String(format: base, "ic_warning")
            return BackendImage(url: url, placeholderImageName: "")
        }
    }
}
