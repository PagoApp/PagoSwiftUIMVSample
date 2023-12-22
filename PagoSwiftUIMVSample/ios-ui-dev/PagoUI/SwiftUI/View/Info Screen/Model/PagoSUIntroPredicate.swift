//
//  PagoSUIntroPredicate.swift
//  PagoUISDK
//
//  Created by Cosmin Iulian on 17.11.2023.
//

import Foundation
import PagoUISDK

// MARK: - PagoSUIntroPredicate (public)

public struct PagoSUIntroPredicate: PagoPredicate {
    
    // MARK: - Properties (public)
    
    public var isFullScreen: Bool
    public let image: BackendImage
    public let title: String
    public let content: String
    public let mainButtonText: String
    public let secondaryButtonText: String
    
    // MARK: Initializers (public)
    
    public init(
        isFullScreen: Bool = true,
        image: BackendImage,
        title: String,
        content: String,
        mainButtonText: String,
        secondaryButtonText: String
    ) {
        self.isFullScreen = isFullScreen
        self.image = image
        self.title = title
        self.content = content
        self.mainButtonText = mainButtonText
        self.secondaryButtonText = secondaryButtonText
    }
}
