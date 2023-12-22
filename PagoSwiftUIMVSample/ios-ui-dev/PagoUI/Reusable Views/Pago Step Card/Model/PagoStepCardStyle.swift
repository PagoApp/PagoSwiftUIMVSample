//
//  PagoStepCardStyle.swift
//  PagoUISDK
//
//  Created by Bogdan on 01.03.2023.
//

import Foundation
import UIKit

public struct PagoStepCardStyle {
    
    var titleLabelStyle: PagoLabelStyle
    var detailLabelStyle: PagoLabelStyle
    var stepLabelStyle: PagoLabelStyle
    var backgroundColor: UIColor.Pago
    var numberBackgroundColor: UIColor.Pago
    var arrowIconColor: UIColor.Pago
    var shadowStyle: ShadowStyle?
    var borderStyle: BorderStyle?
    var stepCardCornerRadius: Int?
    
    public init(titleLabelStyle: PagoLabelStyle, detailLabelStyle: PagoLabelStyle, stepLabelStyle: PagoLabelStyle, backgroundColor: UIColor.Pago, numberBackgroundColor: UIColor.Pago, arrowIconColor: UIColor.Pago, shadowStyle: ShadowStyle? = nil, borderStyle: BorderStyle? = nil, stepCardCornerRadius: Int? = nil) {

        self.titleLabelStyle = titleLabelStyle
        self.detailLabelStyle = detailLabelStyle
        self.stepLabelStyle = stepLabelStyle
        self.backgroundColor = backgroundColor
        self.numberBackgroundColor = numberBackgroundColor
        self.arrowIconColor = arrowIconColor
        self.shadowStyle = shadowStyle
        self.borderStyle = borderStyle
        self.stepCardCornerRadius = stepCardCornerRadius
    }
 
}

extension PagoStepCardStyle {
    
    static func customStyle(stepCard: PagoStepCardConfig) -> PagoStepCardStyle {
        
        let labelStyles = PagoUIConfigurator.customConfig.labelStyles
        var titleLabelStyle = PagoLabelStyle(textColorType: .sdkBlackBodyText, fontType: .bold14, alignment: .left, numberOfLines: 2)
        if let fontConfig = labelStyles[stepCard.titleTextStyleKey] {
            let weight = (fontConfig.fontStyle == .regular) ? UIFont.Weight.regular : UIFont.Weight.bold
            let sizeConfig = fontConfig.textSize ?? 16
            if let colorHex = fontConfig.textColor?.colorHex {
                titleLabelStyle.textColorType = UIColor.Pago.custom(colorHex)
            }
            titleLabelStyle.fontType = UIFont.Pago.customConfig(CGFloat(sizeConfig), weight)
        }
        var detailLabelStyle = PagoLabelStyle(textColorType: .sdkLightGray, fontType: .regular14, alignment: .left, numberOfLines: 0)
        if let fontConfig = labelStyles[stepCard.bodyTextStyleKey] {
            let weight = (fontConfig.fontStyle == .regular) ? UIFont.Weight.regular : UIFont.Weight.bold
            let sizeConfig = fontConfig.textSize ?? 14
            if let colorHex = fontConfig.textColor?.colorHex {
                detailLabelStyle.textColorType = UIColor.Pago.custom(colorHex)
            }
            detailLabelStyle.fontType = UIFont.Pago.customConfig(CGFloat(sizeConfig), weight)
        }
        let size = PagoSize(width: 34, height: 34)
        let labelCornerRadius = Int((size.height ?? 34)/2)
        var numberBackgroundColor = UIColor.Pago.sdkLightBgGray
        if let colorHex = stepCard.numberBackgroundColor.colorSolidHex {
            numberBackgroundColor = UIColor.Pago.custom(colorHex)
        }
        var stepLabelStyle = PagoLabelStyle(fontType: .bold17, size: size, backgroundColorType: numberBackgroundColor, tintColorType: .white, alignment: .center, cornerRadius: labelCornerRadius)
        if let fontConfig = labelStyles[stepCard.stepTextStyleKey] {
            let weight = (fontConfig.fontStyle == .regular) ? UIFont.Weight.regular : UIFont.Weight.bold
            let sizeConfig = fontConfig.textSize ?? 14
            if let colorHex = fontConfig.textColor?.colorHex {
                stepLabelStyle.textColorType = UIColor.Pago.custom(colorHex)
            }
            stepLabelStyle.fontType = UIFont.Pago.customConfig(CGFloat(sizeConfig), weight)
        }
        var backgroundColor = UIColor.Pago.white
        if let colorHex = stepCard.backgroundColor.colorSolidHex {
            backgroundColor = UIColor.Pago.custom(colorHex)
        }
        var arrowIconColor = UIColor.Pago.sdkDarkGray
        if let arrowIconColorHex = PagoUIConfigurator.customConfig.theme.generalArrowsColor.colorHex {
            arrowIconColor = UIColor.Pago.custom(arrowIconColorHex)
        }
        var shadowStyle: ShadowStyle? = nil
        if let radius = stepCard.shadow.blur ,
           let offsetConfig = stepCard.shadow.offset {
            let offset = CGSize(width: CGFloat(offsetConfig), height: CGFloat(offsetConfig))
            shadowStyle = ShadowStyle(radius: CGFloat(radius)/2, offset: offset)
        }
        var borderStyle: BorderStyle? = nil
        if let borderColorHex = stepCard.border.color?.colorHex,
           let width = stepCard.border.width {
            let borderColor = UIColor.Pago.custom(borderColorHex)
            let borderWidth = CGFloat(width)
            borderStyle = BorderStyle(colorType: borderColor, width: borderWidth)
        }
        let stepCardCornerRadius = stepCard.cornerRadius
        return PagoStepCardStyle(titleLabelStyle: titleLabelStyle, detailLabelStyle: detailLabelStyle, stepLabelStyle: stepLabelStyle, backgroundColor: backgroundColor, numberBackgroundColor: numberBackgroundColor, arrowIconColor: arrowIconColor, shadowStyle: shadowStyle, borderStyle: borderStyle, stepCardCornerRadius: stepCardCornerRadius)
    }
}
