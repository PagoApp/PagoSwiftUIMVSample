//
//  
//  PagoInformativeModel.swift
//  PagoUISDK
//
//  Created by Gabi on 10.08.2022.
//
//
import UIKit

public struct PagoInformativeModel: Model {

    public let text: String
    public var placeholders: [PagoPlaceholderModel]?
    public let style: PagoStackedInfoStyle
    public let labelStyle: PagoLabelStyle
    public let imageModel: DataImageModel
    
    var iconModel: PagoLoadedImageViewModel {
        
        let size = CGSize(width: 20, height: 20)
        let style = PagoImageViewStyle(size: size, contentMode: .scaleAspectFit)
        return PagoLoadedImageViewModel(imageData: imageModel, style: style)
    }
    
    var labelModel: PagoLabelModel {

        let model = PagoLabelModel(text: text, placeholders: placeholders, style: self.labelStyle)
        return model
    }

    lazy var containerModel: PagoStackedInfoModel = {

        return PagoStackedInfoModel(models: [], hasAction: true, style: style)
    }()
    
    public init(text: String, placeholders: [PagoPlaceholderModel]? = nil, style: PagoStackedInfoStyle? = nil, labelStyle: PagoLabelStyle? = nil, imageModel: DataImageModel) {
        
        self.text = text
        self.placeholders = placeholders
        if let style = style {
            self.style = style
        } else {
            let inset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            let cornerRadius = Int(PagoThemeStyle.custom.generalViewCornerRadius)
            self.style = PagoStackedInfoStyle(backgroundColor: PagoThemeStyle.custom.tertiaryBackgroundColor, distribution: .fill, alignment: .center, axis: .horizontal, spacing: 16, cornerRadius: cornerRadius, inset: inset)
        }
        if let labelStyle = labelStyle {
            self.labelStyle = labelStyle
        } else {
            let huggingPriority = ContentPriorityBase(priority: .init(rawValue: 251), axis: .horizontal)
            self.labelStyle = PagoLabelStyle(customStyle: .greyRegular14, alignment: .left, numberOfLines: 0, contentHuggingPriority: huggingPriority)
        }
        self.imageModel = imageModel
    }
}
