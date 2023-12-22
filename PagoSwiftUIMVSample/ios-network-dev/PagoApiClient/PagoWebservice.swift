//
//  Webservice.swift
//  Pago
//
//  Created by Mihai Arosoaie on 15/07/16.
//  Copyright © 2016 timesafe. All rights reserved.
//

import Foundation
import UIKit
import Security
@_implementationOnly import PagoCoreSDK

public typealias PagoJSONDictionary = [String: Any]

public typealias PagoJSONArray = [AnyObject]

public enum PagoAuthenticationType {
    case none,
        auto, //handled by Oauth2Handler
        basic,
        oauthSession(PagoSession)
}


//Token management
extension PagoWebservice {
    
    public struct Keys {
        static let refreshToken = "refreshToken"
        static let accessToken = "accessToken"
    }
    
    public var session: PagoSession! {
        get {
            return sharedSession
        }
        set {
            self.sharedSession = newValue
        }
    }
    
    public var sharedSession: PagoSession? {
        get {
            if let accessRawToken = PagoKeychainManager(keyPrefix: "jwt").get(Keys.accessToken),
               let refreshRawToken = PagoKeychainManager(keyPrefix: "jwt").get(Keys.refreshToken) {
                
                let aJWT = PagoJWT(token: accessRawToken)
                let rJWT = PagoJWT(token: refreshRawToken)
                
                return PagoSession(accessToken: aJWT, refreshToken: rJWT)
            } else {
                return nil
            }
        }
        
        set {
            guard let session = newValue else {
                return
            }
            let rawAccessToken = session.accessToken.rawValue
            let rawRefreshToken = session.refreshToken.rawValue
            PagoKeychainManager(keyPrefix: "jwt").set(rawAccessToken, forKey: Keys.accessToken)
            PagoKeychainManager(keyPrefix: "jwt").set(rawRefreshToken, forKey: Keys.refreshToken)
        }
    }
    
}

protocol PagoWebserviceDelegate: class {
    func tokenExpired(completion: @escaping (String) -> ())
    func authErrorLoop()
}

public class PagoErrorCodes: NSObject {
    @objc public static let InvalidPin = 403
    @objc public static let ExceededNumberOfRetries = 499
}

extension PagoWebservice {
    
    public var sessionAuthType: PagoAuthenticationType {
//        guard let session = self.session else {
//            return .none
//        }
        return .auto
    }
    
    struct Constants {
        static let authPort = 8181
        static let apiPort = 9999
        static let romcardHost = "https://www.activare3dsecure.ro/teste3d/cgi-bin"
        static let bAuthUser = "pago-mobile-app"
        static let bAuthPassword = "pago-mobile-app-secret"
        static let authPath = PagoSharedConstants.authPath
        static let accessTokenKey = "access_token"
        static let refreshTokenKey = "refresh_token"
        static let usernameKey = "username"
        static let passwordKey = "password"
        static let versionPlaceholder = "{{vesion}}"
    }
}

open class PagoWebservice {
    
    let version: String = {
        return "v\(PagoWebservice.appVersion ?? "unknown")_ios"
    }()
    
    var authorizationKey: String
    var baseUrl: String?
    var tokenPrefix: String?
    var acceptLanguageKey: String?
    var userAgent: String?
    var platform: String?
    var sdkVersion: String?
    var sdkType: String?
    var appId: String?
    
    static var appVersion: String? {
        guard let info = Bundle.main.infoDictionary else {return nil}
        let appVersion = info["CFBundleShortVersionString"] as? String
        return appVersion
    }
    
    static let encoding: String.Encoding = .utf8
    var delegate: PagoWebserviceDelegate?
    var encoding: String.Encoding {
        return PagoWebservice.encoding
    }
    
    lazy var oAuthHandler: PagoOAuth2Handler = {
        return PagoOAuth2Handler(authorizationKey: authorizationKey, tokenPrefix: tokenPrefix, delegate: self)
    }()
    
    lazy var defaultManager: PagoSessionManager = {
        let manager = getManager()
        manager.retrier = self.oAuthHandler
        manager.adapter = self.oAuthHandler

        return manager
    }()
    
    lazy var manualAuthorizationManager: PagoSessionManager = getManager()
    
    public func buildManager() {
        let manager = getManager()
        manager.retrier = self.oAuthHandler
        manager.adapter = self.oAuthHandler
        self.defaultManager = manager
    }
    
