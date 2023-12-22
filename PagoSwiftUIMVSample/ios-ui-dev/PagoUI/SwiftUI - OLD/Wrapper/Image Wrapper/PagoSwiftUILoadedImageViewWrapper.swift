//
//  PagoSwiftUILoadedImageViewWrapper.swift
//  PagoUI
//
//  Created by Cosmin Iulian on 17.11.2023.
//

import SwiftUI
import PagoUISDK

// MARK: - PagoSwiftUILoadedImageViewWrapper (internal)

struct PagoSwiftUILoadedImageViewWrapper: UIViewRepresentable {
    
    // MARK: - Properties (internal)
    
    let model: PagoLoadedImageViewModel
    
    // MARK: - Methods (internal)
    
    func makeUIView(context: Context) -> PagoSwiftUILoadedImageView {
        
        let presenter = PagoLoadedImageViewPresenter(model: model)
        return PagoSwiftUILoadedImageView(presenter: presenter)
    }
    
    func updateUIView(_ uiView: PagoSwiftUILoadedImageView, context: Context) {
        
        uiView.presenter = PagoLoadedImageViewPresenter(model: model)
    }
}
