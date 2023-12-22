//
//  ProvidersHeadePresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 22/04/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

open class TableViewSimpleHeaderPresenter: BasePresenter {

    public var title: String {
        return model.title
    }
    
    private var model: TableViewSimpleHeaderModel {
       return (self.baseModel as! TableViewSimpleHeaderModel)
    }
    
    public var style: TableViewSimpleHeaderStyle {
        return model.style
    }
    
    private var view: PresenterView? { return basePresenterView }
    
    public override func update(model: Model) {
        
        super.update(model: model)
        view?.reloadView()
    }
}
