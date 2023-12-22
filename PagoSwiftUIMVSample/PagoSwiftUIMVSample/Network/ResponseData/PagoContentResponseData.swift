//
//  PagoContentResponseData.swift
//  PagoSwiftUIMVSample
//
//  Created by Cosmin Iulian on 20.12.2023.
//

import PagoUISDK
import PagoCoreSDK

// MARK: - PagoContentResponseData (internal)

struct PagoContentResponseData: BasePagoCodable, Model {
    
    // MARK: - Properties (internal)
    
    let labelText: String
    let countButtonText: String
    let introButtonText: String
    let onboardingButtonText: String
    let onboardingPresentedButtonText: String
}
