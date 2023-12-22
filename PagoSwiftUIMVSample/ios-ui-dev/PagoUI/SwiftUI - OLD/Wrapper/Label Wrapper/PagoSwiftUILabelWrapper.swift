//
//  PagoSwiftUILabelWrapper.swift
//  PagoUI
//
//  Created by Alex Udrea on 10.11.2023.
//

import SwiftUI
import PagoUISDK

// MARK: - PagoSwiftUILabelWrapper (internal)

struct PagoSwiftUILabelWrapper: UIViewRepresentable {
    
    // MARK: - Properties (internal)
    
    let model: PagoLabelModel
    
    // MARK: - Methods (internal)
    
    func makeUIView(context: Context) -> PagoSwiftUILabel {
        
        let presenter = PagoLabelPresenter(model: model)
        return PagoSwiftUILabel(presenter: presenter)
    }
    
    func updateUIView(_ uiView: PagoSwiftUILabel, context: Context) {
        
        uiView.presenter = PagoLabelPresenter(model: model)
    }
}
