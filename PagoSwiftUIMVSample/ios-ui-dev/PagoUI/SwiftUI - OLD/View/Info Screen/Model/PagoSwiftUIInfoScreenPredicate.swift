//
//  PagoSwiftUIInfoScreenPredicate.swift
//  PagoUI
//
//  Created by Cosmin Iulian on 17.11.2023.
//

import Foundation
import PagoUISDK

public struct PagoSwiftUIInfoScreenPredicate: PagoPredicate {
    
    public var isFullScreen: Bool
    public let image: BackendImage
    public let title: String
    public let content: String
    public let mainButtonText: String
    public let secondaryButtonText: String
    
    public init(isFullScreen: Bool = true, image: BackendImage, title: String, content: String, mainButtonText: String, secondaryButtonText: String) {
        
        self.isFullScreen = isFullScreen
        self.image = image
        self.title = title
        self.content = content
        self.mainButtonText = mainButtonText
        self.secondaryButtonText = secondaryButtonText
    }
}
