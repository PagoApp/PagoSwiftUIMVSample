//
// Created by LoredanaBenedic on 14.03.2023.
//

import Foundation

extension DataRepository {

    enum PagoComponents: Int, CaseIterable {
        case button = 0, textView, menu, images, custom, pageControllers, swiftUIInfoScreen
        var title: String {
            switch self {
            case .button: return "PagoButton"
            case .textView: return "PagoTextView"
            case .menu: return "PagoMenu"
            case .images: return "PagoLoadedImage"
            case .custom: return "PagoCustomComponent"
            case .pageControllers: return "PagoPageControllers"
            case .swiftUIInfoScreen: return "PagoSwiftUIInfoScreen"
            }
        }
    }
}
