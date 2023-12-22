//
//  
//  PagoButtonsPresenter.swift
//  PagoUI_Sandbox
//
//  Created by LoredanaBenedic on 14.03.2023.
//
//
import PagoUISDK
import UIKit

protocol PagoButtonsPresenterView: BaseStackViewControllerPresenterView {
    
    func add(space: CGFloat)
    func setup(button: PagoButtonPresenter)
}

class PagoButtonsPresenter: ViewControllerPresenter {

    private var model: PagoButtonsModel {
        get { return baseModel as! PagoButtonsModel }
        set { baseModel = newValue }
    }
    private var repository: PagoButtonsRepository { return baseRepository as! PagoButtonsRepository }
    private var service = PagoButtonsService()
    private var view: PagoButtonsPresenterView? { return self.basePresenterView as? PagoButtonsPresenterView }
    private let predicate: PagoButtonsPredicate
    
	private var buttonPresenters: [PagoButtonPresenter] = []

    init(navigation: PagoNavigationPresenter, predicate: PagoButtonsPredicate) {
        
        self.predicate = predicate
        super.init(navigation: navigation)
        baseRepository = PagoButtonsRepository()
    }
    
    override func loadData() {

        super.loadData()
        setupLoadingStart(from: repository)
    }
    
    override func getData(completion: @escaping (Model) -> ()) {
        repository.getData(predicate: predicate, completion: completion)
    }
        
    override func getRemoteData(completion: @escaping (Model) -> ()) {
        repository.getRemoteData(predicate: predicate, completion: completion)
    }
    
    override func setupPresenters() {

		for model in model.models {
				
			let presenter = PagoButtonPresenter(model: model)
			
			view?.add(space: 16)
			buttonPresenters.append(presenter)
			view?.setup(button: presenter)
		}
    }
}
