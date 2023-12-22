//
//  UIBarButtonItem+Extension.swift
//  Pago
//
//  Created by Gabi Chiosa on 23.02.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation
import UIKit

internal extension UIBarButtonItem {

    public enum Pago {
        case navigation, action

        var attributes: [NSAttributedString.Key : Any] {
            switch self {
            case .navigation:
                return [NSAttributedString.Key.foregroundColor: UIColor.Pago.blackBodyText.color, NSAttributedString.Key.font: UIFont.Pago.semiBold17.font]
            case .action:
                return [NSAttributedString.Key.foregroundColor: UIColor.Pago.blueHighlight.color, NSAttributedString.Key.font: UIFont.Pago.semiBold17.font]
            }
        }
    }
    
    public func updateStyle(style: Pago) {
        
        self.setTitleTextAttributes(style.attributes, for: .normal)
    }
    
    public class func closeButton(_ target: Any?, action: Selector, tint: UIColor.Pago = .lightGrayInactive) -> UIBarButtonItem {

        let closeButton = UIBarButtonItem(image: UIImage.Pago.close.image(tinted: PagoThemeStyle.custom.xBtnColor), style: .plain, target: target, action: action)
        closeButton.width = CGFloat(40.0)
        return closeButton
    }
    
    public class func skipButton(_ target: Any?, action: Selector) -> UIBarButtonItem {
        
        let button = UIBarButtonItem(title: "26D5EDCD-835A-4A54-A518-66D2CE478700".localized, style: .done, target: target, action: action)
        button.updateStyle(style: .action)
        return button
    }
    
    class func infoButton(_ target: Any?, action: Selector) -> UIBarButtonItem {
        
        let button = UIBarButtonItem(image: UIImage.Pago.largeQuestionIcon.originalImage, style: .plain, target: target, action: action)
        return button
    }
}
