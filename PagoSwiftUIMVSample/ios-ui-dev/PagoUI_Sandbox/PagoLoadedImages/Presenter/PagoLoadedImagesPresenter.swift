//
//  
//  PagoLoadedImagesPresenter.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 21.11.2023.
//
//
import PagoUISDK
import UIKit

internal protocol PagoLoadedImagesPresenterView: BaseStackViewControllerPresenterView {
    
    func add(space: CGFloat)
    func setup(stackView: PagoStackedInfoPresenter)
}

internal class PagoLoadedImagesPresenter: ViewControllerPresenter {

    private var model: PagoLoadedImagesModel {
        get { return baseModel as! PagoLoadedImagesModel }
        set { baseModel = newValue }
    }
    private var repository: PagoLoadedImagesRepository { return baseRepository as! PagoLoadedImagesRepository }
    private var service = PagoLoadedImagesService()
    private var view: PagoLoadedImagesPresenterView? { return self.basePresenterView as? PagoLoadedImagesPresenterView }
    private let predicate: PagoLoadedImagesPredicate
    

    internal init(navigation: PagoNavigationPresenter, predicate: PagoLoadedImagesPredicate) {
        
        self.predicate = predicate
        super.init(navigation: navigation)
        baseRepository = PagoLoadedImagesRepository()
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
        
        let imageViewPresenter = PagoStackedInfoPresenter(model: model.imageStackModel)
        view?.setup(stackView: imageViewPresenter)
    }
}