    func getManager() -> PagoSessionManager {
        let policy = PagoServerTrustPolicy.customEvaluation({ (trust, host) -> Bool in
            return true
        })
        let configuration = URLSessionConfiguration.default
        var headers = PagoSessionManager.defaultHTTPHeaders
        headers["Accept-Charset"] = "UTF-8"
        var languages = headers["Accept-Language"] ?? ""
        if !languages.contains("ro") {
            languages = "ro;q=1.0, \(languages)"
        }
//        if PagoCountryManager.shared.courierCountryCode != .ro {
//            headers["Country"] = PagoCountryManager.shared.courierCountryCode?.code.uppercased() ?? ""
//        }
        if let acceptLanguageKey = acceptLanguageKey {
            headers["Accept-Language"] = acceptLanguageKey
        }
        if let userAgent = userAgent {
            headers["User-Agent"] = userAgent
        }
        if let platform = platform {
            headers["Platform"] = platform
        }
        if let sdkVersion = sdkVersion {
            headers["SDK-Version"] = sdkVersion
        }
        if let sdkType = sdkType {
            headers["SDK-Type"] = sdkType
        }
        if let appId = appId {
            headers["Appid"] = appId
        }
        
        configuration.httpAdditionalHeaders = headers
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        configuration.timeoutIntervalForRequest = 90
        
        let manager = PagoSessionManager(
            configuration: configuration,
            serverTrustPolicyManager: PagoServerTrustPolicyManager(policies: [
                "pago.cloud": policy
            ])
        )
       
        return manager
    }
    
    
    let apiPath = "https://127.0.0.1:5000/"
    
    let wsVersion = "_v1_1"
    var sessionId = UUID().uuidString
    
    init(authorizationKey: String, delegate: PagoWebserviceDelegate?) {
        self.authorizationKey = authorizationKey
        self.delegate = delegate
    }
    
    static func getAuthHeader() -> (String, String) {
        let plainString = "\(Constants.bAuthUser):\(Constants.bAuthPassword)" as NSString
        let plainData = plainString.data(using: String.Encoding.utf8.rawValue)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return ("Authorization", "Basic " + base64String!)
    }
    
    public var logRequests: Bool = true
    
    public func isRequestStaticData(_ request: PagoRequest) -> Bool {
        if let pathComponents = request.request?.url?.pathComponents {
            return pathComponents.contains("static")
        }
        return false
    }
    
    func logRequest(_ request: PagoRequest, _ response: PagoDefaultDataResponse? = nil) {
        if logRequests {
            var isStaticData = isRequestStaticData(request)
            if let response = response, let request = response.request, let reqURL = request.url {
                let duration = response.timeline.requestDuration
                let responseString = (response.data.flatMap {String(data: $0, encoding: self.encoding)} ?? "nil").replacingOccurrences(of: "\"", with: "'")
                let requestBody = request.httpBody
                var requestHeader = request.allHTTPHeaderFields
                requestHeader?.removeValue(forKey: "Authorization")
                var json : [String: Any]?
//                var mJsonObj : [String: Any]?
//                var mJsonArr : [Any]?
//                if let mData = response.data {
//                    let mJson = try? JSONSerialization.jsonObject(with: mData, options: [])
//                    if let resp =  mJson as? [Any] {
//                        mJsonArr = resp
//                    } else if let resp = mJson as? [String: Any] {
//                        mJsonObj = resp
//                    }
//                }
                if let requestBody = requestBody {
                    do {
                        json = try JSONSerialization.jsonObject(with: requestBody, options: []) as? [String: Any]
                    } catch {
                        
                    }
                    json?.removeValue(forKey: "pdfs")
                    json?.removeValue(forKey: "refresh_token")
                }
                if let error = response.error {
                    var log : [String: Any] =
                    [
                        "Completed_Request": "Fail",
                        "URL": "\(String(describing: reqURL))",
                        "Error": error.localizedDescription,
                        "Data_Length": response.data?.bytes.count ?? 0,
                        "Response_Time": "\(duration)"
                    ]
//                    if mJsonObj != nil {
//                        log["Response"] = mJsonObj
//                    } else if mJsonArr != nil {
//                        log["Response"] = mJsonArr
//                    } else {
//                        log["Response"] = responseString
//                    }
                    log["ResponseVal"] = responseString
                    if let body = request.httpBody {
                        log["Request_Body"] = json != nil ? json! : String(data: body, encoding: String.Encoding.utf8) as Any
                    }
                    log["Request_Header"] = requestHeader
                    PagoLogManager.shared.log(log)
                } else {
                    let rResponse = response.response
                    var log : [String: Any] = [
                        "Completed_Request": "\(rResponse?.statusCode ?? -1) \(request.httpMethod ?? "")",
                        "URL": "\(reqURL)",
                        "Data_Length": response.data?.bytes.count ?? 0,
                        "Response_Time":   "\(duration)"]
//                    if mJsonObj != nil && !shouldFilterResponse(url: reqURL.absoluteString) {
//                        log["Response"] = mJsonObj
//                    } else if mJsonArr != nil && !shouldFilterResponse(url: reqURL.absoluteString) {
//                        log["Response"] = mJsonArr
//                    } else if shouldFilterResponse(url: reqURL.absoluteString) {
//                        log["Response"] = filterResponses(url: reqURL.absoluteString)
//                    } else {
//                        log["Response"] = responseString
//                    }
                    if shouldFilterResponse(url: reqURL.absoluteString) {
                        log["ResponseVal"] = filterResponses(url: reqURL.absoluteString)
                    } else if !isStaticData{
                        log["ResponseVal"] = responseString
                    }
                    if let body = request.httpBody {
                        if shouldFilterRequestBody(url: reqURL.absoluteString) {
                            log["Request_Body"] = filetrRequestBody(url: reqURL.absoluteString, requestBody: String(data: body, encoding: .utf8) ?? "")
                        } else {
                            log["Request_Body"] = json != nil ? json! : String(data: body, encoding: String.Encoding.utf8) as Any
                        }
                    }
                    log["Request_Header"] = requestHeader
                    PagoLogManager.shared.log(log)
                }
            }
        }

    }
    
