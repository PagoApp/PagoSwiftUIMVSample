//
//  
//  PagoSpacePresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 19/03/2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//
import UIKit

public protocol PagoSpacePresenterView: PresenterView {
    func setup(size: CGSize)
}

open class PagoSpacePresenter: BasePresenter {

    public convenience init(width: CGFloat = 0, height: CGFloat = 0) {
        let size = CGSize(width: width, height: height)
        let model = PagoSpaceModel(size: size)
        self.init(model: model)
    }

    public var model: PagoSpaceModel {
       return (self.baseModel as! PagoSpaceModel)
    }
    
    private var view: PagoSpacePresenterView? { return basePresenterView as? PagoSpacePresenterView }
    
    internal func loadData() {
     
        view?.setup(size: model.size)
    }
}
