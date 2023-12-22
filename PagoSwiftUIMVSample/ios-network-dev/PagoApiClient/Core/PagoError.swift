//
//  PagoError.swift
//  PagoApiClient
//
//  Created by Mihai Arosoaie on 10/12/2017.
//  Copyright © 2017 cleversoft. All rights reserved.
//

import Foundation

public enum PagoError: Error, Equatable {
    
    case parseError(message: String, rawText: String?)
    case apiError(message: String, statusCode: Int, rawText: String?)
    case syncError(message: String)
    case authError(message: String)
    case bankError(code: String, message: String)
    case limitReached(message: String)
    case noConnectionError
    case configurationError(message: String)
    case wrongCredentials, apiLimitReached
    
    public static func ==(lhs: PagoError, rhs: PagoError) -> Bool {
        
        switch(lhs, rhs) {
        case (.parseError(_, _), .parseError(_, _)): return true
        case (.apiError(_, _, _), .apiError(_, _, _)): return true
        case (.syncError(_), .syncError(_)): return true
        case (.authError(_), .authError(_)): return true
        case (.bankError(_, _), .bankError(_, _)): return true
        case (.limitReached(_), .limitReached(_)): return true
        case (.configurationError(_), .configurationError(_)): return true
        case (.noConnectionError, .noConnectionError): return true
        case (.wrongCredentials, .wrongCredentials): return true
        case (.apiLimitReached, .apiLimitReached): return true
        default: return false
        }
    }
}

extension PagoError: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        
        switch self {
        case .parseError(let message, let rawText):
            return "ParseError: \(stringFrom((message, rawText)))"
        case .apiError(let message, let statusCode, let rawText):
            return "ApiError \(statusCode): \(stringFrom((message, rawText)))"
        case .syncError(let message):
            return "SyncError: \(message.cleanString))"
        case .authError(let message):
            return "AuthError: \(message.cleanString))"
        case .bankError(let code, let message):
            return "BankError: \(code) \(message)"
        case .configurationError(let message):
            return "ConfigurationError: \(message.cleanString)"
        case .noConnectionError:
            return "NoConnectionError"
        case .wrongCredentials:
            return "WrongCredentials"
        case .limitReached(let message):
            return "LimitReached: \(message)"
        case .apiLimitReached:
            return "ApiLimitReached"
        }
    }
    
    public var message: String {
        
        switch self {
        case .noConnectionError:
            return "NoConnectionError"
        case .wrongCredentials:
            return "WrongCredentials"
        case .parseError(let message, let rawText):
            return (message, rawText).0
        case .apiError(let message, _, _):
            return message
        case .syncError(let message):
            return message
        case .authError(let message):
            return message
        case .bankError(_, let message):
            return message
        case .configurationError(let message):
            return message
        case .limitReached(let message):
            return message
        case .apiLimitReached:
            return "ApiLimitReached"
        }
    }
    
    internal func stringFrom(_ message: (String, String?)?) -> String {
        
        guard let msg = message else {return "nil"}
        let unwrapped = (msg.0, msg.1 ?? "nil")
        let repr = String(describing: unwrapped)
        return repr.cleanString
    }
    
    public var debugDescription: String {
        
        return self.description
    }
    
    public var statusCode: ErrorStatusCode? {
        
        switch self {
        case .apiError(_, let statusCode, _):
            let errorStatusCode = ErrorStatusCode(rawValue: statusCode) ?? .otherError
            if errorStatusCode == .otherError { print("WARNING: Status code: \(errorStatusCode) is not treated!") }
            return errorStatusCode
            
        default:
            return nil
        }
    }
    
    public enum ErrorStatusCode: Int {
        
        //TODO: - add cases if necessary
        case badRequest400 = 400
        case unauthorizedError401 = 401
        case forbidden403 = 403
        case notFound404 = 404
        case rangeNotSatisfiable416 = 416
        case tooManyRequests = 429
        case internalServerError500 = 500
        case notImplemented501 = 501
        case otherError = 0
    }
    
}
