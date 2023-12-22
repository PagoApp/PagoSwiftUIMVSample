//
//  PagoOnboardingRepository.swift
//  PagoSwiftUIMVSample
//
//  Created by Cosmin Iulian on 21.12.2023.
//

import Foundation
import PagoUISDK

// MARK: - PagoOnboardingRepository (internal)

struct PagoOnboardingRepository: PagoRepository {
    
    // MARK: - Properties (internal)
    
    let network = PagoSUNetwork()
    
    // MARK: - Methods (internal)
    
    func getOnboardingScreen(completion: @escaping (PagoOnboardingUIModel)->()) {
        network.getOnboardingData { status in
            switch status {
            case .success(let data):
                let model = transformDataToModel(data)
                completion(model)
            default:
                completion(PagoOnboardingUIModel())
            }
        }
    }
    
    // MARK: - Methods (private)
    
    private func transformDataToModel(_ data: PagoOnboardingResponseData?) -> PagoOnboardingUIModel {
        if let data = data {
            let pages: [PagoOnboardingPageUIModel] = data.pages.map {
                PagoOnboardingPageUIModel(
                    labelText:  $0.labelText,
                    imageURLString: $0.imageURLString
                )
            }
            return PagoOnboardingUIModel(
                primaryButtonText: data.primaryButtonText,
                secondaryButtonText: data.secondaryButtonText,
                pages: pages
            )
        } else {
            return PagoOnboardingUIModel()
        }
    }
}
