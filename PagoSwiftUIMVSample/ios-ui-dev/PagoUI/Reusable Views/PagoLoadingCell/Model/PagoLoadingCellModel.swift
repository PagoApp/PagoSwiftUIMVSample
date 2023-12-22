//
//  
//  PagoLoadingCellModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 02.09.2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//
import UIKit

public struct PagoLoadingCellModel: BaseCellModel {
    
    public var baseStyle: BaseCellStyle = PagoLoadingCellStyle()

    public init() {
        
    }
    
    let horizontalStackStyle = PagoStackedInfoStyle(distribution: .fill, alignment: .center, axis: .horizontal, spacing: 16, inset: UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32))
    
    let mainStackStyle = PagoStackedInfoStyle(backgroundColor: .clear, distribution: .fill, alignment: .fill, axis: .vertical, spacing: 16, inset: UIEdgeInsets(top: 32, left: 0, bottom: 32, right: 0))
    
    lazy var stackModel: PagoStackedInfoModel = {
 
        let baseModel16 = PagoSimpleViewModel(style: PagoSimpleViewStyle(width: 16, height: 16, backgroundColorType: .custom("E0E3EC"), cornerRadius: 6))
        
        let baseModel52 = PagoSimpleViewModel(style: PagoSimpleViewStyle(width: 52, height: 10, backgroundColorType: .custom("E0E3EC"), cornerRadius: 6))
        
        let baseModel74 = PagoSimpleViewModel(style: PagoSimpleViewStyle(width: 74, height: 10, backgroundColorType: .custom("E0E3EC"), cornerRadius: 6))
        
        let baseModel86 = PagoSimpleViewModel(style: PagoSimpleViewStyle(width: 86, height: 10, backgroundColorType: .custom("E0E3EC"), cornerRadius: 6))
        
        let titleStyle = PagoLabelStyle(textColorType: .redNegative, fontType: .regular17, contentCompressionResistance: ContentPriorityBase(priority: .defaultLow, axis: .horizontal))
        let baseModelSpace = PagoLabelModel(text: "", style: titleStyle)
        
        let mainStackModel = PagoStackedInfoModel(models: [baseModel74, baseModel74], style: mainStackStyle)
        let horizontalModels: [Model] = [baseModel16, baseModel52, mainStackModel, baseModelSpace, baseModel86]
        let model: PagoStackedInfoModel = PagoStackedInfoModel(models: horizontalModels, style: horizontalStackStyle)
        return model
        
    }()

}

struct PagoLoadingCellStyle: BaseCellStyle {
    
    var backgroundColorType: UIColor.Pago = .custom("E9ECF2")
}
