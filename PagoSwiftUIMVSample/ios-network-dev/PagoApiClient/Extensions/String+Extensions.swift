//
//  String+Extensions.swift
//  PagoApiClient
//
//  Created by Andrei Chirita on 26.05.2022.
//

import Foundation

extension String {
    
    internal var cleanString: String {
        
        return replacingOccurrences(of: "\\\"", with: "\"").replacingOccurrences(of: "\\/", with: "/")
    }
    
    internal func matches(for regex: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
//            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    internal func groupMatches(for regex: String) -> [[String]] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            return results.map { result in
                let groupMatches = (0..<result.numberOfRanges).map { i -> String in
                    let range = result.range(at: i)
                    let string = nsString.substring(with: range)
                    return string
                }
                return groupMatches
            }
        } catch let error {
//            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
}
