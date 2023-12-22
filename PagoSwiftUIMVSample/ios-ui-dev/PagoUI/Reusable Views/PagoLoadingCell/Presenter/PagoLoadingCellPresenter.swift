//
//  
//  PagoLoadingCellPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 02.09.2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//

import Foundation

public protocol PagoLoadingCellPresenterView: PresenterView {
    
    func setup(stack: PagoStackedInfoPresenter)
}

public class PagoLoadingCellPresenter: BaseCellPresenter {

    override public var identifier: String {
        return PagoLoadingCell.reuseIdentifier
    }

    private var model: PagoLoadingCellModel {
        get { self.baseModel as! PagoLoadingCellModel }
        set { self.baseModel = newValue }
    }
    
    private var view: PagoLoadingCellPresenterView? { return (basePresenterView as? PagoLoadingCellPresenterView) }
    private var stackPresenter: PagoStackedInfoPresenter!
    
    func loadData() {
    
        stackPresenter = PagoStackedInfoPresenter(model: model.stackModel)
        view?.setup(stack: stackPresenter)
    }
  
}
