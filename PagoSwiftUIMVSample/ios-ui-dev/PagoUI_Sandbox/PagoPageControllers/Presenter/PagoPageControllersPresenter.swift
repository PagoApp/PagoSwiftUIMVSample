//
//  
//  PagoPageControllersPresenter.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 21.11.2023.
//
//
import PagoUISDK
import UIKit

internal protocol PagoPageControllersPresenterView: BaseStackViewControllerPresenterView {
    
    func setup(stackView: PagoStackedInfoPresenter)

}

internal class PagoPageControllersPresenter: ViewControllerPresenter {

    private var model: PagoPageControllersModel {
        get { return baseModel as! PagoPageControllersModel }
        set { baseModel = newValue }
    }
    private var repository: PagoPageControllersRepository { return baseRepository as! PagoPageControllersRepository }
    private var service = PagoPageControllersService()
    private var view: PagoPageControllersPresenterView? { return self.basePresenterView as? PagoPageControllersPresenterView }
    private let predicate: PagoPageControllersPredicate


    internal init(navigation: PagoNavigationPresenter, predicate: PagoPageControllersPredicate) {
        
        self.predicate = predicate
        super.init(navigation: navigation)
        baseRepository = PagoPageControllersRepository()
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
        
        let stackPresenter = PagoStackedInfoPresenter(model: model.pageControllersStackModel)
        view?.setup(stackView: stackPresenter)
    }
}
