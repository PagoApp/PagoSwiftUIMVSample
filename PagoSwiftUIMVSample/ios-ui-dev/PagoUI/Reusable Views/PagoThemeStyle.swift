//
//  PagoThemeStyle.swift
//  PagoUISDK
//
//  Created by Bogdan on 31.03.2023.
//

import Foundation
import UIKit

public struct PagoThemeStyle {
    
    private static var _custom: PagoThemeStyle?
    public static var custom: PagoThemeStyle {
        if _custom == nil {
            _custom = PagoThemeStyle.customConfig()
        }
        return _custom!
    }
    
    public var baseUrl: String = "https://assets.pago.ro/sdk/"
    public var integratorPrefix: String = "bt/"
    public var integratorName: String = "Banca Transilvania"
    public var applicationName: String = "BT Pay"
    public var dateFormat: String = "dd.MM.yyyy"
    public var shortDateFormat: String = "dd.MM"
    public var toolbarTitleStyle: String = "blackBold18"
    public var locationIconStyle: PagoLocationIconStyle = PagoLocationIconStyle()
    public var topNavigationBarStyle: PagoTopNavBarStateStyle = PagoTopNavBarStateStyle()
    public var primaryBackgroundColor: UIColor.Pago = .sdkSubtitleColor
    public var secondaryBackgroundColor: UIColor.Pago = .white
    public var tertiaryBackgroundColor: UIColor.Pago = .sdkLightBgGray
    public var quaternaryBackgroundColor: UIColor.Pago = .sdkLightBgGray
    public var initialsColor: UIColor.Pago = .sdkLightBgGray
    public var warningBackgroundColor: UIColor.Pago = .sdkBgRed
    public var iconsColor: UIColor.Pago = .sdkLightGray
    public var selectedIconsColor: UIColor.Pago = .sdkLightGray
    public var backButtonColor: UIColor.Pago = .sdkDarkGray
    public var xBtnColor: UIColor.Pago = .sdkDarkGray
    public var searchBarStyle: PagoSearchBarStyle = PagoSearchBarStyle()
    public var highlightedOfferColor: UIColor.Pago = .sdkLightBgGray
    public var offersCellShadow: ShadowStyle = ShadowStyle()
    public var offersCellBorder: BorderStyle = BorderStyle()
    public var generalArrowsColor: UIColor.Pago = .sdkDarkGray
    public var generalDividerColor: UIColor.Pago = .white
    public var tabSelectedLineColor: UIColor.Pago = .sdkButtonColor
    public var tabUnselectedLineColor: UIColor.Pago = .sdkLightBgGray
    public var generalViewCornerRadius: Int32 = 12
    public var generalDividerHeight: CGFloat = 1
    
    init(baseUrl: String, integratorPrefix: String, integratorName: String, applicationName: String, dateFormat: String, shortDateFormat: String, toolbarTitleStyle: String, locationIconStyle: PagoLocationIconStyle, topNavigationBarStyle: PagoTopNavBarStateStyle, primaryBackgroundColor: UIColor.Pago, secondaryBackgroundColor: UIColor.Pago, tertiaryBackgroundColor: UIColor.Pago, quaternaryBackgroundColor: UIColor.Pago, initialsColor: UIColor.Pago, warningBackgroundColor: UIColor.Pago, iconsColor: UIColor.Pago, selectedIconsColor: UIColor.Pago, backButtonColor: UIColor.Pago, xBtnColor: UIColor.Pago, searchBarStyle: PagoSearchBarStyle, highlightedOfferColor: UIColor.Pago, offersCellShadow: ShadowStyle, offersCellBorder: BorderStyle, generalArrowsColor: UIColor.Pago, generalDividerColor: UIColor.Pago, tabSelectedLineColor: UIColor.Pago, tabUnselectedLineColor: UIColor.Pago, generalViewCornerRadius: Int32, generalDividerHeight: CGFloat) {
        self.baseUrl = baseUrl
        self.integratorPrefix = integratorPrefix
        self.integratorName = integratorName
        self.applicationName = applicationName
        self.dateFormat = dateFormat
        self.shortDateFormat = shortDateFormat
        self.toolbarTitleStyle = toolbarTitleStyle
        self.primaryBackgroundColor = primaryBackgroundColor
        self.secondaryBackgroundColor = secondaryBackgroundColor
        self.tertiaryBackgroundColor = tertiaryBackgroundColor
		self.quaternaryBackgroundColor = quaternaryBackgroundColor
        self.initialsColor = initialsColor
        self.iconsColor = iconsColor
        self.selectedIconsColor = selectedIconsColor
        self.backButtonColor = backButtonColor
        self.xBtnColor = xBtnColor
        self.searchBarStyle = searchBarStyle
        self.highlightedOfferColor = highlightedOfferColor
        self.offersCellShadow = offersCellShadow
        self.offersCellBorder = offersCellBorder
        self.generalArrowsColor = generalArrowsColor
        self.generalDividerColor = generalDividerColor
        self.tabSelectedLineColor = tabSelectedLineColor
        self.tabUnselectedLineColor = tabUnselectedLineColor
        self.generalViewCornerRadius = generalViewCornerRadius
        self.generalDividerHeight = generalDividerHeight
        self.locationIconStyle = locationIconStyle
        self.topNavigationBarStyle = topNavigationBarStyle
    }
    
