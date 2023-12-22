//
//  PagoGeneralErrorModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 30.03.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation
import UIKit

struct PagoGeneralErrorModel: PagoBaseAlertModel {

    let title: String
    let message: String
    let action: String
    
    let width = UIScreen.main.bounds.width - 48
    
    lazy var stackModel: PagoStackedInfoModel = {
       
        let stackStyle = PagoStackedInfoStyle(backgroundColor: .white, distribution: .fill, alignment: .center, axis: .vertical)
        return PagoStackedInfoModel(models: [], style: stackStyle)
    }()
    
    lazy var imageModel: PagoLoadedImageViewModel = {

        let image = PagoImage(image: .close)
        let imageSize = CGSize(width: width, height: 20)
        let imageStyle = PagoImageViewStyle(size: imageSize, tintColorType: .redNegative, contentMode: .scaleAspectFit)
        let imageModel = PagoLoadedImageViewModel(imageData: image, style: imageStyle)
        return imageModel
    }()
    
    lazy var messageModel: PagoLabelModel = {
        
        let style = PagoLabelStyle(textColorType: .darkGraySecondaryText, fontType: .regular17, size: PagoSize(width: width, height: nil), alignment: .center, numberOfLines: 0)
        return PagoLabelModel(text: message, style: style)
    }()
    
    lazy var titleModel: PagoLabelModel = {
        
        let style = PagoLabelStyle(textColorType: .blackBodyText, fontType: .semiBold17, size: PagoSize(width: width, height: nil), alignment: .center, numberOfLines: 0)
        return PagoLabelModel(text: title, style: style)
    }()
    
    lazy var actionButtonModel: PagoButtonModel = {
        
        var button = PagoButtonModel(title: action, type: .main)
        button.setWidth(width)
        return button
    }()

}
