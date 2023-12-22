//
//  Request+Strings.swift
//  Pago
//
//  Created by Mihai Arosoaie on 09/07/2017.
//  Copyright © 2017 cleversoft. All rights reserved.
//

import Foundation


fileprivate let encryptedPlaceholder = "encrypted"

extension PagoRequest {
    
    var string: String {
        let method = request?.httpMethod ?? "GET"
        let url = request?.url?.absoluteString
        var body = ""
        if let data = request?.httpBody,
            let bodyString = String(data: data, encoding: .utf8) {
            body = bodyString
        }
        var authHeaderString = "none"
        if let pair = (request?.allHTTPHeaderFields?.filter {$0.key == "Authorization"})?.first {
            authHeaderString = pair.value
        }

        body = body.safeToLog
        return "\(method) \(String(describing: url)) (http headers not visible)\nAuthorization: \(authHeaderString)\nBody: \(body)"
    }
    
}


extension String {
    
    public var safeToLog: String {
        let regexes = [("password=(.*)$", "(password=).*$", "$1{{\(encryptedPlaceholder)}}"),
                       ("\"password\":\"(.*)\"", "\"password\":\".*\"", "\"password\":\"{{\(encryptedPlaceholder)}}\""),
                       ("grant_type=refresh_token&refresh_token=(.*)$", "(grant_type=refresh_token&refresh_token=).*$", "$1{{\(encryptedPlaceholder)}}"),
                       ("\"refresh_token\":\"([a-zA-Z0-9.-]*)\"", "(\"refresh_token\":\")[a-zA-Z0-9.-]*(\")", "$1{{\(encryptedPlaceholder)}}$2")]
        return encryptPasswords(body: self, regexes: regexes)
    }
    
    func encryptPasswords(body: String, regexes:[(String, String, String)]) -> String {
        for (matchRegex, captureRegex, replacementRegex) in regexes {
            let matchGroups = body.groupMatches(for: matchRegex)
            if matchGroups.count > 0,
                let password = matchGroups.first?[safe: 1] {
                return body.replacingOccurrences(of: captureRegex, with: replacementRegex.replacingOccurrences(of: "{{\(encryptedPlaceholder)}}", with: stars), options: [.regularExpression])
            }
        }
        return body
    }
    
}

private let stars = "*******"
