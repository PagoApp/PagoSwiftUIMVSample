//
//  PagoSwitchStyle.swift
//  PagoUISDK
//
//  Created by Gabi on 10.08.2022.
//

import Foundation
import UIKit

public struct PagoSwitchStyle: BaseStyle {
    
    let color: UIColor.Pago
    //TODO: Add insets, and other properties when required
    
    public init(color: UIColor.Pago = .sdkMainButtonColor) {
        
        self.color = color
    }
}
