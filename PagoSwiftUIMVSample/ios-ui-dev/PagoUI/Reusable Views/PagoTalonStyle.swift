//
//  PagoTalonStyle.swift
//  PagoUISDK
//
//  Created by Alex Udrea on 21.03.2023.
//

import Foundation
import UIKit

public struct PagoTalonStyle {
    
    private static var _custom: PagoTalonStyle?
    public static var custom: PagoTalonStyle {
        if _custom == nil {
            _custom = PagoTalonStyle.customConfig()
        }
        return _custom!
    }
    
    public var backButtonStyle: PagoButtonStyle
    public var forwardButtonStyle: PagoButtonStyle
    public var zoomButtonStyle: PagoButtonStyle
    public var disabledButtonStyle: PagoButtonStyle
    public var backgroundColor: UIColor.Pago
    public var leftBackgroundColor: UIColor.Pago
    public var rightBackgroundColor: UIColor.Pago
    public var highlightColor: UIColor.Pago
    public var hintLabelStyle: PagoLabelStyle
    public var filledLabelStyle: PagoLabelStyle

    public init(backButtonStyle: PagoButtonStyle, forwardButtonStyle: PagoButtonStyle, zoomButtonStyle: PagoButtonStyle, disabledButtonStyle: PagoButtonStyle, backgroundColor: UIColor.Pago, leftBackgroundColor: UIColor.Pago, rightBackgroundColor: UIColor.Pago, highlightColor: UIColor.Pago , hintLabelStyle: PagoLabelStyle, filledLabelStyle: PagoLabelStyle) {
        
        self.backButtonStyle = backButtonStyle
        self.forwardButtonStyle = forwardButtonStyle
        self.zoomButtonStyle = zoomButtonStyle
        self.backgroundColor = backgroundColor
        self.leftBackgroundColor = leftBackgroundColor
        self.rightBackgroundColor = rightBackgroundColor
        self.highlightColor = highlightColor
        self.hintLabelStyle = hintLabelStyle
        self.filledLabelStyle = filledLabelStyle
        self.disabledButtonStyle = disabledButtonStyle
    }

    //NOTE: used when changing the theme
    public static func resetTalonStyle() {
        _custom = nil
    }
}

extension PagoTalonStyle {
    
    public static func customConfig() -> PagoTalonStyle {
        
        let talonConfig = PagoUIConfigurator.customConfig.talon
        var backgroundColor = UIColor.Pago.sdkLightGray
        if let backgroundColorHex = talonConfig.talonBackgroundColor.colorHex {
            backgroundColor = UIColor.Pago.custom(backgroundColorHex)
        }
        
        var leftBackgroundColor = UIColor.Pago.sdkLightGray
        if let leftBackgroundColorHex = talonConfig.talonLeftColor.colorHex {
            leftBackgroundColor = UIColor.Pago.custom(leftBackgroundColorHex)
        }
        
        var rightBackgroundColor = UIColor.Pago.sdkLightGray
        if let rightBackgroundColorHex = talonConfig.talonRightColor.colorHex {
            rightBackgroundColor = UIColor.Pago.custom(rightBackgroundColorHex)
        }
        
        var highlightColor = UIColor.Pago.sdkLightGray
        if let highlightColorHex = talonConfig.highlightColor.colorHex {
            highlightColor = UIColor.Pago.custom(highlightColorHex)
        }
        let backButtonStyle = PagoButtonStyle.customStyle(buttonConfig: talonConfig.prevButton)
        let forwardButtonStyle = PagoButtonStyle.customStyle(buttonConfig: talonConfig.nextButton)
        let disabledButtonStyle = PagoButtonStyle.customStyle(buttonConfig: talonConfig.disabledButton)
        let zoomButtonStyle = PagoButtonStyle.customStyle(buttonConfig: talonConfig.zoomButton)
        
        let labelStyles = PagoUIConfigurator.customConfig.labelStyles
        var hintLabelStyle = PagoLabelStyle(textColorType: .sdkLightGray, fontType: .regular12)
        let hintLabelStyleKey = talonConfig.hintLabelStyleKey
        if  let fontConfig = labelStyles[hintLabelStyleKey] {
            let weight = (fontConfig.fontStyle == .regular) ? UIFont.Weight.regular : UIFont.Weight.bold
            let sizeConfig = fontConfig.textSize ?? 12
            if let colorHex = fontConfig.textColor?.colorHex {
                hintLabelStyle.textColorType = UIColor.Pago.custom(colorHex)
            }
            hintLabelStyle.fontType = UIFont.Pago.customConfig(CGFloat(sizeConfig), weight)
        }
        var filledLabelStyle = PagoLabelStyle(textColorType: .sdkLightGray, fontType: .regular12)
        let filledLabelStyleKey = talonConfig.filledLabelStyleKey
        if let fontConfig = labelStyles[filledLabelStyleKey] {
            let weight = (fontConfig.fontStyle == .regular) ? UIFont.Weight.regular : UIFont.Weight.bold
            let sizeConfig = fontConfig.textSize ?? 12
            if let colorHex = fontConfig.textColor?.colorHex {
                filledLabelStyle.textColorType = UIColor.Pago.custom(colorHex)
            }
            filledLabelStyle.fontType = UIFont.Pago.customConfig(CGFloat(sizeConfig), weight)
        }
        
        return PagoTalonStyle(backButtonStyle: backButtonStyle, forwardButtonStyle: forwardButtonStyle, zoomButtonStyle: zoomButtonStyle, disabledButtonStyle: disabledButtonStyle, backgroundColor: backgroundColor, leftBackgroundColor: leftBackgroundColor, rightBackgroundColor: rightBackgroundColor, highlightColor: highlightColor, hintLabelStyle: hintLabelStyle, filledLabelStyle: filledLabelStyle)
    }
}
