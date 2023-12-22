//
//  UIFont+Extension.swift
//  Pago
//
//  Created by Gabi Chiosa on 23.02.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    public enum Pago {
        case bold36, bold28, bold24, bold20, bold17, bold18, bold14, bold15, bold16, bold13, bold9
        case semiBold17, semiBold15, semiBold13, semiBold11
        case medium17, medium15, medium13, medium32, medium20
        case regular17, regular16, regular15, regular14, regular13, regular12, regular11, regular10
        case icon32, icon24, icon17, icon15, icon13, icon11
        case enchantedRegular53, enchantedRegular100
        case custom(String)
        case customConfig(CGFloat, UIFont.Weight)
        
        public var font: UIFont {
            switch self {
            case .enchantedRegular53:
                return UIFont(name: "EnchantedLand", size: 53) ?? UIFont.systemFont(ofSize: 36, weight: .bold)
            case .enchantedRegular100:
                return UIFont(name: "EnchantedLand", size: 100) ?? UIFont.systemFont(ofSize: 80, weight: .bold)
            case .bold9:
                return UIFont.systemFont(ofSize: 9, weight: .bold)
            case .bold36:
                return UIFont.systemFont(ofSize: 36, weight: .bold)
            case .bold13:
                return UIFont.systemFont(ofSize: 13, weight: .bold)
            case .bold16:
                return UIFont.systemFont(ofSize: 16, weight: .bold)
            case .bold28:
                return UIFont.systemFont(ofSize: 28, weight: .bold)
            case .bold20:
                return UIFont.systemFont(ofSize: 20, weight: .bold)
            case .bold24:
                return UIFont.systemFont(ofSize: 24, weight: .bold)
            case .bold17:
                return UIFont.systemFont(ofSize: 17, weight: .bold)
            case .bold18:
                return UIFont.systemFont(ofSize: 18, weight: .bold)
            case .bold15:
                return UIFont.systemFont(ofSize: 15, weight: .bold)
            case .bold14:
                return UIFont.systemFont(ofSize: 14, weight: .bold)
            case .semiBold17:
                return UIFont.systemFont(ofSize: 17, weight: .semibold)
            case .semiBold15:
                return UIFont.systemFont(ofSize: 15, weight: .semibold)
            case .semiBold13:
                return UIFont.systemFont(ofSize: 13, weight: .semibold)
            case .semiBold11:
                return UIFont.systemFont(ofSize: 11, weight: .semibold)
            case .medium20:
                return UIFont.systemFont(ofSize: 20, weight: .medium)
            case .medium32:
                return UIFont.systemFont(ofSize: 32, weight: .medium)
            case .medium17:
                return UIFont.systemFont(ofSize: 17, weight: .medium)
            case .medium15:
                return UIFont.systemFont(ofSize: 15, weight: .medium)
            case .medium13:
                return UIFont.systemFont(ofSize: 13, weight: .medium)
            case .regular16:
                return UIFont.systemFont(ofSize: 16, weight: .regular)
            case .regular17:
                return UIFont.systemFont(ofSize: 17, weight: .regular)
            case .regular16:
                return UIFont.systemFont(ofSize: 16, weight: .regular)
            case .regular15:
                return UIFont.systemFont(ofSize: 15, weight: .regular)
            case .regular14:
                return UIFont.systemFont(ofSize: 14, weight: .regular)
            case .regular13:
                return UIFont.systemFont(ofSize: 13, weight: .regular)
            case .regular12:
                return UIFont.systemFont(ofSize: 12, weight: .regular)
            case .regular11:
                return UIFont.systemFont(ofSize: 11, weight: .regular)
            case .regular10:
                return UIFont.systemFont(ofSize: 10, weight: .regular)
            case .icon32:
                return UIFont.init(name: "icomoon", size: 32) ?? UIFont()
            case .icon24:
                return UIFont.init(name: "icomoon", size: 24) ?? UIFont()
            case .icon17:
                return UIFont.init(name: "icomoon", size: 17) ?? UIFont()
            case .icon15:
                return UIFont.init(name: "icomoon", size: 15) ?? UIFont()
            case .icon13:
                return UIFont.init(name: "icomoon", size: 13) ?? UIFont()
            case .icon11:
                return UIFont.init(name: "icomoon", size: 11) ?? UIFont()
            case .custom(let fontName):
                return UIFont.init(name: fontName, size: 11) ?? UIFont.systemFont(ofSize: 14, weight: .regular)
            case .customConfig(let size, let weight):
                if let customFont = UIFont.Pago.font(forWeight: weight, size: size) {
                    return customFont
                } else {
                    //NOTE: if the integrator provided a custom font name and that font could not be loaded, we print a warining with the issue
                    let customFontName = weight == .regular ? PagoUIConfigurator.regularFontName : PagoUIConfigurator.boldFontName
                    if let customFontName = customFontName {
                        print("WARNING: \(customFontName) font not found")
                    }
                    return UIFont.systemFont(ofSize: size, weight: weight)
                }
            }
        }
        
        private static func font(forWeight weight: UIFont.Weight, size: CGFloat) -> UIFont? {
            let fontName: String?
            switch weight {
            case .regular:
                fontName = PagoUIConfigurator.regularFontName
            case .bold:
                fontName = PagoUIConfigurator.boldFontName
            default:
                fontName = nil
            }
            
            if let fontName = fontName, let font = UIFont(name: fontName, size: size) {
                return font
            } else {
                return nil
            }
        }
    }

}
