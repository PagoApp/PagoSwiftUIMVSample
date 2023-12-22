//
//  PagoLegacyUITextField.swift
//  PagoUISDK
//
//  Created by Alex Udrea on 24.03.2023.
//

import UIKit

public class PagoLegacyUITextField: UITextField {
    
    required init() {
        super.init(frame: .zero)
        customisePlaceholder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customisePlaceholder()
    }
    
    private func customisePlaceholder(){
        let talonStyle = PagoTalonStyle.custom
        let color = talonStyle.hintLabelStyle.textColorType.color
        let font = talonStyle.hintLabelStyle.fontType.font
        let placeholderText = NSAttributedString(string: " ",
        attributes: [NSAttributedString.Key.foregroundColor: color,NSAttributedString.Key.font: font])
        attributedPlaceholder = placeholderText
    }
}
