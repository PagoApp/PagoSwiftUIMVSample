//
//  PagoSUApiClientManager.swift
//  PagoSwiftUIMVSample
//
//  Created by Cosmin Iulian on 20.12.2023.
//

import UIKit
import PagoApiClient
import PagoCoreSDK

// MARK: - PagoApiClientManager (internal)

extension PagoApiClientManager {
    
    // MARK: - Methods (internal)
    
    func getMockContentData(completionBlock: @escaping (PagoApiClientResult<PagoResponse<PagoContentResponseData>>) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let mockData = PagoContentResponseData(
                labelText: "Count..",
                countButtonText: "Press me!", 
                introButtonText: "Present Intro View",
                onboardingButtonText: "Navigate to Onboarding View",
                onboardingPresentedButtonText: "Present Onboarding View"
            )
            completionBlock(.success(.init(error: false, data: mockData)))
        }
    }
    
    func getMockOnboardingData(completionBlock: @escaping (PagoApiClientResult<PagoResponse<PagoOnboardingResponseData>>) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let mockPagesData = [
                PagoOnboardingPageResponseData(
                    labelText: "Toate facturile într-un singur loc",
                    imageURLString: "https://assets.pago.ro/sdk/bcr/bills/img_onboarding_page1.png"
                ),
                PagoOnboardingPageResponseData(
                    labelText: "Ai la îndemână istoricul plăților tale",
                    imageURLString: "https://assets.pago.ro/sdk/bcr/bills/img_onboarding_page2.png"
                ),
                PagoOnboardingPageResponseData(
                    labelText: "Primești notificări la facturi noi și scadente",
                    imageURLString: "https://assets.pago.ro/sdk/bcr/bills/img_onboarding_page3.png"
                ),
            ]
            let mockData = PagoOnboardingResponseData(
                primaryButtonText: "Importa",
                secondaryButtonText: "Continua",
                pages: mockPagesData
            )
            completionBlock(.success(.init(error: false, data: mockData)))
        }
    }
}
