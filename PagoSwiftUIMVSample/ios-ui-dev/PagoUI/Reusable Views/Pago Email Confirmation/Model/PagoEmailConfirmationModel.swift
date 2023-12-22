//
//  
//  PagoEmailConfirmationModel.swift
//  PagoRCASDK
//
//  Created by Gabi on 19.10.2022.
//
//
import PagoUISDK
import UIKit

public struct PagoEmailConfirmationModel: Model {
            
    private let detail: String
    private let image: DataImageModel
    private var action: String?
    private let emailValidationRules: [ValidationRuleModel]
    
    public init (detail: String, image: DataImageModel, action: String? = nil, emailValidation: [ValidationRuleModel]) {
        
        self.detail = detail
        self.image = image
        if let action = action {
            self.action = action
        }
        self.emailValidationRules = emailValidation
    }
    
    var imageStackModel: PagoStackedInfoModel  {
        let imageStyle = PagoImageViewStyle(size: CGSize(width: 260, height: 260))
        let imageModel = PagoLoadedImageViewModel(imageData: image, style: imageStyle)
        
        let stackStyle = PagoStackedInfoStyle(backgroundColor: .white, distribution: .fill, alignment: .center, axis: .vertical)
        return PagoStackedInfoModel(models: [imageModel], style: stackStyle)
    }
    
    var textField: PagoTextFieldModel {
        let style = PagoTextFieldStyle(keyboardType: .emailAddress)
        return PagoTextFieldModel(placeholder: "Email", validationRules: emailValidationRules, style: style)
    }

    var detailModel: PagoLabelModel {
        let style = PagoLabelStyle(customStyle: .blackRegular14, alignment: .center, numberOfLines: 0)
        let model = PagoLabelModel(text: detail, style: style)
        return model
    }
    
    var continueButton: PagoButtonModel {
        let button = PagoButtonModel(title: action, isEnabled: true, type: .main, height: 48)
        return button
    }
}
