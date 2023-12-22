//
//  PagoUILabel.swift
//  PagoUI
//
//  Created by Alex Udrea on 10.11.2023.
//

import UIKit
import PagoUISDK

internal final class PagoSwiftUILabel: PagoLabel {
    
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
