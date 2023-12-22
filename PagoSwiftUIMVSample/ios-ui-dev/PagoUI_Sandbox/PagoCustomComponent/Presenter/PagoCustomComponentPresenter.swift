//
//  
//  PagoCustomComponentPresenter.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 21.11.2023.
//
//
import PagoUISDK
import UIKit

internal protocol PagoCustomComponentPresenterView: BaseStackViewControllerPresenterView {
    
    func setup(custom: PagoStackedInfosPresenter)
}

internal class PagoCustomComponentPresenter: ViewControllerPresenter {

    private var model: PagoCustomComponentModel {
        get { return baseModel as! PagoCustomComponentModel }
        set { baseModel = newValue }
    }
    private var repository: PagoCustomComponentRepository { return baseRepository as! PagoCustomComponentRepository }
    private var service = PagoCustomComponentService()
    private var view: PagoCustomComponentPresenterView? { return self.basePresenterView as? PagoCustomComponentPresenterView }
    private let predicate: PagoCustomComponentPredicate
    

    internal init(navigation: PagoNavigationPresenter, predicate: PagoCustomComponentPredicate) {
        
        self.predicate = predicate
        super.init(navigation: navigation)
        baseRepository = PagoCustomComponentRepository()
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
        
        let presenters = model.components.map({PagoStackedInfosPresenter(model: $0)})
        presenters.forEach({view?.setup(custom: $0)})
    }
}