    public func shouldFilterRequestBody(url: String) -> Bool {
        return url.contains("oauth/token")
    }
    
    public func filetrRequestBody(url: String, requestBody : String) -> String {
        if url.contains("oauth/token") {
            let components = requestBody.split(separator: "&")
            var result = ""
            for component in components {
                if component.contains("password") {
                    result.append("password=****")
                } else {
                    result.append(String(component))
                }
            }
            return result
        } else {
            return requestBody
        }
    }
    
    public func shouldFilterResponse(url: String) -> Bool {
        return url.contains("oauth/token") ||
            url.contains("configuration/providers/") ||
            url.contains("settings/provider/types") ||
            url.contains("payment/transactions") ||
            url.contains("provider/pdfbytes") ||
            url.contains("pago-insurance/cities") ||
            url.contains("pago-insurance/counties") ||
            url.contains("pago-insurance/brands") ||
            url.contains("configuration/check_compatibility/") ||
            url.contains("https://www.secure11gw.ro/portal/cgi-bin/") ||
            url.contains("provider/fetch") ||
            url.contains("payment/payment-details-v2") ||
            url.contains("pago-points/rewards") ||
            url.hasSuffix("pago-donation/ngos") ||
            url.hasSuffix("pago-insurance/pad/all-data")
    }
    
    public func filterResponses(url : String) -> String {
        if url.contains("oauth/token") {
            return "login"
        } else if url.contains("/configuration/providers/") {
            return "download providers"
        } else if url.contains("pago-insurance/cities") {
            return "download cities"
        } else if url.contains("payment/transactions") {
            return "download payment history"
        } else if url.contains("pago-insurance/counties") {
            return "download counties"
        } else if url.contains("pago-insurance/brands") {
            return "download car brands"
        } else if url.contains("/configuration/check_compatibility/") {
            return "compatibility check"
        } else if url.contains("https://www.secure11gw.ro/portal/cgi-bin/") {
            return "romcard webview"
        } else if url.contains("settings/provider/types") {
            return "provider_types"
        } else if url.contains("provider/pdfbytes") {
            return "download pdf"
        } else if url.hasSuffix("pago-donation/ngos") {
            return "download ongs"
        } else if url.contains("provider/fetch") {
            return "download accounts"
        } else if url.contains("payment/payment-details-v2") {
            return "download history"
        } else if url.contains("pago-points/rewards") {
            return "download rewards"
        } else if url.contains("pago-insurance/pad/all-data") {
            return "download pad config"
        } else {
            return ""
        }
    }
    
