//
//  String+Extension.swift
//  PagoCoreSDK
//
//  Created by Gabi on 17.08.2022.
//

import Foundation

public extension String {
    
    var toInt32: Int32? {
        return Int32(self)
    }
    
    var toInt64: Int64? {
        return Int64(self)
    }
    
    var toInt: Int? {
        return Int(self)
    }
    
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
        else { return nil }
        return from ..< to
    }
    
    func add(prefix: String?) -> String {
        guard let prefix = prefix else { return self }
        return prefix + self
    }
    
    func replacing(placeholder: String, with string: String) -> String {
        guard let range = self.range(of: placeholder) else {
            return self
        }
        return self.replacingCharacters(in: range, with: string)
    }
    
    // checks if the content of a string is a number
    var isNumber: Bool {
        return self.allSatisfy { character in
            character.isNumber
        }
    }
}
