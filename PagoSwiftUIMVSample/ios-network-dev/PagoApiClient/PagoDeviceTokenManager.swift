//
//  DeviceTokenManager.swift
//  Pago
//
//  Created by Mihai Arosoaie on 12/09/16.
//  Copyright © 2016 timesafe. All rights reserved.
//

import Foundation
@_implementationOnly import PagoCoreSDK

public class PagoDeviceTokenManager {
    
    fileprivate let tokenKey = "DO WE NEED THIS?"
//    PagoConfig.shared.device.deviceTokenKey
    
    public static let sharedManager = PagoDeviceTokenManager()
    private let keychainManager = PagoKeychainManager()
    private let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    private let deviceTokenKey : String
    
    private init() {
        deviceTokenKey = "\(tokenKey)_\(appVersion ?? "")"
    }
    
    public var deviceToken: String? {
        get {
            return keychainManager.get(deviceTokenKey) ?? ""
        }
        set(value) {
            if let value = value {
                keychainManager.set(value, forKey: deviceTokenKey)
            }
            PagoLogManager.shared.deviceToken = value
        }
    }
//
//    public var deviceId: String? {
//        get {
//            return keyChain.get(tokenKey)
//        }
//        set(value) {
//            if let value = value {
//                keyChain.set(value, forKey: tokenKey)
//            }
//        }
//    }
    
    public func clearDeviceToken() {
        keychainManager.delete(deviceTokenKey)
    }
    
    public func clear() {
//        keyChain.delete(tokenKey)
//        keyChain.delete(deviceTokenKey)
    }
}
