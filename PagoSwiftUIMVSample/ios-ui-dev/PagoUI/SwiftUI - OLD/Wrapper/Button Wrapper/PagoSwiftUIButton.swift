//
//  PagoSwiftUIButton.swift
//  PagoUI
//
//  Created by Cosmin Iulian on 06.10.2023.
//

import UIKit
import PagoUISDK

internal final class PagoSwiftUIButton: PagoButton {
    
    internal override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        guard let superview = superview else { return }
        
        let constraints = [
            topAnchor.constraint(equalTo: superview.topAnchor),
            leftAnchor.constraint(equalTo: superview.leftAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            rightAnchor.constraint(equalTo: superview.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
