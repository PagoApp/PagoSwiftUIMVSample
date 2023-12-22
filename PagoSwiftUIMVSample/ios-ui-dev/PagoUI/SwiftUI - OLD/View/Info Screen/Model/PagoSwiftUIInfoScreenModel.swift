//
//  PagoSwiftUIInfoScreenModel.swift
//  PagoUI
//
//  Created by Cosmin Iulian on 17.11.2023.
//

import PagoUISDK
import UIKit

internal struct PagoSwiftUIInfoScreenModel: Model {
    
    internal func mainButtonModel(_ buttonText: String) -> PagoButtonModel {
        
        let button = PagoButtonModel(title: buttonText, isEnabled: true, type: .main)
        return button
    }
    
    internal func secondaryButtonModel(_ buttonText: String) -> PagoButtonModel {
        
        let button = PagoButtonModel(title: buttonText, isEnabled: true, type: .tertiary)
        return button
    }
    
    internal func titleModel(_ titleText: String) -> PagoLabelModel {
        
        let labelStyle = PagoLabelStyle(customStyle: .blackBold24, alignment: .center, numberOfLines: 0)
        let label = PagoLabelModel(text: titleText, style: labelStyle)
        return label
    }
    
    internal func subtitleModel(_ subtitleText: String) -> PagoLabelModel {
        
        let labelStyle = PagoLabelStyle(customStyle: .greyRegular16, alignment: .center, numberOfLines: 0)
        let label = PagoLabelModel(text: subtitleText, style: labelStyle)
        return label
    }
    
    internal func imageModel(_ imageData: BackendImage) -> PagoLoadedImageViewModel {
        
        let style = PagoImageViewStyle()
        return PagoLoadedImageViewModel(imageData: imageData, style: style)
    }
}
