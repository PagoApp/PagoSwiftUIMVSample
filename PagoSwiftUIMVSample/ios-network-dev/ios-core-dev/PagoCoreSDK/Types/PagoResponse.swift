//
//  BasePagoResponse.swift
//  PagoApiClient
//
//  Created by Gabi on 15.07.2022.
//

import Foundation
@_implementationOnly import PagoCoreSDK

public struct PagoResponse<T: Codable>: Codable {

    private enum CodingKeys: String, CodingKey {
        case error
        case errorCode
        case errorMsg
        case errorScreen
        case data
    }

    public var error: Bool
    public var errorCode: Int?
    public var errorMsg: String?
    public var errorScreen: PagoErrorResponse?
    public var data: T?
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let rawError = try? values.decode(Bool.self, forKey: .error)
        let rawErrorCode = try? values.decode(Int.self, forKey: .errorCode)
        let rawErrorMsg = try? values.decode(String.self, forKey: .errorMsg)
        let rawErrorScreen = try? values.decode(PagoErrorResponse.self, forKey: .errorScreen)
        let rawData = try? values.decode(T.self, forKey: .data)

        guard let data = rawData,
              let error = rawError
        else {
            //TODO: Build custom log message
            throw PagoDataError.missingData(values: [CodingKeys.data])
        }
        
        self.error = error
        self.errorCode = rawErrorCode
        self.errorMsg = rawErrorMsg
        self.errorScreen = rawErrorScreen
        self.data = data
    }
    
    public init(error: Bool, errorCode: Int? = nil, errorMsg: String? = nil, errorScreen: PagoErrorResponse? = nil, data: T?) {
        
        self.error = error
        self.errorCode = errorCode
        self.errorMsg = errorMsg
        self.errorScreen = errorScreen
        self.data = data
    }
}
