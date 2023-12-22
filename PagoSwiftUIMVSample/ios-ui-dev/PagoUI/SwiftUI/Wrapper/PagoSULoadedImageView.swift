//
//  PagoSULoadedImageView.swift
//  PagoSwiftUISample
//
//  Created by Doru-Andrei Erdei on 12.12.2023.
//

import UIKit
import SwiftUI
import PagoUISDK

// MARK: - PagoSULoadedImageView (public)

/// A wrapper bridging ``PagoLoadedImageView`` to SwiftUI
///
public struct PagoSULoadedImageView: UIViewRepresentable {

    // MARK: - Properties (internal)
    
    let model: PagoLoadedImageViewModel
    
    // MARK: - Initializers (public)
    
    public init(model: PagoLoadedImageViewModel) {
        self.model = model
    }
    
    // MARK: - Methods (public)
    
    public func makeUIView(context: Context) -> PagoLoadedImageView {
        let presenter = PagoLoadedImageViewPresenter(model: model)
        let pagoImageView = PagoLoadedImageView(presenter: presenter)
        pagoImageView.translatesAutoresizingMaskIntoConstraints = true
        return pagoImageView
    }
    
    public func updateUIView(_ uiView: PagoLoadedImageView, context: Context) {
        uiView.presenter.update(model: model)
        uiView.translatesAutoresizingMaskIntoConstraints = true
    }
}
