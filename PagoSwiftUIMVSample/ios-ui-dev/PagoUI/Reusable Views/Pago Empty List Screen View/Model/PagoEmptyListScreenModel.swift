//
//
//  PagoEmptyListScreenModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 11.11.2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//

import UIKit

public struct PagoEmptyListScreenModel: Model {
    
    public enum ActionPosition {
        case inline, bottom
    }
    
    internal let imageModel: PagoLoadedImageViewModel
    internal let titleText: String
    internal let detailText: String
    internal var actionText: String?
    internal var topStack: PagoStackedInfoModel?
    internal var bottomStack: PagoStackedInfoModel?
    internal let actionPosition: ActionPosition
    internal let stackBackgroundColor: UIColor.Pago
    
    internal var titleModel: PagoLabelModel {
        
        let titleStyle = PagoLabelStyle(customStyle: .blackBold24, backgroundColorType: .clear, alignment: .center, numberOfLines: 0)
        let titleLabel = PagoLabelModel(text: titleText, style: titleStyle)
        return titleLabel
    }
    
    internal var detailModel: PagoLabelModel {
        
        let titleStyle = PagoLabelStyle(customStyle: .greyRegular14, backgroundColorType: .clear, alignment: .center, numberOfLines: 0)
        let titleLabel = PagoLabelModel(text: detailText, style: titleStyle)
        return titleLabel
    }
    
    internal var actionModel: PagoButtonModel? {
        
        guard let actionText = actionText else { return nil }
        let button = PagoButtonModel(title: actionText, type: .main)
        return button
    }
    
    internal func getEmptyModel(height: CGFloat) -> PagoSimpleViewModel {
        
        let verticalSpacer = PagoSimpleViewStyle(height: height, backgroundColorType: .clear)
        let verticalModel = PagoSimpleViewModel(style: verticalSpacer)
        return verticalModel
    }
    
    internal var contentStack: PagoStackedInfoModel {
        
        let style = PagoStackedInfoStyle(backgroundColor: stackBackgroundColor, distribution: .fill, alignment: .fill, axis: .vertical, spacing: 0)
        let spacer40 = getEmptyModel(height: 40)
        let spacer16 = getEmptyModel(height: 16)
        let model = PagoStackedInfoModel(models: [imageModel, spacer40, titleModel, spacer16, detailModel], style: style)
        return model
    }
    
    public init(imageModel: PagoLoadedImageViewModel, titleText: String, detailText: String, actionText: String? = nil, topStack: PagoStackedInfoModel? = nil, bottomStack: PagoStackedInfoModel? = nil, actionPosition: ActionPosition = .bottom, stackBackgroundColor: UIColor.Pago? = nil) {
        
        self.imageModel = imageModel
        self.titleText = titleText
        self.detailText = detailText
        self.actionText = actionText
        self.topStack = topStack
        self.bottomStack = bottomStack
        self.actionPosition = actionPosition
        self.stackBackgroundColor = stackBackgroundColor ?? PagoThemeStyle.custom.primaryBackgroundColor
    }
}
