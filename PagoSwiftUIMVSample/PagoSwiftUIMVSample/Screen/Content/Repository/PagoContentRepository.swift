//
//  PagoContentRepository.swift
//  PagoSwiftUIMVSample
//
//  Created by Cosmin Iulian on 20.12.2023.
//

import Foundation
import PagoUISDK

// MARK: - PagoContentRepository (internal)

struct PagoContentRepository: PagoRepository {
    
    // MARK: - Properties (internal)
    
    let network = PagoSUNetwork()
    
    // MARK: - Methods (internal)
    
    func getInfoScreen(completion: @escaping (PagoContentUIModel)->()) {
        network.getContentData { status in
            switch status {
            case .success(let data):
                let model = transformDataToModel(data)
                completion(model)
            default:
                completion(PagoContentUIModel())
            }
        }
    }
    
    // MARK: - Methods (private)
    
    private func transformDataToModel(_ data: PagoContentResponseData?) -> PagoContentUIModel {
        if let data = data {
            return PagoContentUIModel(
                labelText: data.labelText ,
                countButtonText: data.countButtonText,
                introButtonText: data.introButtonText ,
                onboardingButtonText: data.onboardingButtonText,
                onboardingPresentedButtonText: data.onboardingPresentedButtonText
            )
        } else {
            return PagoContentUIModel()
        }
    }
}
