//
//  UIColor+Extension.swift
//  Pago
//
//  Created by Gabi Chiosa on 23.02.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation
import UIKit

internal extension UIColor {

    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    public enum Pago: Equatable, Hashable {
        case blackBodyText, darkGraySecondaryText
        case grayTertiaryText, lightGrayInactive
        case blueHighlight, lightGrayBackground, dividers
        case yellowWarning, redNegative
        case yellowWarningWithAlpha(CGFloat), redNegativeWithAlpha(CGFloat)
        case greenPositive, lightGreenBackground, greenBackground
        case lightBlueBackground, lightBlackBackground, lightYellowBackground, lightRedBackground
        case clear, white
        case facebook, google
        case whiteTransparent
        case whiteWithAlpha(CGFloat)
        case blackWithAlpha(CGFloat)
        case lightGrayInactiveWithAlpha(CGFloat)
        case yellowSecondaryText, greenSecondaryText
        case vodafoneBackground, digiBackground, orangeBackground, telekomBackground
        case blue, lightBlue
        case info
        case custom(String)
        case skeletonBackground, skeletonInfo
        case sdkMainButtonColor, sdkButtonColor, sdkButtonColor1, sdkButtonTitleColor
        case sdkLightBackground
        case sdkDarkRed, sdkMixedGray
        
        case sdkDarkGray, sdkLightGray
        case sdkBgRed
        case sdkLightBgGray
        case sdkLightBgYellow
        case sdkBlackBodyText
        case sdkSubtitleColor
        case sdkShadowColor
        case sdkDividerBackground
        case sdkMainButtonInactiveColor
        case sdkCheckBoxLightGray
        
        public var color: UIColor {
            switch self {
            case .sdkShadowColor:
                return UIColor(hexString: "00000D")
            case .sdkSubtitleColor:
                return UIColor(hexString: "FCFCFC")
            case .sdkBlackBodyText:
                return UIColor(hexString: "161F28")
            case .sdkLightBgYellow:
                return UIColor(hexString: "FEECA9")
            case .sdkLightBgGray:
                return UIColor(hexString: "F3F3F3")
            case .sdkBgRed:
                return UIColor(hexString: "FCE7EA")
            case .sdkMixedGray:
                return UIColor(hexString: "614C00")
            case .sdkDarkRed:
                return UIColor(hexString: "E0132B")
            case .redNegativeWithAlpha(let percent):
                return UIColor.Pago.redNegative.color(withAlpha: percent)
            case .yellowWarningWithAlpha(let percent):
                return UIColor.Pago.yellowWarning.color(withAlpha: percent)
            case .custom(let hex):
                return UIColor(hexString: hex)
            case .skeletonInfo: return UIColor(hexString: "E9ECF2")
            case .skeletonBackground: return UIColor(hexString: "E0E3EC")
                
            case .blackWithAlpha(let percent):
                return UIColor.Pago.blackBodyText.color(withAlpha: percent)
            case .whiteWithAlpha(let percent):
                return UIColor.Pago.white.color(withAlpha: percent)
            case .blackBodyText:
                return #colorLiteral(red: 0.08847717196, green: 0.1218658164, blue: 0.1560683548, alpha: 1)
            case .darkGraySecondaryText:
                return #colorLiteral(red: 0.4436259866, green: 0.4935751557, blue: 0.6013864875, alpha: 1)
            case .grayTertiaryText:
                return #colorLiteral(red: 0.5960784314, green: 0.6467930675, blue: 0.7460646033, alpha: 1)
            case .lightGrayInactiveWithAlpha(let percent):
                return UIColor.Pago.lightGrayInactive.color(withAlpha: percent)
            case .lightGrayInactive:
                return #colorLiteral(red: 0.7568193078, green: 0.7841419578, blue: 0.8447401524, alpha: 1)
            case .lightRedBackground:
                return #colorLiteral(red: 1, green: 0.8983411193, blue: 0.8958156705, alpha: 1)
            case .blue:
                return UIColor(hexString: "2B59C3")
            case .blueHighlight:
                return #colorLiteral(red: 0.1708133817, green: 0.3482951522, blue: 0.763563931, alpha: 1)
            case .lightGrayBackground, .dividers:
                return #colorLiteral(red: 0.9333333333, green: 0.9491533637, blue: 0.9706513286, alpha: 1)
            case .yellowWarning:
                return #colorLiteral(red: 0.988443315, green: 0.6360397339, blue: 0.1051666811, alpha: 1)
            case .lightYellowBackground:
                return #colorLiteral(red: 1, green: 0.9431146979, blue: 0.8659834266, alpha: 1)
            case .redNegative:
                return #colorLiteral(red: 1, green: 0.3166674972, blue: 0.3167580366, alpha: 1)
            case .greenPositive:
                return #colorLiteral(red: 0.1714901626, green: 0.7851282954, blue: 0.3007323742, alpha: 1)
            case .lightGreenBackground:
                return #colorLiteral(red: 0.878192842, green: 0.9688040614, blue: 0.8923336864, alpha: 1)
            case .lightBlueBackground:
                return #colorLiteral(red: 0.8744592071, green: 0.901804626, blue: 0.9624077678, alpha: 1)
            case .lightBlackBackground:
                return #colorLiteral(red: 0.8611549735, green: 0.8708825707, blue: 0.8749362826, alpha: 1)
            case .clear:
                return #colorLiteral(red: 0.8611549735, green: 0.8708825707, blue: 0.8749362826, alpha: 0)
            case .white:
                return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case .whiteTransparent:
                return #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9843137255, alpha: 1)
            case .facebook:
                return #colorLiteral(red: 0.07934393734, green: 0.354385823, blue: 0.7923068404, alpha: 1)
            case .google:
                return #colorLiteral(red: 1, green: 0.3047307432, blue: 0.4092660248, alpha: 1)
            case .yellowSecondaryText:
                return #colorLiteral(red: 0.9882352941, green: 1, blue: 0.8078431373, alpha: 1)
            case .greenSecondaryText:
                return #colorLiteral(red: 0.7803921569, green: 1, blue: 0.5882352941, alpha: 1)
            case .greenBackground:
                return UIColor.init(hexString: "5EC072")
            case .vodafoneBackground:
                return #colorLiteral(red: 0.9294117647, green: 0.1058823529, blue: 0.1450980392, alpha: 1)
            case .digiBackground:
                return #colorLiteral(red: 0.06274509804, green: 0.1647058824, blue: 0.3215686275, alpha: 1)
            case .orangeBackground:
                return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .telekomBackground:
                return #colorLiteral(red: 0.8862745098, green: 0, blue: 0.4549019608, alpha: 1)
            case .lightBlue:
                return UIColor.init(hexString: "2B59C3").withAlphaComponent(0.15)
            case .info:
                return UIColor.init(hexString: "F7F8FB")
            case .sdkMainButtonColor:
                return UIColor.init(hexString: "FBC400")
            case .sdkButtonColor:
                return UIColor.init(hexString: "FFECA9")
            case .sdkButtonColor1:
                return UIColor.init(hexString: "FFCE45")
            case .sdkButtonTitleColor:
                return UIColor.init(hexString: "614C00")
            case .sdkDarkGray:
                return UIColor.init(hexString: "222222")
            case .sdkLightGray:
                return UIColor.init(hexString: "666666")
            case .sdkLightBackground:
                return UIColor.init(hexString: "FCFCFC")
            case .sdkDividerBackground:
                return UIColor.init(hexString: "E3E6E9")
            case .sdkMainButtonInactiveColor:
                return UIColor.init(hexString: "E5E5E5")
            case .sdkCheckBoxLightGray:
                return UIColor.init(hexString: "C6C6C6")
            }
        }
        
        public var cgColor: CGColor {
            return color.cgColor
        }
        
        public func color(withAlpha alpha: CGFloat) -> UIColor {
            return color.withAlphaComponent(alpha)
        }
        public func cgColor(withAlpha alpha: CGFloat) -> CGColor {
            return color(withAlpha: alpha).cgColor
        }
    }
}
