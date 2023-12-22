//
//  
//  PagoStepCardModel.swift
//  PagoRCASDK
//
//  Created by Gabi on 10.08.2022.
//
//

import UIKit

public enum PagoStepCardType {
    case completed, pending
}

public struct PagoStepCardModel: Model {

    public var step: PagoStepCardType
    public var index: Int
    public var title: String
    public var detail: String
    public var extra: PagoStackedInfoModel?
    public var completedStepImageModel: DataImageModel
    
    private var stepCardStyle: PagoStepCardStyle {
        PagoStepCardStyle.customStyle(stepCard: PagoUIConfigurator.customConfig.stepCard)
    }

    var containerModel: PagoStackedInfoModel {
        
        let inset = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        let backgroundColor = stepCardStyle.backgroundColor
        let shadow = stepCardStyle.shadowStyle
        let border = stepCardStyle.borderStyle
        let cornerRadius = stepCardStyle.stepCardCornerRadius
        let style = PagoStackedInfoStyle(backgroundColor: backgroundColor, distribution: .fill, alignment: .center, axis: .horizontal, spacing: 16, borderStyle: border, cornerRadius: cornerRadius, inset: inset, shadowStyle: shadow)
        return PagoStackedInfoModel(models: [], hasAction: true, style: style)
    }
    
    private var horizontalCompletedStackStyle: PagoStackedInfoStyle {

        let inset = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        let cornerRadius = Int(PagoThemeStyle.custom.generalViewCornerRadius)
        let stack = PagoStackedInfoStyle(backgroundColor: .lightGreenBackground, distribution: .fill, alignment: .center, axis: .horizontal, spacing: 16, cornerRadius: cornerRadius, inset: inset)
        return stack
    }

    var labelsContainerStack: PagoStackedInfoModel {
        
        let infoStyle = PagoStackedInfoStyle(distribution: .fill, alignment: .leading, axis: .vertical, spacing: 8)
        let model = PagoStackedInfoModel(models: [], style: infoStyle)
        return model
    }
    
    var titleLabelModel: PagoLabelModel {
        
        let style = stepCardStyle.titleLabelStyle
        let title = PagoLabelModel(text: title, style: style)
        return title
    }
    
    var detailLabelModel: PagoLabelModel {
        
        let style = stepCardStyle.detailLabelStyle
        let model = PagoLabelModel(text: detail, style: style)
        return model
    }
    
    var disclosureModel: PagoLoadedImageViewModel {
        
        let size = CGSize(width: 8, height: 16)
        let imageModel = PagoImage(image: .disclosureIcon)
        let style = PagoImageViewStyle(size: size, tintColorType: stepCardStyle.arrowIconColor, contentMode: .scaleAspectFit)
        return PagoLoadedImageViewModel(imageData: imageModel, style: style)
    }
    
    var checkBoxImageModel: PagoLoadedImageViewModel {
        
        let size = CGSize(width: 34, height: 34)
        let imageStyle = PagoImageViewStyle(size: size, contentMode: .scaleAspectFit, backgroundCornerRadius: 17)
        let imageModel = PagoLoadedImageViewModel(imageData: completedStepImageModel, style: imageStyle)
        return imageModel
    }
    
    var labelModel: PagoLabelModel {
        
        let indexStyle =  stepCardStyle.stepLabelStyle
        return PagoLabelModel(text: String(index), style: indexStyle)
    }
    
    public init(step: PagoStepCardType, index: Int, title: String, detail: String, extra: PagoStackedInfoModel? = nil, completedStepImageModel: DataImageModel) {
        
        self.step = step
        self.index = index
        self.title = title
        self.detail = detail
        self.extra = extra
        self.completedStepImageModel = completedStepImageModel
    }

}