    func handleError<T>(resource: PagoResource<T>, statusCode: Int, response: PagoDefaultDataResponse, completion: @escaping (PagoApiClientResult<T>, Int) -> ()) {
        self.handleError(resource: resource, statusCode: statusCode, response: response) { result in
            completion(result, statusCode)
        }
    }
    
    func handleError<T>(resource: PagoResource<T>, statusCode: Int, response: PagoDefaultDataResponse, completion: @escaping (PagoApiClientResult<T>) -> ()) {
        if statusCode == 401 {
            PagoLogManager.shared.log("Refresh token expired;", sendOnline: false)
            NotificationCenter.`default`.post(name: Notification.Name.init(PagoSharedConstants.LogoutNotificationKey), object: nil)
            let error = response.error ?? PagoError.apiError(message: "Token expired", statusCode: statusCode, rawText: nil)
            return completion(.failure(error))
//            refreshSesion(session: session, resource: resource, completion: completion)
        }

        if statusCode == 500 {
            if let data = response.data {
                if let stringResponse = data.utf8String {
                    if (resource.path.contains("payment/pay") || resource.path.contains("payment/authorization")) &&
                        resource.params?["type"] as? String == "prepay" &&
                        stringResponse.contains("Limit reached:") {
                        let error = PagoError.limitReached(message: stringResponse)
                        PagoLogManager.shared.log(error)
                        return completion(.failure(error))
                    }
                }
            }
        }
        
        if let data = response.data,
            let json = self.JSONObjectFromData(data) {
            if  let domain = json["domain"] as? String, domain == "pago",
                let codeString = json["code"] as? String,
                let code = Int(codeString),
                let message = json["message"] {
                var userInfo = ["message": message]
                if let remainingAttemptsString = json[PagoSharedConstants.remainingAttempts] as? String,
                    let remainingAttempts = Int(remainingAttemptsString) {
                    userInfo[PagoSharedConstants.remainingAttempts] = remainingAttempts
                }
                let error = NSError(domain: "pago", code: code, userInfo: userInfo)
                return completion(.failure(error))
            } else if let domain = json["type"] as? String, domain == "bank",
                let code = json["errorCode"] as? String {
                let message = (json["message"] as? String) ?? ""
                let error = PagoError.bankError(code: code, message: message)
                return completion(.failure(error))
            } else if let code = json["errorCode"] as? String {
                if PagoBankErrorHelper.errorIds[code] != nil {
                    let message = (json["message"] as? String) ?? ""
                    let error = PagoError.bankError(code: code, message: message)
                    return completion(.failure(error))
                }
            }
            
        }
        
        let rawText = response.data.flatMap {String(data: $0, encoding: self.encoding)} ?? ""
        var error: Error
        if rawText == "{\"cause\":\"LoginException\"}"
            || rawText.contains("Required request body is missing") && resource.path.contains("enrolment")
            || rawText.contains("Ghiseu API error")
            || rawText.contains("The user is restricted to the data from ghiseul.ro")
            || rawText.matches(for: "LoginException.* login error").count > 0
            || rawText.matches(for: "LoginException.* Login error").count > 0
            || rawText.matches(for: "LoginException.* Eroare de autentificare").count > 0
            || rawText.matches(for: "LoginException.* Bad credentials").count > 0 {
            error = PagoError.wrongCredentials
        } else if statusCode == 400, resource.path.contains("uaa/oauth"), resource.method == .post, rawText.contains("Too many requests") {
            error = PagoError.apiLimitReached
        } else {
            error = PagoError.apiError(message: rawText, statusCode: statusCode, rawText: rawText)
        }
        
        if statusCode == 429 && (resource.method == .post && resource.path.contains("pos-user/forgot") || resource.method == .post && resource.path.contains("pos-user/magic-link") || resource.method == .post && resource.path.contains("pos-user/settings/password") || resource.method == .delete && resource.path.contains("pos-user/pin")) {
            error = PagoError.apiLimitReached
        }

        completion(.failure(error))
    }

