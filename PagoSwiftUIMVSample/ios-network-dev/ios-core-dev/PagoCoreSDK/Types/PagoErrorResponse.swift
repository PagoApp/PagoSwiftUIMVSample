//
//  PagoErrorScreen.swift
//  PagoApiClient
//
//  Created by Bogdan Oliniuc on 20.12.2022.
//

import Foundation
@_implementationOnly import PagoCoreSDK

public struct PagoErrorResponse: BasePagoCodable {
    
    private enum CodingKeys: String, CodingKey {
        case title
        case message
        case subtitle
        case logoUrl
        case screenType
    }
    
    public var message: String?
    public var title: String?
    public var subtitle: String?
    public var logoUrl: String?
    public var screenType: String?
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let rawTitle = try? values.decode(String.self, forKey: .title)
        let rawMessage = try? values.decode(String.self, forKey: .message)
        let rawSubtitle = try? values.decode(String.self, forKey: .subtitle)
        let rawLogoUrl = try? values.decode(String.self, forKey: .logoUrl)
        let rawScreenType = try? values.decode(String.self, forKey: .screenType)
        
        self.title = rawTitle
        self.message = rawMessage
        self.subtitle = rawSubtitle
        self.logoUrl = rawLogoUrl
        self.screenType = rawScreenType
    }
    
    public init(title: String? = nil, message: String? = nil, subtitle: String? = nil, logoUrl: String? = nil, screenType: String? = nil) {
        
        self.title = title
        self.message = message
        self.subtitle = subtitle
        self.logoUrl = logoUrl
        self.screenType = screenType
    }
}