    //NOTE: used when changing the theme
    public static func resetTheme() {
        _custom = nil
    }
}

extension PagoThemeStyle {
    
    static func customConfig() -> PagoThemeStyle {
        
        let theme = PagoUIConfigurator.customConfig.theme
        var integratorName = theme.integratorName ?? "Banca Transilvania"
        var applicationName = theme.applicationName
        var primaryBackgroundColor = UIColor.Pago.sdkSubtitleColor
        if let primaryBackgroundColorHex = theme.primaryBackgroundColor.colorHex {
            primaryBackgroundColor = UIColor.Pago.custom(primaryBackgroundColorHex)
        }
        var secondaryBackgroundColor = UIColor.Pago.white
        if let secondaryBackgroundColorHex = theme.secondaryBackgroundColor.colorHex {
            secondaryBackgroundColor = UIColor.Pago.custom(secondaryBackgroundColorHex)
        }
        var tertiaryBackgroundColor = UIColor.Pago.sdkLightBgGray
        if let tertiaryBackgroundColorHex = theme.tertiaryBackgroundColor.colorHex {
            tertiaryBackgroundColor = UIColor.Pago.custom(tertiaryBackgroundColorHex)
        }
        var quaternaryBackgroundColor = UIColor.Pago.sdkLightBgGray
        if let quaternaryBackgroundColorHex = theme.quaternaryBackgroundColor.colorHex {
            quaternaryBackgroundColor = UIColor.Pago.custom(quaternaryBackgroundColorHex)
        }
        var initialsColor = UIColor.Pago.sdkLightBgGray
        if let initialsColorColorHex = theme.initialsColor.colorHex {
            initialsColor = UIColor.Pago.custom(initialsColorColorHex)
        }
        var warningBackgroundColor = UIColor.Pago.sdkBgRed
        if let warningBackgroundColorHex = theme.warningBackgroundColor?.colorHex {
            warningBackgroundColor = UIColor.Pago.custom(warningBackgroundColorHex)
        }
        var iconsColor = UIColor.Pago.sdkLightGray
        if let iconsColorHex = theme.iconsColor.colorHex {
            iconsColor = UIColor.Pago.custom(iconsColorHex)
        }
        var selectedIconsColor = UIColor.Pago.sdkLightGray
        if let selectedIconsColorHex = theme.selectedIconsColor.colorHex {
            selectedIconsColor = UIColor.Pago.custom(selectedIconsColorHex)
        }
        var backButtonColor = UIColor.Pago.sdkDarkGray
        if let backButtonColorHex = theme.backButtonColor.colorHex {
            backButtonColor = UIColor.Pago.custom(backButtonColorHex)
        }
        var xButtonColor = UIColor.Pago.sdkDarkGray
        if let xButtonColorHex = theme.xBtnColor.colorHex {
            xButtonColor = UIColor.Pago.custom(xButtonColorHex)
        }
        var searchBarIconColor = UIColor.Pago.sdkLightGray
        if let searchBarIconColorHex = theme.searchBarIconColor.colorHex {
            searchBarIconColor = UIColor.Pago.custom(searchBarIconColorHex)
        }
        var searchBarHintColor = UIColor.Pago.sdkLightGray
        if let searchBarHintColorHex = theme.searchBarHintColor.colorHex {
            searchBarHintColor = UIColor.Pago.custom(searchBarHintColorHex)
        }
        let searchBarStyle = PagoSearchBarStyle(iconColor: searchBarIconColor, hintColor: searchBarHintColor)
        var highlightedOfferColor = UIColor.Pago.sdkLightBgGray
        if let highlightedOfferColorHex = theme.highlightedOfferColor.colorHex {
            highlightedOfferColor = UIColor.Pago.custom(highlightedOfferColorHex)
        }
        var offersCellShadow: ShadowStyle = ShadowStyle()
        if let radius = theme.offersCellShadow.blur ,
           let offsetConfig = theme.offersCellShadow.offset {
            let offset = CGSize(width: CGFloat(offsetConfig), height: CGFloat(offsetConfig))
            offersCellShadow = ShadowStyle(radius: CGFloat(radius)/2, offset: offset)
        }
        var offersCellBorder: BorderStyle = BorderStyle(width: 0)
        if let borderColorHex = theme.offersCellBorder.color?.colorHex,
           let width = theme.offersCellBorder.width {
            let borderColor = UIColor.Pago.custom(borderColorHex)
            let borderWidth = CGFloat(width)
            offersCellBorder = BorderStyle(colorType: borderColor, width: borderWidth)
        }
        var generalArrowsColor = UIColor.Pago.sdkDarkGray
        if let generalArrowsColorHex = theme.generalArrowsColor.colorHex {
            generalArrowsColor = UIColor.Pago.custom(generalArrowsColorHex)
        }
        var generalDividerColor = UIColor.Pago.white
        if let generalDividerColorHex = theme.generalDividerColor.colorHex {
            generalDividerColor = UIColor.Pago.custom(generalDividerColorHex)
        }
        var tabSelectedLineColor = UIColor.Pago.sdkButtonColor
        if let tabSelectedLineColorHex = theme.tabSelectedLineColor.colorHex {
            tabSelectedLineColor = UIColor.Pago.custom(tabSelectedLineColorHex)
        }
        var tabUnselectedLineColor = UIColor.Pago.sdkLightBgGray
        if let tabUnselectedLineColorHex = theme.tabUnselectedLineColor.colorHex {
            tabUnselectedLineColor = UIColor.Pago.custom(tabUnselectedLineColorHex)
        }
        
        let locationIconStyle = theme.locationIcon.toStyle
        let topNavigationBarStyle = theme.tabNavbar?.toStyle ?? PagoTopNavBarTypeConfig().toStyle

        return PagoThemeStyle(baseUrl: theme.baseUrl, integratorPrefix: theme.integratorPrefix, integratorName: integratorName, applicationName: applicationName, dateFormat: theme.dateFormat, shortDateFormat: theme.shortDateFormat, toolbarTitleStyle: theme.toolbarTitleStyle, locationIconStyle: locationIconStyle, topNavigationBarStyle: topNavigationBarStyle, primaryBackgroundColor: primaryBackgroundColor, secondaryBackgroundColor: secondaryBackgroundColor, tertiaryBackgroundColor: tertiaryBackgroundColor, quaternaryBackgroundColor: quaternaryBackgroundColor, initialsColor: initialsColor, warningBackgroundColor: warningBackgroundColor, iconsColor: iconsColor, selectedIconsColor: selectedIconsColor, backButtonColor: backButtonColor, xBtnColor: xButtonColor, searchBarStyle: searchBarStyle, highlightedOfferColor: highlightedOfferColor, offersCellShadow: offersCellShadow, offersCellBorder: offersCellBorder, generalArrowsColor: generalArrowsColor, generalDividerColor: generalDividerColor, tabSelectedLineColor: tabSelectedLineColor, tabUnselectedLineColor: tabUnselectedLineColor, generalViewCornerRadius: theme.generalViewCornerRadius, generalDividerHeight: CGFloat(theme.generalDividerHeight?.height ?? 1))
    }
}
