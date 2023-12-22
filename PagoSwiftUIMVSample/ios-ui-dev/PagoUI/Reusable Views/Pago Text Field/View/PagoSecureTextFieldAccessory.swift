//
//  PagoSecureTextFieldAccessory.swift
//  PagoUISDK
//
//  Created by Gabi on 26.07.2023.
//

import Foundation

public class PagoSecureTextFieldAccessory: PagoService {
    
    // Use bigger index for special case
    public enum PagoSecurePassButton: Int {
        case show = 1000, hide, none
    }
    
    public init() {
        
    }
    
    var hiddenImage: PagoLoadedImageViewModel {
        let imageSize = CGSize(width: 24, height: 24)
        let imageStyle = PagoImageViewStyle(size: imageSize)
        let localImage = PagoImage(image: .hide)
        let image = PagoLoadedImageViewModel(imageData: localImage, style: imageStyle)
        return image
    }
    
    var visibleImage: PagoLoadedImageViewModel {
        let imageSize = CGSize(width: 24, height: 24)
        let imageStyle = PagoImageViewStyle(size: imageSize)
        let localImage = PagoImage(image: .show)
        let image = PagoLoadedImageViewModel(imageData: localImage, style: imageStyle)
        return image
    }

    public var hiddenPasswordButton: PagoButtonModel {
        let button = PagoButtonModel(imageView: hiddenImage, isSelfSized: true, index: PagoSecurePassButton.show.rawValue, style: PagoButtonStyle(backgroundColor: .clear))
        return button

    }
    
    public var visiblePasswordButton: PagoButtonModel {
        let button = PagoButtonModel(imageView: visibleImage, isSelfSized: true, index: PagoSecurePassButton.hide.rawValue, style: PagoButtonStyle(backgroundColor: .clear))
        return button
    }
    
    public func getPassButton(prev: PagoSecurePassButton) -> PagoButtonModel {
        switch prev {
        case .show:
            return visiblePasswordButton
        case .hide, .none:
            return hiddenPasswordButton
        }
    }

    public func getButtonType(index: Int) -> PagoSecurePassButton {
        return PagoSecurePassButton(rawValue: index) ?? .none
    }
}
