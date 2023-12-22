//
// Created by LoredanaBenedic on 14.03.2023.
//

import Foundation
import PagoUISDK

extension DataRepository {

    static func getPagoButtonStyles() -> [PagoButtonStyle?] {

        let styles: [PagoButtonStyle] = PagoButtonStyle.Pago.allCases.map({PagoButtonStyle.style(for: $0)})
        return styles
    }
}
