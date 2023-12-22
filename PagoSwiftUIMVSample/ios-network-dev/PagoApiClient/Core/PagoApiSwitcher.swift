//
//  PagoApiSwitcher.swift
//  PagoApiClient
//
//  Created by Mihai Arosoaie on 10/12/2017.
//  Copyright © 2017 cleversoft. All rights reserved.
//

import Foundation

public class PagoApiSwitcher {
    fileprivate struct Constants {
        static let nameKey: String = "name"
        static let urlFormatKey: String = "urlFormat"
        static let hostKey: String = "host"
    }
    public enum Mode {
        case stage, live, preLive, custom(String, PagoUrlFormat)
        
        public var baseHost: String {
            return PagoApiClientManager.shared.webservice.baseUrlString
        }
        
        var auth: String {
            switch self {
            case .preLive:
                return "\(baseHost)\(PagoUrlFormat.test.auth)"
            case .live, .stage:
                return "\(baseHost)\(PagoUrlFormat.live.auth)"
            case .custom(_, let format):
                return "\(baseHost)\(format.auth)"
            }
            
        }
        
        public var api: String {
            switch self {
            case .stage, .preLive:
                return "\(baseHost)\(PagoUrlFormat.test.api)"
            case .live:
                return "\(baseHost)\(PagoUrlFormat.live.api)"
            case .custom(_, let format):
                return "\(baseHost)\(format.api)"
                
            }
        }
        
        init?(dict: [String: String]) {
            guard let name = dict[Constants.nameKey] else {
                return nil
            }
            switch name {
            case Mode.live.name:
                self = .live
            case Mode.stage.name:
                self = .stage
            case Mode.preLive.name:
                self = .preLive
            case Mode.custom("", .live).name:
                guard let urlFormat = (dict[Constants.urlFormatKey]).flatMap(PagoUrlFormat.init(rawValue:)),
                    let host = dict[Constants.hostKey] else {
                        return nil
                }
                self = .custom(host, urlFormat)
            default:
                return nil
            }
        }
        
        var dictValue: [String: String] {
            switch self {
            case .live:
                return [Constants.nameKey: Mode.live.name]
            case .stage:
                return [Constants.nameKey: Mode.stage.name]
            case .preLive:
                return [Constants.nameKey: Mode.preLive.name]
            case .custom(let host, let format):
                return [Constants.nameKey: Mode.custom("", .live).name, Constants.hostKey: host, Constants.urlFormatKey: format.rawValue]
            }
        }
        
        public var name: String {
            switch self {
            case .live:
                return "live"
            case .stage:
                return "test"
            case .preLive:
                return "preLive"
            case .custom:
                return "custom"
            }
        }
    }
    
    static let defaults = UserDefaults.standard
    static let modeKey = "ModeKey"
    public static var mode: Mode = {
        
        guard let modeDict = defaults.dictionary(forKey: modeKey) as? [String: String],
            let mode = Mode(dict: modeDict) else {
                let mode = Mode.live
                let dict = mode.dictValue
                // print needed because of a weird bug when writing to userdefaults causes a deadlock
                print(dict)
                defaults.set(dict, forKey: modeKey)
                return mode
        }
        return mode
        }() {
        didSet {
            defaults.set(mode.dictValue, forKey: modeKey)
        }
    }
    
}
