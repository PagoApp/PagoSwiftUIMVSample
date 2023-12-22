//
//  ApiClient.swift
//  Pago
//
//  Created by Mihai Arosoaie on 26/09/16.
//  Copyright © 2016 timesafe. All rights reserved.
// test

import Foundation
import PagoCoreSDK

public protocol PagoApiClientManagerDelegate: class {
    
    func tokenExpired(completion: @escaping (String) -> ())
    func authErrorLoop()
}

public class PagoApiClientManager {
    
    public weak var delegate: PagoApiClientManagerDelegate?
    
    public static let shared: PagoApiClientManager = {
        return PagoApiClientManager()
    }()
    
    public var session: PagoSession! {
        get {
            return webservice.session
        }
        set {
            self.webservice.session = newValue
        }
    }
    
    public var webservice = PagoWebservice(authorizationKey: "", delegate: nil)
    
    public static func setup(accessToken: String, tokenPrefix: String? = nil, authorizationKey: String, baseUrl: String) {
        
        shared.webservice.baseUrl = baseUrl
        shared.webservice.authorizationKey = authorizationKey
        shared.webservice.delegate = shared
        shared.webservice.tokenPrefix = tokenPrefix
        shared.webservice.session = PagoSession(accessToken: PagoJWT(token: accessToken), refreshToken: PagoJWT(token: ""))
        shared.webservice.buildManager()
    }
    
    public static func setupLocale(lang: PagoLocale, country: PagoCountry) {
        
        shared.webservice.acceptLanguageKey = String.init(format: "%@_%@", lang.rawValue, country.rawValue.uppercased())
    }
    
    public static func setupUserAgent(_ userAgent: String) {
        
        shared.webservice.userAgent = userAgent
    }
    
    public static func setupPlatform(_ platform: String) {
        
        shared.webservice.platform = platform
    }
    
    public static func setupSDKVersion(_ sdkVersion: String) {
        
        shared.webservice.sdkVersion = sdkVersion
    }
    
    public static func setupSDKType(_ sdkType: String) {
        
        shared.webservice.sdkType = sdkType
    }
    
    public static func setupAppId(_ appId: String) {
        
        shared.webservice.appId = appId
    }

    public func buildManager() {
        webservice.buildManager()
    }
    
    public func cancelRequests() {
        webservice.defaultManager.session.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
            dataTasks.forEach {$0.cancel()}
            uploadTasks.forEach {$0.cancel()}
            downloadTasks.forEach {$0.cancel()}  
        }
    }
    
    public func handleSession(_ result: PagoApiClientResult<PagoSession>, completion: (PagoApiClientResult<()>) -> ()) {
        if case let .success(session) = result {
            self.session = session
        }
        switch result {
        case .failure(let error): completion(.failure(error))
        case .success: completion(.success(()))
        }
    }
    
    static let maxRetryCount = 5
    
    public func runIfSessionIsValid<T>(_ block:@escaping (()->()), completionBlock:@escaping (_ response: T?, _ error: Error?)->()) {
        
        guard let _ = session else {
            completionBlock(nil, PagoError.authError(message: "No valid session"))
            return
        }
        
        block()
    }
    
    
    public func runIfSessionIsValid<T>(_ block:@escaping (()->()), completionBlock:@escaping (PagoApiClientResult<T>)->()) {
        
        guard let _ = session else {
            completionBlock(.failure(PagoError.authError(message: "No valid session")))
            return
        }
        
       block()
        
    }
    
    ///will return a valid token in the completion block
    ///or nil if a valid token is not available
    public func getValidToken(completion: @escaping (PagoJWT?) -> ()) {
        let emptyCompletionBlock = { (_: Any?, error: Error?) in if error != nil {completion(nil)}}
        runIfSessionIsValid({ 
            completion(PagoApiClientManager.shared.session?.accessToken)
        }, completionBlock: emptyCompletionBlock)
    }
    
}

extension PagoApiClientManager: PagoWebserviceDelegate {
    
    func tokenExpired(completion: @escaping (String) -> ()) {
        
        delegate?.tokenExpired(completion: completion)
    }
    
    func authErrorLoop() {
        delegate?.authErrorLoop()
    }
    
    func triggerExpiredToken(completion: ()->()) {
        webservice.oAuthHandler.triggerRefreshToken(completion: completion)
    }
}
