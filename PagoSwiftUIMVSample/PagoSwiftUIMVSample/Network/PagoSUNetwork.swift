//
//  PagoSUNetwork.swift
//  PagoSwiftUIMVSample
//
//  Created by Cosmin Iulian on 20.12.2023.
//

import UIKit
@_implementationOnly import PagoApiClient
@_implementationOnly import PagoCoreSDK

// MARK: - PagoSUNetwork (internal)

class PagoSUNetwork {
    
    // MARK: - Static properties (internal)
    
    static let shared = PagoSUNetwork()
    
    // MARK: - Methods (internal)
    
    func getContentData(completion: @escaping (PagoOperationStatus<PagoContentResponseData?>)->()) {
        PagoApiClientManager.shared.getMockContentData { result in
            switch result {
            case .success(let response):
                let dynamicIntroData = response.data
                completion(.success(dynamicIntroData))
            case .failure(let error):
                completion(.error(error))
            }
        }
    }
    
    func getOnboardingData(completion: @escaping (PagoOperationStatus<PagoOnboardingResponseData?>)->()) {
        PagoApiClientManager.shared.getMockOnboardingData { result in
            switch result {
            case .success(let response):
                let onboardingData = response.data
                completion(.success(onboardingData))
            case .failure(let error):
                completion(.error(error))
            }
        }
    }
}
