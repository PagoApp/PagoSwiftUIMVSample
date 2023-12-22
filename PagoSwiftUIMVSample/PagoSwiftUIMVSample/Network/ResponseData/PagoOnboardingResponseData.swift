//
//  PagoOnboardingResponseData.swift
//  PagoSwiftUIMVSample
//
//  Created by Cosmin Iulian on 21.12.2023.
//

import PagoUISDK
import PagoCoreSDK

// MARK: - PagoOnboardingResponseData (internal)

struct PagoOnboardingResponseData: BasePagoCodable, Model {
    
    // MARK: - Properties (internal)
    
    let primaryButtonText: String
    let secondaryButtonText: String
    let pages: [PagoOnboardingPageResponseData]
}

// MARK: - PagoOnboardingPageResponseData (internal)

struct PagoOnboardingPageResponseData: BasePagoCodable, Model {
    
    // MARK: - Properties (internal)
    
    let labelText: String
    let imageURLString: String
}
