//
//  PagoLogConfigurator.swift
//  PagoSDK
//
//  Created by Gabi on 12.05.2022.
//

import Foundation

open class PagoLogConfigurator {
    
    internal let isEnabled: Bool
    weak var delegate: PagoLogDelegate?

    public init(isEnabled: Bool = false) {
            
        self.isEnabled = isEnabled
    }
}
