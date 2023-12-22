//
//  
//  PagoMenusPresenter.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 01.11.2023.
//
//
import PagoUISDK
import UIKit

internal protocol PagoMenusPresenterView: BaseStackViewControllerPresenterView {
    
    func setup(stackView: PagoStackedInfoPresenter)
}

internal class PagoMenusPresenter: ViewControllerPresenter {

    private var model: PagoMenusModel {
        get { return baseModel as! PagoMenusModel }
        set { baseModel = newValue }
    }
    private var repository: PagoMenusRepository { return baseRepository as! PagoMenusRepository }
    private var service = PagoMenusService()
    private var view: PagoMenusPresenterView? { return self.basePresenterView as? PagoMenusPresenterView }
    private let predicate: PagoMenusPredicate
    
    private var textFieldPresenter: PagoTextFieldPresenter!
    public var checkboxPresenter: PagoCheckboxPresenter!
    private var continueButtonPresenter: PagoButtonPresenter!

    internal init(navigation: PagoNavigationPresenter, predicate: PagoMenusPredicate) {
        
        self.predicate = predicate
        super.init(navigation: navigation)
        baseRepository = PagoMenusRepository()
    }
    
    internal override func loadData() {

        super.loadData()
        setupLoadingStart(from: repository)
    }
    
    internal override func getData(completion: @escaping (Model) -> ()) {
        repository.getData(predicate: predicate, completion: completion)
    }
        
    internal override func getRemoteData(completion: @escaping (Model) -> ()) {
        repository.getRemoteData(predicate: predicate, completion: completion)
    }
    
    internal override func setupPresenters() {
        
        let stackPresenter = PagoStackedInfoPresenter(model: model.containerStack)
        view?.setup(stackView: stackPresenter)
        
        let menuPresenter = PagoMenuPresenter(model: model.underlinedMenu)
        stackPresenter.addMenu(presenter: menuPresenter)
        
        let bgMenu = PagoMenuPresenter(model: model.backgroundMenu)
        stackPresenter.addMenu(presenter: bgMenu)
        
    }
}
