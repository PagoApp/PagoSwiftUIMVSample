//
//  PagoSULabel.swift
//  PagoSwiftUISample
//
//  Created by Doru-Andrei Erdei on 12.12.2023.
//

import UIKit
import SwiftUI
import PagoUISDK

// MARK: - PagoSULabel (public)

/// A wrapper bridging ``PagoLabel`` to SwiftUI
///
public struct PagoSULabel: UIViewRepresentable {
    
    // MARK: - Properties (internal)
    
    let model: PagoLabelModel
    
    // MARK: - Initializers (public)
    
    public init(model: PagoLabelModel) {
        self.model = model
    }
    
    // MARK: - Methods (public)
    
    public func makeUIView(context: Context) -> PagoLabel {
        let presenter = PagoLabelPresenter(model: model)
        let pagoLabel = PagoLabel(presenter: presenter)
        pagoLabel.translatesAutoresizingMaskIntoConstraints = true
        return pagoLabel
    }
    
    public func updateUIView(_ uiView: PagoLabel, context: Context) {
        uiView.presenter.update(model: model)
        uiView.translatesAutoresizingMaskIntoConstraints = true
    }
}
