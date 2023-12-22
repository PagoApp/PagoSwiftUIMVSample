//
//  
//  EmptyScreenModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 23/04/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation

public struct EmptyScreenModel: Model {
    public var title: String
    public var detail: String
    public var placeholder: String
    public var imageType: UIImage.Pago
    public var style = EmptyScreenStyle()
    
    public init(title: String, detail: String, placeholder: String, imageType: UIImage.Pago, style: EmptyScreenStyle = EmptyScreenStyle()) {
        
        self.title = title
        self.detail = detail
        self.placeholder = placeholder
        self.imageType = imageType
        self.style = style
    }
}

public struct EmptyScreenStyle {
    public let titleFontType = UIFont.Pago.bold24
    public let titleColorType = UIColor.Pago.blackBodyText
    public let detailFontType = UIFont.Pago.regular17
    public let placeholderColorType = UIColor.Pago.blueHighlight
    public let detailColorType = UIColor.Pago.grayTertiaryText
    public let backgroundColorType = UIColor.Pago.lightGrayBackground
    public var contentInsets = UIEdgeInsets.zero
    public var space: CGFloat?
    
    public init(contentInsets: UIEdgeInsets = .zero, space: CGFloat? = nil) {
        
        self.contentInsets = contentInsets
        self.space = space
    }
}
