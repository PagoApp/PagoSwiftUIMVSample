//
//  PagoSUIntroUIModel.swift
//  PagoUISDK
//
//  Created by Cosmin Iulian on 19.12.2023.
//

import UIKit
import PagoUISDK

// MARK: - PagoSUIntroUIModel (internal)

struct PagoSUIntroUIModel: Model {
    
    // MARK: - Methods (internal)
    
    func mainButtonModel(_ buttonText: String) -> PagoButtonModel {
        let button = PagoButtonModel(title: buttonText, isEnabled: true, type: .main)
        return button
    }
    
    func secondaryButtonModel(_ buttonText: String) -> PagoButtonModel {
        let button = PagoButtonModel(title: buttonText, isEnabled: true, type: .tertiary)
        return button
    }
    
    func titleModel(_ titleText: String) -> PagoLabelModel {
        let priority = ContentPriorityBase(priority: .init(2000), axis: .vertical)
        let size = PagoSize(height: 24)
        let style = PagoLabelStyle(
            customStyle: .blackBold24,
            size: size,
            alignment: .center,
            lineBreakMode: .byWordWrapping,
            numberOfLines: 2,
            contentHuggingPriority: priority
        )
        let label = PagoLabelModel(text: titleText, style: style)
        return label
    }
    
    func subtitleModel(_ subtitleText: String) -> PagoLabelModel {
        let priority = ContentPriorityBase(priority: .init(19999), axis: .vertical)
        let style = PagoLabelStyle(
            customStyle: .greyRegular16,
            alignment: .center,
            lineBreakMode: .byWordWrapping,
            numberOfLines: 0,
            contentHuggingPriority: priority
        )
        let label = PagoLabelModel(text: subtitleText, style: style)
        return label
    }
    
    func imageModel(_ imageData: BackendImage) -> PagoLoadedImageViewModel {
        let size = CGSize(width: 300, height: 300)
        let style = PagoImageViewStyle(size: size, contentMode: .scaleAspectFit)
        return PagoLoadedImageViewModel(imageData: imageData, style: style)
    }
}
