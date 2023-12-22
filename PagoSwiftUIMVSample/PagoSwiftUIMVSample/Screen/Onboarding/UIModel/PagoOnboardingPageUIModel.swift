//
//  PagoOnboardingPageUIModel.swift
//  PagoBufferSDK
//
//  Created by Cosmin Iulian on 20.12.2023.
//

import PagoUISDK
import Foundation

// MARK: - PagoOnboardingPageUIModel (internal)

struct PagoOnboardingPageUIModel: Model, Identifiable {
    
    // MARK: - Properties (internal)
    
    var labelText: String
    var imageURLString: String
    
    // MARK: - Computed properties (internal)
    
    var id: String {
        labelText
    }
    
    var labelModel: PagoLabelModel {
        let priority = ContentPriorityBase(priority: .init(2000), axis: .vertical)
        let size = PagoSize(height: 50)
        let style = PagoLabelStyle(
            customStyle: .blackBold24,
            size: size,
            alignment: .center,
            lineBreakMode: .byWordWrapping,
            numberOfLines: 2,
            contentHuggingPriority: priority
        )
        return PagoLabelModel(text: labelText,style: style)
    }
    
    var loadedImageViewModel: PagoLoadedImageViewModel {
        let size = CGSize(width: 300, height: 300)
        let imageData = BackendImage(url: imageURLString, placeholderImageName: "")
        let style = PagoImageViewStyle(size: size, contentMode: .scaleAspectFit)
        return PagoLoadedImageViewModel(imageData: imageData, style: style)
    }
}
