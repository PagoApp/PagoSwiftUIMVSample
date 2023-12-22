//
//  PagoOnboardingView.swift
//  PagoSwiftUIMVSample
//
//  Created by Cosmin Iulian on 20.12.2023.
//

import SwiftUI
import PagoUISDK

// MARK: - OnboardingView

struct PagoOnboardingView: View {
    
    // MARK: - Subtypes (internal)
    
    enum Action {
        case primary
        case secondary
    }
    
    // MARK: - Data & UI model (internal)
    
    @EnvironmentObject var dataModel: PagoModelData
    var uiModel: PagoOnboardingUIModel {
        dataModel.onboardingUIModel
    }
    
    // MARK: - States (internal)
    
    @State var currentIndex = 0
    
    // MARK: - Properties (internal)
    
    let onDimiss: (Action) -> ()
    
    // MARK: - Computed properties (internal)
    
    var showContinueButton: Double {
        currentIndex == uiModel.pages.count - 1 ? 1.0 : 0.0
    }
    
    var shouldDismiss: Bool {
        currentIndex == uiModel.pages.count - 1
    }
    
    // MARK: - Body (internal)
    
    var body: some View {
        VStack(alignment: .center) {
            
            pagesView
            
            PagoSUPageController(selectedIndex: currentIndex, model: uiModel.pageControllerModel)
                .frame(width: 150, height: 30)
                .padding(.bottom, Constants.padding)
            
            PagoSUButton(model: uiModel.primaryButtonModel) {
                onDimiss(.secondary)
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, Constants.padding)
            
            PagoSUButton(model: uiModel.secondaryButtonModel) {
                if shouldDismiss {
                    onDimiss(.primary)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, Constants.padding)
            .opacity(showContinueButton)
        }
    }
}

// MARK: OnboardingView: private views

private extension PagoOnboardingView {
    
    var pagesView: some View {
        TabView(selection: $currentIndex) {
            ForEach(uiModel.pages) { uiModel in
                createPage(uiModel)
                    .tag(dataModel.index(for: uiModel))
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.easeInOut, value: currentIndex)
        .transition(.slide)
        .padding(.bottom, Constants.padding)
    }
    
    func createPage(_ uiModel: PagoOnboardingPageUIModel) -> some View {
        VStack {
            PagoSULoadedImageView(model: uiModel.loadedImageViewModel)
                .fixedSize(horizontal: true, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .background(Color.red)
            
            PagoSULabel(model: uiModel.labelModel)
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .padding(.horizontal, Constants.padding)
        }
    }
}

// MARK: Constants (private)

private enum Constants {
    static let padding: CGFloat = 24
}

// MARK: - Preview

#Preview {
    PagoOnboardingViewRefactory.createPreview()
}
