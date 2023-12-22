//
//  PagoContentView.swift
//  PagoSwiftUIMVSample
//
//  Created by Cosmin Iulian on 20.12.2023.
//

import SwiftUI
import PagoUISDK

// MARK: - PagoContentView (internal)

struct PagoContentView: View {
    
    // MARK: - Data & UI model (internal)
    
    @EnvironmentObject var dataModel: PagoModelData
    var uiModel: PagoContentUIModel {
        dataModel.contentUIModel
    }
    
    // MARK: - States (internal)
    
    @State var presentIntroView = false
    @State var presentOnboardingView = false
    @State var navigateToOnboardingView = false
    @State var countValue = 0
    
    
    // MARK: - Body (internal)
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                
                PagoSULabel(model: uiModel.labelModel)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                
                PagoSUButton(model: uiModel.countButtonModel) {
                    countValue += 1
                    dataModel.setupLabel(countValue)
                }
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                
                PagoSUButton(model: uiModel.introButtonModel) {
                    presentIntroView = true
                }
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                
                PagoSUButton(model: uiModel.onboardingButtonModel) {
                    navigateToOnboardingView = true
                }
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                
                PagoSUButton(model: uiModel.onboardingPresentedButtonModel) {
                    presentOnboardingView = true
                }
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                NavigationLink(destination: onboardingView, isActive: $navigateToOnboardingView) {
                    EmptyView()
                }
            }
            .padding(.horizontal, Constants.padding)
            .navigationBarTitle("SwiftUI - MV Pattern")
        }
        .fullScreenCover(isPresented: $presentIntroView) {
            PagoContentViewRefactory.createIntroView()
        }
        .sheet(isPresented: $presentOnboardingView) {
            onboardingView
        }
    }
}

// MARK: - PagoContentView: private views

private extension PagoContentView {
    
    var onboardingView: some View {
        PagoOnboardingView() { action in
            switch action {
            case .primary:
                print("primary")
            case .secondary:
                print("secondary")
            }
            navigateToOnboardingView = false
            presentOnboardingView = false
        }
    }
}

// MARK: - Constants (private)

private enum Constants {
    static let padding: CGFloat = 24
}

// MARK: - Preview

#Preview {
    PagoContentView()
        .environmentObject(PagoModelData())
}
