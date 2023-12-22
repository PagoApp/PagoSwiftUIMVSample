//
//  
//  PagoStackedInfosModel.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 21.11.2023.
//
//
import PagoUISDK
import UIKit

internal struct PagoStackedInfosModel: Model {

    let fieldText: String
    let fieldPlaceholder: String
    let fieldDetail: String
    let labelText: String
    
    internal var labelModel: PagoLabelModel {
        let size = PagoSize(width: 40, height: nil)
        let style = PagoLabelStyle(textColorType: .blackBodyText, fontType: .regular16, size: size, alignment: .center, numberOfLines: 0, contentHuggingPriority: ContentPriorityBase(priority: .init(rawValue: 251), axis: .horizontal))
        let model = PagoLabelModel(text: labelText, style: style)
        return model
    }

    internal lazy var fieldModel: PagoTextFieldModel = {
        let style = PagoTextFieldStyle(isTitleUppercased: false, placeholderColor: UIColor.Pago.sdkLightGray, textFieldInvalidColor: .redNegative, textFieldDefaultLineColor: UIColor.Pago.sdkLightGray, textFieldInvalidLineColor: .redNegative,titleFont: .regular13, detailNumberOfLines: 0)
        let model = PagoTextFieldModel(text: fieldText, placeholder: fieldPlaceholder, detail: fieldDetail, style: style)
        return model
    }()

    internal var containerModel: PagoStackedInfoModel {
        let style = PagoStackedInfoStyle(distribution: .fill, alignment: .center, axis: .horizontal, spacing: 16, marginInset: UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0))
        return PagoStackedInfoModel(models: [], style: style)
    }
}
