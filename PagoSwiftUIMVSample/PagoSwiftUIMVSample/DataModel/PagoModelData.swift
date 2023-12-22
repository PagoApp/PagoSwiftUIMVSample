//
//  PagoModelData.swift
//  PagoSwiftUIMVSample
//
//  Created by Cosmin Iulian on 20.12.2023.
//

import Foundation
import PagoUISDK

class PagoModelData: ObservableObject {
    
    // MARK: - Properties (private(set))
    
    @Published private(set) var contentUIModel = PagoContentUIModel()
    @Published private(set) var onboardingUIModel = PagoOnboardingUIModel()
    
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
    
    func index(for page: PagoOnboardingPageUIModel) -> Int {
        onboardingUIModel.pages.firstIndex { $0.id == page.id } ?? 0
    }
    
    // MARK: - Methods (private)
    
    private func setupUIModels() {
        setupContentUIModel()
        setupOnboardingUIModel()
    }
    
    private func setupContentUIModel() {
        contentRepository.getInfoScreen { [unowned self] uiModel in
            self.contentUIModel = uiModel
        }
    }
    
    private func setupOnboardingUIModel() {
        onboardingRepository.getOnboardingScreen { [unowned self] uiModel in
            self.onboardingUIModel = uiModel
        }
    }
}
