//
//  BaseTableViewControllerPresenter.swift
//  PagoUISDK
//
//  Created by Gabi on 22.07.2022.
//

import Foundation

open class BaseTableViewControllerPresenter: ViewControllerPresenter {
    
    private var view: ViewControllerPresenterView? { return basePresenterView as? ViewControllerPresenterView }
    
    public func getLoadingCellPresenters<T, M>(from repository: BaseTableViewControllerRepository<T, M>) -> [PagoLoadingCellPresenter] {
        
        let cellModels = repository.loadingCellModels
        let cellPresenters = cellModels.map({PagoLoadingCellPresenter(model: $0)})
        return cellPresenters
    }
    
    final public func setupLoadingStart<T, M>(from repository: BaseTableViewControllerRepository<T, M>) {
        
        //TODO: do we need to check the emtpySreenPresenter?
        if self.emptyScreenPresenter == nil, let emptyModel = repository.emptyListScreenModel {
            let emptyScreenPresenter = PagoEmptyListScreenPresenter(model: emptyModel)
            self.view?.setupEmptyScreen(presenter: emptyScreenPresenter)
            self.emptyScreenPresenter = emptyScreenPresenter
        }
        if self.screenLoaderPresenter == nil, let screenLoader = repository.screenLoaderModel {
            let screenLoaderPresenter = PagoStackedInfoPresenter(model: screenLoader)
            self.view?.setupScreenLoader(presenter: screenLoaderPresenter, backgroundColor: repository.screenLoaderBackground)
            self.screenLoaderPresenter = screenLoaderPresenter
        }
        self.setupLoadingCells()
        self.getDataFromRepository()
    }

    open var sectionsCount: Int {
        fatalError("This must be overriden")
    }
    
    open func cellsCount(in section: Int) -> Int {
        fatalError("This must be overriden")
    }
    
    open func setupLoadingCells() {
        fatalError("This must be overriden")
    }
    
    open func cellPresenter(row: Int, section: Int) -> BaseCellPresenter? {
        fatalError("This must be overriden")
    }

    open func didSelect(row: Int, section: Int) {
        //NOTE: Override for custom implementation
    }
    
    open func headerPresenter(section: Int) -> BasePresenter? {
        //NOTE: Override if headers are required
        return nil
    }
}
