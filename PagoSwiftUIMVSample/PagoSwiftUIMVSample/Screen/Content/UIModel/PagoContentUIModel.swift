//
//  PagoContentUIModel.swift
//  PagoSwiftUIMVSample
//
//  Created by Cosmin Iulian on 20.12.2023.
//

import UIKit
import PagoUISDK


// MARK: - PagoContentUIModel (internal)

struct PagoContentUIModel {
    
    // MARK: - Properties (internal)
    
    var labelText: String
    var countButtonText: String
    var introButtonText: String
    var onboardingButtonText: String
    var onboardingPresentedButtonText: String
    
    // MARK: - Computed properties (internal)
    
    var labelModel: PagoLabelModel {
        
        let priority = ContentPriorityBase(priority: .init(2000), axis: .vertical)
        let size = PagoSize(height: 50)
        let style = PagoLabelStyle(
            customStyle: .blackBold24,
            size: size,
            alignment: .center,
            lineBreakMode: .byWordWrapping,
            numberOfLines: 2,
            contentHuggingPriority: priority
        )
        return PagoLabelModel(text: labelText, style: style)
    }
    
    var countButtonModel: PagoButtonModel {
        PagoButtonModel(title: countButtonText, type: .main)
    }
    
    var introButtonModel: PagoButtonModel {
        PagoButtonModel(title: introButtonText, type: .main)
    }
    
    var onboardingButtonModel: PagoButtonModel {
        PagoButtonModel(title: onboardingButtonText, type: .main)
    }
    
    var onboardingPresentedButtonModel: PagoButtonModel {
        PagoButtonModel(title: onboardingPresentedButtonText, type: .main)
    }
    
    // MARK: - Initializers (internal)
    
    init() {
        // MARK: - BUG HERE: when you send an empty string to PagoButton
        labelText = " "
        countButtonText = " "
        introButtonText = " "
        onboardingButtonText = " "
        onboardingPresentedButtonText = " "
    }
    
    init(
        labelText: String,
        countButtonText: String,
        introButtonText: String,
        onboardingButtonText: String,
        onboardingPresentedButtonText: String
    ) {
        self.labelText = labelText
        self.countButtonText = countButtonText
        self.introButtonText = introButtonText
        self.onboardingButtonText = onboardingButtonText
        self.onboardingPresentedButtonText = onboardingPresentedButtonText
    }
}
