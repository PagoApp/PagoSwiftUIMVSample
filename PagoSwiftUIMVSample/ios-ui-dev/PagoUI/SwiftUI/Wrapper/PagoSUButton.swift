//
//  PagoSUButton.swift
//  PagoUI
//
//  Created by Doru-Andrei Erdei on 12.12.2023.
//

import UIKit
import SwiftUI
import PagoUISDK

// MARK: - PagoSUButton (public)

/// A wrapper bridging ``PagoButton`` to SwiftUI
///
public struct PagoSUButton: UIViewRepresentable {
    
    // MARK: - Properties (internal)
    
    let model: PagoButtonModel
    let action: () -> Void
    
    // MARK: Initializers (public)
    
    public init(model: PagoButtonModel, action: @escaping () -> Void) {
        self.model = model
        self.action = action
    }
    
    // MARK: - Methods (public)
    
    public func makeUIView(context: Context) -> PagoButton {
        let presenter = PagoButtonPresenter(model: model)
        presenter.delegate = context.coordinator
        let pagoButton = PagoButton(presenter: presenter)
        pagoButton.translatesAutoresizingMaskIntoConstraints = true
        return pagoButton
    }
    
    public func updateUIView(_ uiView: PagoButton, context: Context) {
        uiView.presenter.update(model: model)
        uiView.translatesAutoresizingMaskIntoConstraints = true
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

// MARK: - SUButton - Coordinator (public)

public extension PagoSUButton {
    
    /// Handles delegation messages from ``PagoButton``
    ///
    class Coordinator: NSObject, PagoButtonPresenterDelegate {
        
        // MARK: Methods (internal)
        
        var parent: PagoSUButton
        
        // MARK: Initializers (internal)
        
        init(_ parent: PagoSUButton) {
            self.parent = parent
        }
        
        // MARK: - Methods (public)
        
        public func didTap(button: PagoButtonPresenter) {
            parent.action()
        }
    }
}
