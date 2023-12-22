//
//  
//  EmptyScreenCellPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 15/03/2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//
import UIKit
import Foundation

public protocol EmptyScreenCellPresenterView: PresenterView {
    func setup(empty: EmptyScreenPresenter)
}

open class EmptyScreenCellPresenter: BaseCellPresenter {

    public override var identifier: String { return EmptyScreenCell.reuseIdentifier }
        
    public var model: EmptyScreenCellModel {
       get { return (self.baseModel as! EmptyScreenCellModel) }
        set { self.baseModel = newValue }
    }
    
    private var infoStackPresenter: PagoStackedInfoPresenter!
    private var view: EmptyScreenCellPresenterView? { return basePresenterView as? EmptyScreenCellPresenterView }
    
    internal func loadData() {
        
        let presenter = EmptyScreenPresenter(model: model.empty)
        view?.setup(empty: presenter)
    }
}
