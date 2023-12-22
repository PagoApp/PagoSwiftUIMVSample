//
//  PagoSUIntroView.swift
//  PagoUISDK
//
//  Created by Cosmin Iulian on 17.11.2023.
//

import SwiftUI
import PagoUISDK

@available(iOS 14.0, *)
public struct PagoSUIntroView: View {
    
    // MARK: - Properties (internal)
    
    @Environment(\.presentationMode) var presentationMode
    let predicate: PagoSUIntroPredicate
    let model = PagoSUIntroUIModel()
    let mainAction: ()->()
    let secondaryAction: ()->()
    
    // MARK: - Initializers (public)
    
    public init(predicate: PagoSUIntroPredicate, mainAction: @escaping ()->(), secondaryAction: @escaping ()->() = {}) {
        self.predicate = predicate
        self.mainAction = mainAction
        self.secondaryAction = secondaryAction
    }
    
    // MARK: - Body (internal)
    
    public var body: some View {
        VStack(alignment: .center) {
            topButton
            
            PagoSULoadedImageView(model: model.imageModel(predicate.image))
                .fixedSize(horizontal: true, vertical: true)
                .background(Color.red)
            
            PagoSULabel(model: model.titleModel(predicate.title))
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            
            PagoSULabel(model: model.subtitleModel(predicate.content))
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            
            bottomButtons
        }
        .padding(.horizontal, Constants.padding)
    }
}

// MARK: - PagoSUIntroView: private views

@available(iOS 14.0, *)
private extension PagoSUIntroView {
    
    var topButton: some View {
        HStack {
            //TODO: USE BUTTON WRAPPER INSTEAD OF SWIFTUI NATIVE BUTTON
            Button("X") {
                presentationMode.wrappedValue.dismiss()
            }
            
            Spacer()
        }
    }
    
    var bottomButtons: some View {
        VStack {
            Spacer()
            
            PagoSUButton(model: model.mainButtonModel(predicate.mainButtonText)) {
                mainAction()
                presentationMode.wrappedValue.dismiss()
            }
            .fixedSize(horizontal: false, vertical: true)
            
            PagoSUButton(model: model.secondaryButtonModel(predicate.secondaryButtonText)) {
                secondaryAction()
                presentationMode.wrappedValue.dismiss()
            }
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}

// MARK: - Constants (private)

private enum Constants {
    static let padding: CGFloat = 24
}

// MARK: - Preview

@available(iOS 14.0, *)
#Preview {
    PagoSUIntroViewFactory.createPreview()
}