    public func load<T>(_ resource: PagoResource<T>, completion: @escaping (PagoApiClientResult<T>) -> ()) {
        let request = self.request(resource)
        let queue = DispatchQueue(label: "com.pago.response-queue", qos: .background, attributes: [.concurrent])
        self.logRequest(request)
        request.validate().response(queue: queue) { [unowned self] (response) in
            self.logRequest(request, response)
            if let error = response.error {
                switch error {
                case PagoAFError.responseValidationFailed(reason: PagoAFError.ResponseValidationFailureReason.unacceptableStatusCode(code: let statusCode)):
                    self.handleError(resource: resource, statusCode: statusCode, response: response, completion: completion)
                default:
                    completion(.failure(error))
                }
            } else if let statusCode = response.response?.statusCode, statusCode >= 300 {
                return self.handleError(resource: resource, statusCode: statusCode, response: response, completion: completion)
            } else if let data = response.data {
                oAuthHandler.resetErrorCounter()
                let parseResult = resource.parse(data)
                completion(parseResult)
            }
        }
    }
    
    public func load<T>(_ resource: PagoResource<T>, completion: @escaping (PagoApiClientResult<T>, Int) -> ()) {
        let request = self.request(resource)
        let queue = DispatchQueue(label: "com.pago.response-queue", qos: .background, attributes: [.concurrent])
        self.logRequest(request)
        request.validate().response(queue: queue) { [unowned self] (response) in
            self.logRequest(request, response)
            if let error = response.error {
                switch error {
                case PagoAFError.responseValidationFailed(reason: PagoAFError.ResponseValidationFailureReason.unacceptableStatusCode(code: let statusCode)):
                    self.handleError(resource: resource, statusCode: statusCode, response: response, completion: completion)
                default:
                    completion(.failure(error), response.response?.statusCode ?? 0)
                }
            } else if let statusCode = response.response?.statusCode, statusCode >= 300 {
                return self.handleError(resource: resource, statusCode: statusCode, response: response, completion: completion)
            } else if let data = response.data {
                oAuthHandler.resetErrorCounter()
                let parseResult = resource.parse(data)
                completion(parseResult, response.response?.statusCode ?? 0)
            }
        }
    }
    
