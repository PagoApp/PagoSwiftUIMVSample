//
//  NSAttributedString+Extension.swift
//  Pago
//
//  Created by Gabi Chiosa on 23.02.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation
import UIKit

internal extension NSAttributedString {
    
    static func toAttributes(font fontType: UIFont.Pago? = nil, color colorType: UIColor.Pago? = nil, underlined: Bool? = false, striked: Bool = false, strikeColor: UIColor.Pago = UIColor.Pago.blackBodyText, paragraphStyle: PagoParagraphStyle? = nil, link: URL? = nil) -> [NSAttributedString.Key: Any] {
        
        var attributes = [NSAttributedString.Key: Any]()
        if let color = colorType?.color {
            attributes[.foregroundColor] = color
        }
        if let font = fontType?.font {
            attributes[.font] = font
            if let pStyle = paragraphStyle {
                let style = NSMutableParagraphStyle()
                style.alignment = pStyle.alignment
                style.lineBreakMode = pStyle.lineBreakMode
                if pStyle.zeroLineSpace {
                    let lineHeight = font.pointSize - font.ascender + font.capHeight
                    let offset = font.capHeight - font.ascender
                    style.maximumLineHeight = lineHeight
                    style.minimumLineHeight = lineHeight
                    attributes[.baselineOffset] = offset
                }
                attributes[.paragraphStyle] = style
            }
        }
        if let underlinedT = underlined, underlinedT == true {
            attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        
        if striked {
            attributes[.strikethroughStyle] = 2
            attributes[.strikethroughColor] = strikeColor.color
        }

        if let link = link {
            attributes[.link] = link
        }

        return attributes
    }

    public static func appendLink(to string: NSAttributedString, label: String, url: URL) -> NSAttributedString {

        let link = NSAttributedString(string: label, attributes: [.link: url])
        let copy = NSMutableAttributedString(attributedString: string)
        copy.append(link)
        return NSAttributedString(attributedString: copy)
    }

    func uppercased() -> NSAttributedString {

        let result = NSMutableAttributedString(attributedString: self)

        result.enumerateAttributes(in: NSRange(location: 0, length: length), options: []) {_, range, _ in
            result.replaceCharacters(in: range, with: (string as NSString).substring(with: range).uppercased())
        }

        return result
    }
}
