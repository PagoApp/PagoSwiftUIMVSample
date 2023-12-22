//
//  String+Extension.swift
//  Pago
//
//  Created by Gabi Chiosa on 23.02.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    public func toDate(formatter pagoFormatterType: Date.PagoDateFormat) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = pagoFormatterType.string
        formatter.timeZone = TimeZone.pagoUTC
        let date = formatter.date(from: self)
        return date
        
    }
    
    func toAttributed(font fontType: UIFont.Pago, color colorType: UIColor.Pago, underlined: Bool = false, striked: Bool = false, strikeColor: UIColor.Pago = UIColor.Pago.blackBodyText, paragraphStyle: PagoParagraphStyle? = nil) -> NSAttributedString {
           
        var defaultDetailAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: colorType.color, .font: fontType.font]
        
        if underlined {
            defaultDetailAttributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        
        if striked {
            defaultDetailAttributes[.strikethroughStyle] = 2
            defaultDetailAttributes[.strikethroughColor] = strikeColor.color
        }
        
        if let pStyle = paragraphStyle {
            let style = NSMutableParagraphStyle()
            style.alignment = pStyle.alignment
            style.lineBreakMode = pStyle.lineBreakMode
            if pStyle.zeroLineSpace {
                let lineHeight = fontType.font.pointSize - fontType.font.ascender + fontType.font.capHeight
                let offset = fontType.font.capHeight - fontType.font.ascender
                style.maximumLineHeight = lineHeight
                style.minimumLineHeight = lineHeight
                defaultDetailAttributes[.baselineOffset] = offset
            }
            defaultDetailAttributes[.paragraphStyle] = style
        }
        
        let attributed = NSAttributedString(string: self, attributes: defaultDetailAttributes)
        return attributed
    }
    
    public struct AttributedStringReplacement {
        let key: String
        let image: UIImage
        let xOffset: CGFloat?
        let yOffset: CGFloat
        let width: CGFloat?
        let height: CGFloat
        
        public init(key: String, image: UIImage, xOffset: CGFloat? = nil, yOffset: CGFloat, width: CGFloat? = nil, height: CGFloat) {
            self.key = key
            self.image = image
            self.yOffset = yOffset
            self.height = height
            self.width = width
            self.xOffset = xOffset
        }
    }
    
    public func attributedString(replacements: [AttributedStringReplacement]) -> NSAttributedString {
    
        var mutableReplacements = replacements
        guard let last = mutableReplacements.popLast() else { return NSAttributedString() }
        let key = last.key
        let image = last.image
        let components = self.components(separatedBy: key)
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        imageAttachment.updateBounds(height: last.height, width: last.width, xOffset: last.xOffset, yOffset: last.yOffset)
        let imageString = NSAttributedString(attachment: imageAttachment)
        let fullString = NSMutableAttributedString()
        for (i, component) in components.enumerated() {
            if mutableReplacements.isEmpty {
                let attrString = NSAttributedString(string: component)
                fullString.append(attrString)
            } else {
                let attrString = component.attributedString(replacements: mutableReplacements)
                fullString.append(attrString)
            }
            
            if i < components.count - 1 {
                fullString.append(imageString)
            }
        }
        return fullString
    }
    
    public func attributedString(first: AttributedStringReplacement, second: AttributedStringReplacement) -> NSAttributedString {
    
        let key = first.key
        let secondKey = second.key
        let secondImage = second.image
        let image = first.image
        
        let components = self.components(separatedBy: key)
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        imageAttachment.updateBounds(height: first.height, width: first.width, xOffset: first.xOffset, yOffset: first.yOffset)
        let imageString = NSAttributedString(attachment: imageAttachment)
        let fullString = NSMutableAttributedString()
        for (i, component) in components.enumerated() {
            let attrString = component.attributedString(key: secondKey, image: secondImage, imageHeight: second.height, imageWidth: second.width, xOffset: second.xOffset, yOffset: second.yOffset)
            fullString.append(attrString)
            if i < components.count - 1 {
                fullString.append(imageString)
            }
        }
        return fullString
    }
    
    public func attributedString(key: String, image: UIImage, imageHeight: CGFloat = 20, imageWidth: CGFloat? = nil, xOffset: CGFloat? = nil, yOffset: CGFloat = -4) -> NSAttributedString {
        let components = self.components(separatedBy: key)
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        imageAttachment.updateBounds(height: imageHeight, width: imageWidth, xOffset: xOffset, yOffset: yOffset)
        let imageString = NSAttributedString(attachment: imageAttachment)
        let fullString = NSMutableAttributedString()
        for (i, component) in components.enumerated() {
            let attrString = NSAttributedString(string: component)
            fullString.append(attrString)
            if i < components.count - 1 {
                fullString.append(imageString)
            }
        }
        return fullString
    }
    
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
    
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        return label.frame.height
    }
}

extension String {
    
    internal var localized: String {
        return self
    }
    
    public var localizedOpt: String? {
        return self
    }
}

extension NSTextAttachment {
    
    public func updateBounds(height: CGFloat, width: CGFloat? = nil, xOffset: CGFloat? = nil, yOffset: CGFloat? = nil) {
        if let width = width {
            let yPos = yOffset ?? bounds.origin.y
            let xPos = xOffset ?? bounds.origin.x
            bounds = CGRect(x: xPos, y: yPos, width: width, height: height)
        } else {
            setImageHeight(height: height, yOffset: yOffset)
        }
    }
    
    public func setImageHeight(height: CGFloat, yOffset: CGFloat?) {
        guard let image = image else { return }
        let ratio = image.size.width / image.size.height
        let y = yOffset == nil ? bounds.origin.y : yOffset!
        bounds = CGRect(x: bounds.origin.x, y: y, width: ratio * height, height: height)
    }
}