    static func JSONArrayFromData(_ data:Data?) -> [Any]? {
        guard let data = data else { return nil }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [Any]
            return json
        } catch let error {
            PagoLogManager.shared.log(error, sendOnline: false)
            return nil
        }
    }
    
    public static func JSONObjectFromData(_ data: Data?) -> [String: Any]? {
        guard let data = data else { return nil }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
            return json
        } catch let error {
            PagoLogManager.shared.log(error, sendOnline: false)
            return nil
        }
    }
    
    func JSONArrayFromData(_ data:Data?) -> [Any]? {
        return PagoWebservice.JSONArrayFromData(data)
    }

    func JSONObjectFromData(_ data:Data?) -> [String: Any]? {
        return PagoWebservice.JSONObjectFromData(data)
    }
    
    static var authHost: String {
        return PagoHost.auth.value
    }
    
    static var apiHost: String {
        return PagoHost.api.value
    }
    
    static var romcardHost: String {
        return PagoHost.romcard.value
    }
    
    static func printRequest(_ request:URLRequest?) {
        guard let request = request else { print("Request was nil"); return }
//        print("URL: \(request.url?.absoluteString ?? "")")
        if let headers = request.allHTTPHeaderFields {
            let formattedHeaders = headers.map({"\($0): \($1)"})
//            print("Headers: ")
//            print(formattedHeaders.joined(separator: "\n"))
        }
        
        if let data = request.httpBody, let string = String(data: data, encoding: self.encoding) {
//            print("\nBody: \(string)")
        }

    }
    
    public func uploadRequest<A>(_ resource: PagoResource<A>, image: UIImage, completion: @escaping(PagoApiClientResult<A>)->()) {
        var url = "\(resource.host.value)"
        if resource.path.count > 0 {
            url = url.appending("/\(resource.path)")
        }
        let params = resource.params
        url = url.replacingOccurrences(of: Constants.versionPlaceholder, with: self.wsVersion)
        let manager: PagoSessionManager = { Void -> PagoSessionManager in
            switch resource.authType {
            case .auto:
                return defaultManager
            case .none, .oauthSession, .basic:
                return manualAuthorizationManager
            }
        }(())
        
        let headers = { Void -> [String: String]? in
            switch resource.authType {
            case .basic:
                let header = PagoWebservice.getAuthHeader()
                return [header.0: header.1]
            case .oauthSession(let session):
                let token = session.accessToken.rawValue.add(prefix: self.tokenPrefix)
                return ["Authorization": "\(token)"]
            case .auto, .none:
                return nil
            }
        }(())
        manager.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(image.jpegData(compressionQuality: 0.5)!, withName: "image", fileName: "invoice.jpg", mimeType: "image/jpeg")
            if let params = params {
            for (key, value) in params {
                  multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            }
        }, to: url, headers: headers) { result in
            switch result {
            case .success(let upload, _, _):
            upload.uploadProgress(closure: { (Progress) in
//                print("Upload Progress: \(Progress.fractionCompleted)")
            })
            upload.responseJSON(completionHandler: {response in
                if upload.response?.statusCode ?? 0 < 200 || upload.response?.statusCode ?? 0 >= 400 {
                    completion(.failure(NSError()))
                } else {
                    if let data = response.data {
                        let parseResult = resource.parse(data)
                        completion(parseResult)
                    } else {
                        completion(.failure(NSError()))
                    }
                }
//                PagoLogManager.shared.log(["url" : url, "requestBody" : "upload image", "response" : upload.response?.statusCode ?? 0])
            })
            case .failure:
                completion(.failure(NSError()))
            }
            
        }
    }
    
    func request<A>(_ resource: PagoResource<A>) -> PagoDataRequest {
        var url = "\(resource.host.value)"
        if resource.path.count > 0 {
            url = url.appending("/\(resource.path)")
        }
        let params = resource.params
        url = url.replacingOccurrences(of: Constants.versionPlaceholder, with: self.wsVersion)
        let manager: PagoSessionManager = { Void -> PagoSessionManager in
            switch resource.authType {
            case .auto:
                return defaultManager
            case .none, .oauthSession, .basic:
                return manualAuthorizationManager
            }
        }(())
        
        var headers = { Void -> [String: String]? in
            switch resource.authType {
            case .basic:
                let header = PagoWebservice.getAuthHeader()
                return [header.0: header.1]
            case .oauthSession(let session):
                let token = session.accessToken.rawValue.add(prefix: self.tokenPrefix)
                return ["Authorization": "\(token)"]
            case .auto, .none:
                return [:]
            }
        }(())
//        if PagoCountryManager.shared.courierCountryCode != .ro {
//            headers?["Country"] = PagoCountryManager.shared.courierCountryCode?.code.uppercased() ?? ""
//        }
    
        if let acceptLanguageKey = acceptLanguageKey {
            headers?["Accept-Language"] = acceptLanguageKey
        }

        let request = manager.request(url, method: resource.method, parameters: params, encoding: resource.encoding, headers: headers)
        return request
    }
    
    public func getError(_ data: Data, path: String = "") -> PagoError {
        if let dict = PagoApiClientManager.shared.webservice.JSONObjectFromData(data),
            let error = dict["error"] {
            let errorDescription = dict["error_description"] as? String ?? dict["message"] as? String ?? ""
            return PagoError.parseError(message: "\(error): \(errorDescription)", rawText: String(data: data, encoding: self.encoding))
        } else {
            return PagoError.parseError(message: "Could not parse response", rawText: String(data: data, encoding: String.Encoding.utf8))
            
        }
    }
}

extension PagoWebservice: PagoOAuth2HandlerDelegate {
    
    public func authErrorLoop() {
        
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.authErrorLoop()
        }
    }
    

    var sessionManager: PagoSessionManager {
        return defaultManager
    }
    
    var baseUrlString: String {
//        return PagoApiSwitcher.mode.baseHost
        return baseUrl ?? ""
    }
    
    func refresh(token: String, completion: @escaping (PagoApiClientResult<PagoSession>) -> ()) {
//        let resource = self.refreshToken(token)
//        load(resource, completion: completion)
    }
    
    func tokenExpired(completion: @escaping (PagoSession) -> ()) {
        
        delegate?.tokenExpired() { token in
            
            completion(PagoSession(accessToken: PagoJWT(token: token), refreshToken: PagoJWT(token: "")))
        }
    }
}


extension PagoRequest {
    
    fileprivate struct AssociatedKeys {
        static var IdKey = "RequestId"
    }
    
    var idString: String {
        get {
            if let id = objc_getAssociatedObject(self, &AssociatedKeys.IdKey) as? String {
                return id
            } else {
                let id = UUID().uuidString
                self.idString = id
                return id
            }
        }
        set (view) {
            objc_setAssociatedObject(self, &AssociatedKeys.IdKey, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
