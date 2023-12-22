//
//  
//  PagoMenusModel.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 01.11.2023.
//
//
import PagoUISDK
import UIKit

internal struct PagoMenusModel: Model {
            
    internal var containerStack: PagoStackedInfoModel  {
        let stackStyle = PagoStackedInfoStyle(backgroundColor: .clear, distribution: .fill, alignment: .fill, axis: .vertical, spacing: 16)
        return PagoStackedInfoModel(models: [], style: stackStyle)
    }
    
    internal var underlinedMenu: PagoMenuModel {

        let style = PagoMenuStyle(type: .underlined, inactiveLineColorType: .blue, activeLineColorType: .redNegative)
        return PagoMenuModel(buttons: [PagoMenuButtonModel(title: "Title 0"),
                                       PagoMenuButtonModel(title: "Title 1"),
                                       PagoMenuButtonModel(title: "Title 2")],
                             style: style)
    }
    
    internal var backgroundMenu: PagoMenuModel {

        
        let style = PagoMenuStyle(type: .background, inactiveLineColorType: .white, activeLineColorType: .blueHighlight)
        return PagoMenuModel(buttons: [PagoMenuButtonModel(title: "Title 0"),
                                       PagoMenuButtonModel(title: "Title 1"),
                                       PagoMenuButtonModel(title: "Title 2")], 
                             style: style)
    }

}
