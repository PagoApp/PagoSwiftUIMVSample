//
//  LogManager.swift
//  PagoApiClient
//
//  Created by Andrei Chirita on 25.05.2022.
//

import Foundation

public class PagoLogManager {
    
    public var deviceToken : String?
    
    public var applicationIndentifier : String = "" {
        didSet {
            PagoSlimLogglyConfig.applicationIdentifier = applicationIndentifier
        }
    }
    
    public var logglyToken: String = "" {
        didSet {
            PagoSlimLogglyConfig.logglyToken = logglyToken
        }
    }
    
    public func setup(name : String = "anonymous") {
        let logglyDestination = PagoSlimLogglyDestination()
        logglyDestination.userid = name
        PagoSlim.addLogDestination(logglyDestination)
    }
    
    public func setUserId(name : String) {
        PagoSlim.setUserId(name)
    }
    
    public static let shared: PagoLogManager = {
        
        let manager = PagoLogManager()
        return manager
    }()
    
    internal func log(_ error: Error, sendOnline: Bool = true, file: String = #file, line: Int = #line) {
        var dict: [String: Any] = dictByAppendingDeviceToken(dict: [:])
        dict["error"] = String(describing: error)
        dict["platform"] = "iOS"
        print(dict as AnyObject)
        if sendOnline && !PagoLogManager.shared.logglyToken.isEmpty {
            PagoSlim.error(dict, filename: file, line: line)
        }
    }
    
    internal func log(_ s: String, sendOnline: Bool = true, file: String = #file, line: Int = #line) {
        var dict: [String: Any] = dictByAppendingDeviceToken(dict: [:])
        dict["value"] = s.cleanString
        dict["platform"] = "iOS"
        print(dict as AnyObject)
        if sendOnline && !PagoLogManager.shared.logglyToken.isEmpty {
            PagoSlim.debug(dict, filename: file, line: line)
        }
    }
    
    internal func log(_ dict: [String: Any], sendOnline: Bool = true, file: String = #file, line: Int = #line) {
        var newDict = dict
        newDict["platform"] = "iOS"
        print(newDict as AnyObject)
        if sendOnline && !PagoLogManager.shared.logglyToken.isEmpty {
            PagoSlim.debug(newDict, filename: file, line: line)
        }
    }
    
    internal func dictByAppendingDeviceToken(dict: [String: Any]) -> [String: Any] {
        if let token = deviceToken {
            var newd = dict
            newd["deviceToken"] = token
            return newd
        } else {
            return dict
        }
    }
}
