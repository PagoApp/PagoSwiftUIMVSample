//
//  
//  PagoMenuButtonModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 07/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

open class PagoMenuRepository: PagoRepository {
    
    internal let buttonStyle = PagoButtonStyle(font: .bold17, textColor: .blackBodyText, backgroundColor: .clear)

    internal func badgePredicate(from count: Int?) -> PagoBadgePredicate? {

        guard let countT = count else { return nil }
        let text = countT > 0 ? "\(countT)" : ""
        let badge = PagoBadgePredicate(text: text, textColor: .white, backgroundColor: .redNegative, position: .topRight)
        return badge
    }
    
    @available(*, deprecated, message: "This will be removed later, when we have custom config for Menu with Json Configurator")
    internal func buttonModel(from menuModel: PagoMenuButtonModel, index: Int) -> PagoButtonModel {
        
        let badge = badgePredicate(from: menuModel.badgeCount)
        let button = PagoButtonModel(title: menuModel.title, isEnabled: true, isSelfSized: false, index: index, style: buttonStyle, badge: badge)
        return button
    }
    
    @available(*, deprecated, message: "This will be removed later, when we have custom config for Menu with Json Configurator")
    internal func buttonModels(from menu: [PagoMenuButtonModel]) -> [PagoButtonModel] {
        
        var models = [PagoButtonModel]()
        for (i, button) in menu.enumerated() {
            let tempButtonModel = buttonModel(from: button, index: i)
            models.append(tempButtonModel)
        }
        return models
    }
    
    internal func getButtonStyle(for type: PagoMenuType, selected: Bool) -> PagoButtonStyle {
        
        //TODO: This will be removed later
        guard type == .background else {
            return buttonStyle
        }
        
        let selectedLabelStyle = PagoThemeStyle.custom.topNavigationBarStyle.selectedFontStyle
        let unselectedLabelStyle = PagoThemeStyle.custom.topNavigationBarStyle.unselectedFontStyle
        let selectedButtonStyle = PagoButtonStyle(font: selectedLabelStyle.fontType, textColor: selectedLabelStyle.textColorType, backgroundColor: .clear)
        let unselectedButtonStyle = PagoButtonStyle(font: unselectedLabelStyle.fontType, textColor: unselectedLabelStyle.textColorType, backgroundColor: .clear)
        if selected {
            return selectedButtonStyle
        } else {
            return unselectedButtonStyle
        }
    }
    
    internal func buttonModel(from menuModel: PagoMenuButtonModel, index: Int, type: PagoMenuType, selected: Bool) -> PagoButtonModel {
        
        let badge = badgePredicate(from: menuModel.badgeCount)
        let buttonStyle = getButtonStyle(for: type, selected: selected)
        let button = PagoButtonModel(title: menuModel.title, isEnabled: true, isSelfSized: false, index: index, style: buttonStyle, badge: badge)
        return button
    }
    
    internal func backgroundColor(for type: PagoMenuType) -> UIColor.Pago {
        guard type == .background else {
            //TODO: This will be removed later
            return .clear
        }
        
        let bgColor = PagoThemeStyle.custom.topNavigationBarStyle.backgroundColor
        return bgColor
    }
    
    internal func indicatorColor(for type: PagoMenuType) -> UIColor.Pago {
        guard type == .background else {
            //TODO: This will be removed later
            return PagoThemeStyle.custom.tabSelectedLineColor
        }
        
        let indicatorColor = PagoThemeStyle.custom.topNavigationBarStyle.indicatorColor
        return indicatorColor
    }
    
    
    internal func buttonModels(from menu: [PagoMenuButtonModel], type: PagoMenuType, selectedIndex: Int) -> [PagoButtonModel] {
        
        guard type == .background else {
            //TODO: This will be removed later
            return buttonModels(from: menu)
        }
   
        var models = [PagoButtonModel]()
        for (i, button) in menu.enumerated() {
            let selected = selectedIndex == i
            let tempButtonModel = buttonModel(from: button, index: i, type: type, selected: selected)
            models.append(tempButtonModel)
        }
        return models
    }
    

}

public struct PagoMenuButtonModel: Model {
    public let title: String
    public var badgeCount: Int?
    
    public init(title: String, badgeCount: Int? = nil) {
        
        self.title = title
        self.badgeCount = badgeCount
    }
}

public struct PagoMenuModel: Model {
    public let buttons: [PagoMenuButtonModel]
    public let style: PagoMenuStyle
    
    public init(buttons: [PagoMenuButtonModel], style: PagoMenuStyle = PagoMenuStyle()) {
        
        self.buttons = buttons
        self.style = style
    }

}

//TODO: Must configure the menu using UI Config JSON. For now we only allow customisation of
// TODO: the type background for some integrators in Bills.
public enum PagoMenuType {
    /// does not have a handle for custom UI Config. Must be added.
    case underlined
    /// Works with UI Config style. See PagoTopBarNavStyle. Will ignore inactiveSelectionColorType && activeSelectionColorType
    case background
}


public struct PagoMenuStyle {
    
    public let backgroundColor: UIColor.Pago
    public let insets: UIEdgeInsets
    public let type: PagoMenuType
    @available(*, deprecated, message: "Use update(PagoMenuType) instead. The underlined option will continue to be without customisable style until we add it")
    public let inactiveSelectionColorType: UIColor.Pago
    @available(*, deprecated, message: "Use update(PagoMenuType) instead. The underlined option will continue to be without customisable style until we add it")
    public let activeSelectionColorType: UIColor.Pago

    public init(type: PagoMenuType = .underlined, inactiveLineColorType: UIColor.Pago = PagoThemeStyle.custom.tabUnselectedLineColor, activeLineColorType: UIColor.Pago = PagoThemeStyle.custom.tabSelectedLineColor, insets: UIEdgeInsets = UIEdgeInsets.zero, backgroundColor: UIColor.Pago = .white) {
        
        self.type = type
        self.inactiveSelectionColorType = inactiveLineColorType
        self.activeSelectionColorType = activeLineColorType
        self.insets = insets
        self.backgroundColor = backgroundColor
    }

}

public struct PagoMenuButtonStyle {
    
    public let fontType: UIFont.Pago
    public let colorType: UIColor.Pago
    
    public init(fontType: UIFont.Pago = .bold17, colorType: UIColor.Pago = .blackBodyText) {
        
        self.fontType = fontType
        self.colorType = colorType
    }
}
