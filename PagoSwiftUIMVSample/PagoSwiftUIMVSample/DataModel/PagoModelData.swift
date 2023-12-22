//
//  PagoModelData.swift
//  PagoSwiftUIMVSample
//
//  Created by Cosmin Iulian on 20.12.2023.
//

import Foundation
import PagoUISDK

protocol PagoModelDataType: ObservableObject {
    func createOnboardingUIModel() async -> PagoOnboardingUIModel
}

class PagoModelData: PagoModelDataType {
    
    // MARK: - Properties (private(set))
    
    @Published private(set) var contentUIModel = PagoContentUIModel()
    
    // MARK: - Properties (private)
    
    private let contentRepository: PagoContentRepository
    private let onboardingRepository: PagoOnboardingRepository
    
    // MARK: - Initializers (internal)
    
    init() {
        contentRepository = PagoContentRepository()
        onboardingRepository = PagoOnboardingRepository()
        setupUIModels()
    }
    
    // MARK: - Methods (internal)
    
    func setupLabel(_ countValue: Int) {
        contentUIModel.labelText = String(countValue)
    }
    
    // MARK: - Methods (private)
    
    private func setupUIModels() {
        setupContentUIModel()
    }
    
    private func setupContentUIModel() {
        contentRepository.getInfoScreen { [weak self] uiModel in
            guard let self else { return }
            
            self.contentUIModel = uiModel
        }
    }
    
    func createOnboardingUIModel() async -> PagoOnboardingUIModel {
        await withCheckedContinuation { continuation in
            onboardingRepository.getOnboardingScreen { uiModel in
                continuation.resume(returning: uiModel)
            }
          }
        
    }
}
