//
//  BaseCellPresenter.swift
//  Pago
//
//  Created by Bogdan-Gabriel Chiosa on 09/12/2019.
//  Copyright © 2019 cleversoft. All rights reserved.
//
import UIKit

open class BaseCellPresenter: BasePresenter {
    
    open var identifier: String! { return "Cell" }
    public var cellModel: BaseCellModel! {
        return (baseModel as? BaseCellModel) ?? EmptyCellModel()
    }
    public var baseStyle: BaseCellStyle {
        return cellModel.baseStyle
    }
}

public struct EmptyCellModel: BaseCellModel {
    public var baseStyle: BaseCellStyle = EmptyCellStyle()
}

public struct EmptyCellStyle: BaseCellStyle {
    public var backgroundColorType: UIColor.Pago = .white
}

public protocol BaseCellModel: Model {
    var baseStyle: BaseCellStyle {get set}
}

public protocol BaseCellStyle: BaseStyle {
    var backgroundColorType: UIColor.Pago {get set}
}

public protocol BaseViewStyle: BaseStyle {
    var backgroundColorType: UIColor.Pago {get set}
    var tintColorType: UIColor.Pago? {get set}
}

public protocol BaseStyle {}
