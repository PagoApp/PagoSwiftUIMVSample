//
//  PagoGeneralErrorPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 30.03.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation
import UIKit

protocol PagoGeneralErrorPresenterView: PagoBaseAlertPresenterView {
    
    func setup(stack: PagoStackedInfoPresenter)
}

protocol PagoGeneralErrorPresenterDelegate: PagoBaseAlertPresenterDelegate {
    
    func didTapOk()
}

class PagoGeneralErrorPresenter: PagoBaseAlertPresenter {

    var mDelegate: PagoGeneralErrorPresenterDelegate? {
        return delegate as? PagoGeneralErrorPresenterDelegate
    }
    
    private var model: PagoGeneralErrorModel {
        get { return baseModel as! PagoGeneralErrorModel }
        set { baseModel = newValue }
    }
    private var view: PagoGeneralErrorPresenterView? { return self.basePresenterView as? PagoGeneralErrorPresenterView }
    private var mainButtonPresenter: PagoButtonPresenter!
    
    init(predicate: PagoGeneralErrorPredicate) {
        let model = PagoGeneralErrorModel(title: predicate.title, message: predicate.message, action: predicate.action)
        super.init(model: model)
    }
    
    override func loadData() {
        
        super.loadData()
        baseRepository = PagoGeneralErrorRepository()

        let imagePresenter = PagoLoadedImageViewPresenter(model: model.imageModel)
        mainButtonPresenter = PagoButtonPresenter(model: model.actionButtonModel)
        mainButtonPresenter.delegate = self
        let titlePresenter = PagoLabelPresenter(model: model.titleModel)
        let detailPresenter = PagoLabelPresenter(model: model.messageModel)
        
        let contentStack = PagoStackedInfoPresenter(model: model.stackModel)
        view?.setup(stack: contentStack)
        
        let spacePresenter24 = PagoSpacePresenter(model: PagoSpaceModel(size: CGSize(width: 0, height: 24)))
        let spacePresenter16 = PagoSpacePresenter(model: PagoSpaceModel(size: CGSize(width: 0, height: 16)))
        let spacePresenter40 = PagoSpacePresenter(model: PagoSpaceModel(size: CGSize(width: 0, height: 40)))
        
        
        contentStack.addSpace(presenter: spacePresenter24)
        contentStack.addLoadedImage(presenter: imagePresenter)
        contentStack.addSpace(presenter: spacePresenter16)
        contentStack.addLabel(presenter: titlePresenter)
        contentStack.addSpace(presenter: spacePresenter24)
        contentStack.addLabel(presenter: detailPresenter)
        contentStack.addSpace(presenter: spacePresenter40)
        contentStack.addButton(presenter: mainButtonPresenter)
        contentStack.addSpace(presenter: spacePresenter40)

    }
}


extension PagoGeneralErrorPresenter: PagoButtonPresenterDelegate {
    
    func didTap(button: PagoButtonPresenter) {
        
        mDelegate?.didTapOk()
    }
}
