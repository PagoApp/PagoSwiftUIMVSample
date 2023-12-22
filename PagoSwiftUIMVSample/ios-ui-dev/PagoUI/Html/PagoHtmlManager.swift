//
//  PagoHtmlManager.swift
//  PagoUISDK
//
//  Created by Cosmin Iulian on 27.09.2023.
//

import UIKit

public class PagoHtmlManager {
    
    private let string: String
    private let tagType: PagoHtmlTagType
    private let fontType: UIFont.Pago
    
    internal lazy var extractedTexts: [String] = {
        sliceMultipleTimes(from: tagType.startTag,
                           to: tagType.endTag)
    }()
    public lazy var placeholders: [PagoPlaceholderModel] = {
        getPlaceholders()
    }()
    public lazy var stringWithoutTags: String = {
        removeHtmlTags(startTag: tagType.startTag,
                       endTag: tagType.endTag)
    }()
    
    public init(string: String, type: PagoHtmlTagType, fontType: UIFont.Pago) {
        
        self.string = string
        self.tagType = type
        self.fontType = fontType
    }
    
    private func sliceMultipleTimes(from: String, to: String) -> [String] {
        
        string.components(separatedBy: from).dropFirst().compactMap { sub in
            (sub.range(of: to)?.lowerBound).flatMap { endRange in
                String(sub[sub.startIndex ..< endRange])
            }
        }
    }
    
    private func getPlaceholders() -> [PagoPlaceholderModel] {
        
        var placeholders: [PagoPlaceholderModel] = []
        let placeholderStyle = PagoPlaceholderStyle(fontType: fontType)
        extractedTexts.forEach {
            placeholders.append(PagoPlaceholderModel(text: $0, style: placeholderStyle))
        }
        return placeholders
    }
    
    private func removeHtmlTags(startTag: String, endTag: String) -> String {
        
        let withoutStartTag = string.replacingOccurrences(of: startTag, with: "")
        let withoutTags = withoutStartTag.replacingOccurrences(of: endTag, with: "")
        return withoutTags
    }
    
}
