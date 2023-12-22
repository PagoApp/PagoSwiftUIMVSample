//
//  PagoInfoAlertPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 30.03.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation
import UIKit

protocol PagoInfoAlertPresenterView: PagoBaseAlertPresenterView {
    
	func add(space: CGFloat)
	func setup(loadedImage: PagoLoadedImageViewPresenter)
	func setup(label: PagoLabelPresenter)
}

class PagoInfoAlertPresenter: PagoBaseAlertPresenter {

    private var model: PagoInfoAlertModel {
        get { return baseModel as! PagoInfoAlertModel }
        set { baseModel = newValue }
    }
	private let predicate: PagoInfoAlertPredicate
	private var repository: PagoInfoAlertRepository { return baseRepository as! PagoInfoAlertRepository }
    private var view: PagoInfoAlertPresenterView? { return self.basePresenterView as? PagoInfoAlertPresenterView }
    
    init(predicate: PagoInfoAlertPredicate) {
		
		self.predicate = predicate
        super.init()
		self.baseRepository = PagoInfoAlertRepository()
    }
    
    override func loadData() {
        
        super.loadData()

		guard let modelT = repository.getData(predicate: predicate) as? PagoInfoAlertModel else { return }
		update(model: modelT)
		
		if let imageModel = model.imageModel {
			let imagePresenter = PagoLoadedImageViewPresenter(model: imageModel)
			view?.setup(loadedImage: imagePresenter)
		}

		if let titleModel = model.titleModel {
			let titlePresenter = PagoLabelPresenter(model: titleModel)
			view?.add(space: 16)
			view?.setup(label: titlePresenter)
		}

		if let messageModel = model.detailModel {
			let detailPresenter = PagoLabelPresenter(model: messageModel)
			view?.add(space: 24)
			view?.setup(label: detailPresenter)
		}
		
		view?.add(space: 40)
    }
}
