//
//  PagoSwiftUIButtonWrapper.swift
//  PagoUI
//
//  Created by Cosmin Iulian on 06.10.2023.
//

import SwiftUI
import PagoUISDK

// MARK: - PagoSwiftUIButtonWrapper (internal)

struct PagoSwiftUIButtonWrapper: UIViewRepresentable {
    
    // MARK: - Properties (internal)
    
    let model: PagoButtonModel
    
    // MARK: - Methods (internal)
    
    func makeUIView(context: Context) -> PagoSwiftUIButton {
        
        let presenter = PagoButtonPresenter(model: model)
        return PagoSwiftUIButton(presenter: presenter)
    }
    
    func updateUIView(_ uiView: PagoSwiftUIButton, context: Context) {
        
        uiView.presenter = PagoButtonPresenter(model: model)
    }
}
