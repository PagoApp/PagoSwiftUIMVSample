//
//  
//  PagoStackedInfosPresenter.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 21.11.2023.
//
//

import PagoUISDK

internal protocol PagoStackedInfosPresenterView: PresenterView {
    func setup(presenter: PagoStackedInfoPresenter)
}

internal protocol PagoStackedInfosPresenterDelegate: AnyObject {
}

internal class PagoStackedInfosPresenter: BasePresenter {

    internal weak var delegate: PagoStackedInfosPresenterDelegate?

    private(set) var containerStack: PagoStackedInfoPresenter!
    private(set) var labelPresenter: PagoLabelPresenter!
    private(set) var fieldPresenter: PagoTextFieldPresenter!
    private var model: PagoStackedInfosModel {
        get { baseModel as! PagoStackedInfosModel }
        set { baseModel = newValue }
    }
    private var view: PagoStackedInfosPresenterView? {
        return basePresenterView as? PagoStackedInfosPresenterView
    }
    
    internal override init(model: Model = EmptyModel()) {
        
        super.init(model: model)
        containerStack = PagoStackedInfoPresenter(model: self.model.containerModel)
        fieldPresenter = PagoTextFieldPresenter(model: self.model.fieldModel)
        labelPresenter = PagoLabelPresenter(model: self.model.labelModel)
    }
    
    internal func loadData() {
        
        view?.setup(presenter: containerStack)
        containerStack.addLabel(presenter: labelPresenter)
        containerStack.addField(presenter: fieldPresenter)
    }

}
