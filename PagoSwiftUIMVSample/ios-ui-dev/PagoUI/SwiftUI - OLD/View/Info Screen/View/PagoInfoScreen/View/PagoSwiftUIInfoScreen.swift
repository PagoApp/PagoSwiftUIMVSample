//
//  PagoSwiftUIInfoScreen.swift
//  PagoUI
//
//  Created by Cosmin Iulian on 17.11.2023.
//

import SwiftUI
import PagoUISDK

@available(iOS 15.0, *)
struct PagoSwiftUIInfoScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let predicate: PagoSwiftUIInfoScreenPredicate
    let model = PagoSwiftUIInfoScreenModel()
    
    let mainAction: ()->()
    let secondaryAction: ()->()
    
    var body: some View {
        
        VStack {
            HStack {
                //TODO: USE BUTTON WRAPPER INSTEAD OF SWIFTUI NATIVE BUTTON
                Button("X") {
                    presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(PagoSwiftUICloseButtonStyle())
                
                Spacer()
            }
            
            PagoSwiftUILoadedImageViewWrapper(model: model.imageModel(predicate.image))
                .frame(width: 300, height: 300)
                .padding(.horizontal, 60)
                .padding(.bottom, 20)
                .scaledToFit()
            
            PagoSwiftUILabelWrapper(model: model.titleModel(predicate.title))
                .frame(height: 60)
                .padding(.horizontal, 25)
            
            PagoSwiftUILabelWrapper(model: model.subtitleModel(predicate.content))
                .frame(height: 70)
                .padding(.horizontal, 25)
        }
        
        Spacer()
        
        VStack {
            PagoSwiftUIButtonWrapper(model: model.mainButtonModel(predicate.mainButtonText))
                .onTapGesture {
                    mainAction()
                    presentationMode.wrappedValue.dismiss()
                }
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
            
            PagoSwiftUIButtonWrapper(model: model.secondaryButtonModel(predicate.secondaryButtonText))
                .onTapGesture {
                    secondaryAction()
                    presentationMode.wrappedValue.dismiss()
                }
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
        }
    }
}

@available(iOS 15.0, *)
struct IntroScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let mainAction = {}
        let secondaryAction = {}
        let imageData = BackendImage(
            url: "https://assets.pago.ro/sdk/bcr/bills/img_scan_bill.png",
            placeholderImageName: ""
        )
        let title = "Avem nevoie de permisiune pentru utilizarea camerei foto"
        let content = "Pentru a putea scana talonul este necesar accesul la camera foto."
        let mainButtonText = "Oferă acces"
        let secondaryButtonText = "Mai târziu"
        let predicate = PagoSwiftUIInfoScreenPredicate(
            image: imageData,
            title: title,
            content: content,
            mainButtonText: mainButtonText,
            secondaryButtonText: secondaryButtonText
        )
        
        PagoSwiftUIInfoScreen(
            predicate: predicate,
            mainAction: mainAction,
            secondaryAction: secondaryAction
        )
    }
}
