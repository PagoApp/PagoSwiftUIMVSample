//
//  PagoSUPageController.swift
//  PagoSwiftUISample
//
//  Created by Doru-Andrei Erdei on 12.12.2023.
//

import UIKit
import SwiftUI
import PagoUISDK

// MARK: - PagoSUPageController (public)

/// A wrapper bridging ``PagoPageController`` to SwiftUI
///
public struct PagoSUPageController: UIViewRepresentable {
    
    // MARK: - Properties (internal)
    
    let model: PagoPageControllerModel
    let selectedIndex: Int
    
    // MARK: - Initializers (public)
    
    public init(selectedIndex: Int, model: PagoPageControllerModel) {
        self.model = model
        self.selectedIndex = selectedIndex
    }
    
    // MARK: - Methods (public)
    
    public func makeUIView(context: Context) -> PagoPageController {
        let presenter = PagoPageControllerPresenter(model: model)
        let pageController = PagoPageController(presenter: presenter)
        pageController.translatesAutoresizingMaskIntoConstraints = true
        return pageController
    }
    
    public func updateUIView(_ uiView: PagoPageController, context: Context) {
        uiView.presenter.update(model: model)
        (uiView.presenter as? PagoPageControllerPresenter)?.update(selected: selectedIndex)
        uiView.translatesAutoresizingMaskIntoConstraints = true
    }
}
