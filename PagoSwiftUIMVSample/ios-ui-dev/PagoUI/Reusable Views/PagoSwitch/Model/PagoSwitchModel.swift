//
//  
//  PagoSwitchModel.swift
//  PagoUISDK
//
//  Created by Gabi on 10.08.2022.
//
//
import PagoUISDK
import UIKit

public struct PagoSwitchModel: Model {

    var isOn: Bool
    let style: PagoSwitchStyle
    
    public init(isOn: Bool = false, style: PagoSwitchStyle = PagoSwitchStyle()) {
        
        self.isOn = isOn
        self.style = style
    }
}
