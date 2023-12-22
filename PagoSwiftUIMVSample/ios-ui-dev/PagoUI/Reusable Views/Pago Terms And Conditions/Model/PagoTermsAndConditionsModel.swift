//
//  
//  PagoTermsAndConditionsModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit

public struct PagoTermsAndConditionsModel: Model {
    
    let webModel: PagoWebModel
    let labelModel: PagoLabelModel?
    let mainModel: PagoButtonModel?
    var secondaryModel: PagoButtonModel?
    var acceptCheckboxModel: PagoCheckboxModel?
    
    lazy var stackModel: PagoStackedInfoModel = {
        let topInset = (acceptCheckboxModel != nil) ? CGFloat(16) : CGFloat(40)
        let infoStyle = PagoStackedInfoStyle(distribution: .fill, alignment: .fill, axis: .vertical, spacing: 16, marginInset: UIEdgeInsets(top: topInset, left: 24, bottom: 0, right: 24))
        let infoModel = PagoStackedInfoModel(models: [], style: infoStyle)
        return infoModel
    }()
    
    lazy var emptyStackModel: PagoStackedInfoModel = {
        let infoStyle = PagoStackedInfoStyle(distribution: .fill, alignment: .fill, axis: .vertical, spacing: 0)
        let infoModel = PagoStackedInfoModel(models: [], style: infoStyle)
        return infoModel
    }()
    
}
