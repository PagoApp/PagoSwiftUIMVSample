//
//  Oauth2Handler.swift
//  Pago
//
//  Created by Mihai Arosoaie on 08/01/2018.
//  Copyright © 2018 cleversoft. All rights reserved.
//

import Foundation

protocol PagoOAuth2HandlerDelegate: class {
    
    var session: PagoSession! {get set}
    var baseUrlString: String {get}
    
    func refresh(token: String, completion: @escaping (PagoApiClientResult<PagoSession>) -> ())
    func tokenExpired(completion: @escaping(PagoSession) -> ())
    func authErrorLoop()
}

class PagoOAuth2Handler: PagoRequestAdapter, PagoRequestRetrier {
    
    private let authorizationKey: String
    private let tokenPrefix: String?
    private typealias RefreshCompletion = (PagoSession) -> Void
    
    private let lock = NSLock()
    private let refreshLock = NSLock()
    
    weak var delegate: PagoOAuth2HandlerDelegate?
    
    private var isRefreshing = false
    private var requestsToRetry: [PagoRequestRetryCompletion] = []
    private var counter: Int = 0
    
    // MARK: - Initialization
    
    public init(authorizationKey: String, tokenPrefix: String?, delegate: PagoOAuth2HandlerDelegate) {
        
        self.authorizationKey = authorizationKey
        self.tokenPrefix = tokenPrefix
        self.delegate = delegate
    }
    
    // MARK: - RequestAdapter

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        guard !isRefreshing else {
            return urlRequest
        }
        if let baseUrlString = delegate?.baseUrlString,
            let urlString = urlRequest.url?.absoluteString,
            (urlString.hasPrefix(baseUrlString) || urlString.hasPrefix("https://188.226.137.70:9999")),
            let session = delegate?.session {
            var urlRequest = urlRequest
            let token = session.accessToken.rawValue.add(prefix: self.tokenPrefix)
            urlRequest.setValue(token, forHTTPHeaderField: authorizationKey)
            return urlRequest
        }
        
        return urlRequest
    }
    
    // MARK: - RequestRetrier
    
    func should(_ manager: PagoSessionManager, retry request: PagoRequest, with error: Error, completion: @escaping PagoRequestRetryCompletion) {
        lock.lock() ; defer { lock.unlock() }
        guard let session = delegate?.session else {
            return completion(false, 0.0)
        }

        if let response = request.task?.response as? HTTPURLResponse,
            response.statusCode == 401 {
            
            guard counter < 3 else {
                delegate?.authErrorLoop()
                return
            }
            requestsToRetry.append(completion)
            
            if !isRefreshing {
                counter += 1
                var dic : [String: Any] = [:]
                dic["requestURLToRetry"] = response.url?.absoluteString
                dic["status"] = response.statusCode
//                debugPrint(request)
                PagoLogManager.shared.log(dic)
                refreshTokens(session: session) { [weak self] result in
                    guard let strongSelf = self else { return }
                    strongSelf.refreshLock.lock() ; defer { strongSelf.refreshLock.unlock() }
                    var succeeded: Bool
                    strongSelf.delegate?.session = result
                    succeeded = true
                    strongSelf.isRefreshing = false

                    strongSelf.requestsToRetry.forEach { $0(succeeded, 0.0) }
                    strongSelf.requestsToRetry.removeAll()
                }
            }
        } else {
            completion(false, 0.0)
        }
    }
    
    // MARK: - Private - Refresh Tokens
    
    private func refreshTokens(session: PagoSession, completion: @escaping RefreshCompletion) {
        guard !isRefreshing else { return }
        
        isRefreshing = true
        PagoLogManager.shared.log("Refreshing session", sendOnline: false)
        delegate?.tokenExpired { result in
            
            PagoLogManager.shared.log("Refresh sessionn result: \(result.debugDescription)", sendOnline:false)
            completion(result)
            
        }
    }
    
    func triggerRefreshToken(completion: ()->()) {
        delegate?.tokenExpired { [weak self] result in
            self?.delegate?.session = result
        }
    }
    
    func resetErrorCounter() {
        
        counter = 0
    }
}
