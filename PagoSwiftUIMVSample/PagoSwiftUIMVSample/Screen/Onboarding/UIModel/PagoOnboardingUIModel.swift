//
//  PagoOnboardingUIModel.swift
//  PagoBufferSDK
//
//  Created by Cosmin Iulian on 20.12.2023.
//

import PagoUISDK

// MARK: - PagoOnboardingModel (internal)

struct PagoOnboardingUIModel: Model {
    
    // MARK: - Properties (internal)
    
    var primaryButtonText: String
    var secondaryButtonText: String
    var pages: [PagoOnboardingPageUIModel]
    
    // MARK: - Computed properties (internal)
    
    var primaryButtonModel: PagoButtonModel {
        PagoButtonModel(title: primaryButtonText, type: .main)
    }
    
    var secondaryButtonModel: PagoButtonModel {
        PagoButtonModel(title: secondaryButtonText, type: .main)
    }
    
    var pageControllerModel: PagoPageControllerModel {
        PagoPageControllerModel(
            numberOfPages: pages.count,
            style: PagoPageControllerStyle.customStyle
        )
    }
    
    // MARK: - Initializers (internal)
    
    init() {
        primaryButtonText = " "
        secondaryButtonText = " "
        pages = []
    }
    
    init(primaryButtonText: String, secondaryButtonText: String, pages: [PagoOnboardingPageUIModel]) {
        self.primaryButtonText = primaryButtonText
        self.secondaryButtonText = secondaryButtonText
        self.pages = pages
    }
}
