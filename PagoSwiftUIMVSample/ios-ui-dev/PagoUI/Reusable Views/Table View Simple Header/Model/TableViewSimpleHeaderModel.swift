//
//  ProvidersHeaderModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 22/04/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

public struct TableViewSimpleHeaderModel: Model {
    
    public var title: String
    public var style = TableViewSimpleHeaderStyle()
    
    public init(title: String, style: TableViewSimpleHeaderStyle  = TableViewSimpleHeaderStyle()) {
        self.title = title
        self.style = style
    }
}

public struct TableViewSimpleHeaderStyle {
    
    public var backgroundColorType = UIColor.Pago.lightGrayBackground
    public var titleFontType = UIFont.Pago.semiBold13
    public var titleColorType = UIColor.Pago.grayTertiaryText
    public var titleAlignment = NSTextAlignment.center
    
    public init(backgroundColorType: UIColor.Pago = UIColor.Pago.sdkSubtitleColor, titleFontType: UIFont.Pago = UIFont.Pago.regular14, titleColorType: UIColor.Pago = UIColor.Pago.sdkLightGray, titleAlignment: NSTextAlignment = .center) {
        
        self.backgroundColorType = backgroundColorType
        self.titleFontType = titleFontType
        self.titleColorType = titleColorType
        self.titleAlignment = titleAlignment
    }
    
    public init(labelStyle: PagoLabelStyle) {
        
        self.backgroundColorType = labelStyle.backgroundColorType
        self.titleFontType = labelStyle.fontType
        self.titleColorType = labelStyle.textColorType
        self.titleAlignment = labelStyle.alignment
    }
}
