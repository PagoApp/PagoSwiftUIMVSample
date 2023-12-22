//
//  
//  EmptyScreenPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 23/04/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit
import Foundation

open class EmptyScreenPresenter: BasePresenter {

    public var title: String { return model.title }
    public var detail: String {
        return String.init(format: model.detail, model.placeholder)
    }
    public var placeholder: String { return model.placeholder }
    public var imageType: UIImage.Pago { return model.imageType }
    public var style: EmptyScreenStyle { return model.style }

    private var model: EmptyScreenModel {
        get { return (self.baseModel as! EmptyScreenModel) }
        set { baseModel = newValue }
    }
    
    private var view: PresenterView? { return basePresenterView }

    public func update(placeholder: String) {
        
        model.placeholder = placeholder
        view?.reloadView()
    }
    
    public override func update(model: Model) {
        
        super.update(model: model)
        view?.reloadView()
    }
}
