//
//  ViewControllerPresenter.swift
//  Pago
//
//  Created by Bogdan-Gabriel Chiosa on 13/12/2019.
//  Copyright © 2019 cleversoft. All rights reserved.
//
import UIKit
import Foundation

public protocol BaseStackViewControllerPresenterView: BaseScrollableViewControllerPresenterView {
    
}

public protocol BaseScrollableViewControllerPresenterView: ViewControllerPresenterView {

}

public protocol ViewControllerPresenterView: PresenterView {
    
    func showOverlayLoading()
    func hideOverlayLoading()
    func setupNavigation(presenter: PagoNavigationPresenter)
    func shouldShowTitle(_ showTitle: Bool)
    func snapNavigation(offset: Float?)
    func setupEmptyScreen(presenter: PagoEmptyListScreenPresenter)
    func setupScreenLoader(presenter: PagoStackedInfoPresenter, backgroundColor: UIColor.Pago)
    func setupViewBackground(hasEmptyScreen: Bool)
    func willShowEmptyScreen()
    func willHideEmptyScreen()
    func endRefreshAnimation()
    func startRefreshAnimation()
    func setupPullToRefresh()
    func removePullToRefresh()
    func dismissKeyboard()
    func setupForPopHandler()
    func removePopHandler()
}

public protocol ViewControllerPresenterDelegate: AnyObject {
    func showGenericErrorScreen()
}

open class ViewControllerPresenter: BasePresenter {
    
    public var baseRepository: PagoRepository?
    private var isSearching: Bool = false
    public let navigationPresenter: PagoNavigationPresenter
    public var hasPullToRefresh: Bool = false {
        didSet {
            if hasPullToRefresh == true {
                view?.setupPullToRefresh()
            } else {
                view?.removePullToRefresh()
            }
        }
    }
    public var emptyScreenPresenter: PagoEmptyListScreenPresenter?
    public var screenLoaderPresenter: PagoStackedInfoPresenter?
    
    enum Direction {
        case collapse, expand, none
    }
    var scrollDirection: Direction = .none
    var scrollViewOldContentOffsetY = Float(0)
    var navigationTitleColor: UIColor.Pago { return navigationPresenter.titleColor }
    var navigationTitle: String? { return navigationPresenter.shortTitle }
    var backButtonTitle: String? { return navigationPresenter.backButtonTitle }
    var navigationImage: String? { return navigationPresenter.image }
    var navigationBackendImage: BackendImage? { return navigationPresenter.backendImage }
    var isLargeTitleVisible: Bool { return navigationPresenter.isTitleVisible }
    var hidesBackButton: Bool { return navigationPresenter.hidesBackButton }
    var isPendingMode: Bool = false
    public var isScrolling: Bool = false

    private var view: ViewControllerPresenterView? { return basePresenterView as? ViewControllerPresenterView }
    
    public init(navigation: PagoNavigationPresenter, model: Model = EmptyModel()) {
        
        self.navigationPresenter = navigation
        super.init(model: model)
        self.navigationPresenter.delegate = self
    }
    
    public override init(model: Model = EmptyModel()) {
        self.navigationPresenter = PagoNavigationPresenter(model: PagoNavigationModel(type: .none))
        super.init(model: model)
    }
    
    open func loadData() {
        
        self.view?.setupNavigation(presenter: navigationPresenter)
        if navigationPresenter.type == .none {
            view?.shouldShowTitle(true)
        }
    }
    
    open func popScreen() {
        
        if navigationPresenter.handlesPop {
            fatalError("Must override")
        }
    }
    
    open func didFinishInteractivePop() {
        
        if navigationPresenter.handlesPop {
            //NOTE: Override this method to know when user finishes pop
        }
    }
    
    open func willDissapear() {
        
        if navigationPresenter.handlesPop {
            
            view?.removePopHandler()
        }
    }
    
    open func willAppear() {
        
        if navigationPresenter.handlesPop {
            
            view?.setupForPopHandler()
        }
    }

    open func reloadDataFromRemote() {
    
        self.view?.startRefreshAnimation()
        self.getDataFromRepository(forceRemote: true) { [weak self] in
            self?.view?.endRefreshAnimation()
        }
    }
    
    open func setupLoadingStart<T, M>(from repository: BaseViewControllerRepository<T, M>) {
        
        //TODO: do we need to check the emtpySreenPresenter?
        if self.emptyScreenPresenter == nil, let emptyModel = repository.emptyListScreenModel {
            let emptyScreenPresenter = PagoEmptyListScreenPresenter(model: emptyModel)
            self.view?.setupEmptyScreen(presenter: emptyScreenPresenter)
            self.view?.setupViewBackground(hasEmptyScreen: false)
            self.emptyScreenPresenter = emptyScreenPresenter
        }
        if self.screenLoaderPresenter == nil, let screenLoader = repository.screenLoaderModel {
            let screenLoaderPresenter = PagoStackedInfoPresenter(model: screenLoader)
            self.view?.setupScreenLoader(presenter: screenLoaderPresenter, backgroundColor: repository.screenLoaderBackground)
            self.screenLoaderPresenter = screenLoaderPresenter
        }
        self.getDataFromRepository()
    }
    
    //TODO: To be removed after person details is refactored to the new base generic repository
    open func setupLoading(screenLoader: PagoStackedInfoModel, screenLoaderBackground: UIColor.Pago) {
        if self.screenLoaderPresenter == nil {
            let screenLoaderPresenter = PagoStackedInfoPresenter(model: screenLoader)
            self.view?.setupScreenLoader(presenter: screenLoaderPresenter, backgroundColor: screenLoaderBackground)
            self.screenLoaderPresenter = screenLoaderPresenter
        }
    }
    
    /// If we need to handle custom logic when an empty screen is presented
    /// override this method and handle the logic
    open func willShowEmptyScreen() {
        navigationPresenter.hideRightButtons()
        self.view?.setupViewBackground(hasEmptyScreen: true)
    }
    
    /// If we need to handle custom logic when an empty screen is presented
    /// override this method and handle the logic
    open func willHideEmptyScreen() {
        navigationPresenter.showRightButtons()
        self.view?.setupViewBackground(hasEmptyScreen: false)

    }
    
    open func setupPresenters() {
        fatalError("This must be overriden")
    }

    open func getData(completion: @escaping(Model)->()) {
        fatalError("This must be overriden")
    }
    
    open func getRemoteData(completion: @escaping(Model)->()) {
        fatalError("This must be overriden")
    }
    
    open var hasEmptyScreen: Bool {
        //NOTE: Override for custom behaviour
        return false
    }
    
    final func getDataFromRepository(forceRemote: Bool, completion: @escaping(Model)->() ) {
        if forceRemote {
            getRemoteData(completion: completion)
        } else {
            getData(completion: completion)
        }
    }
    
    final public func getDataFromRepository(forceRemote: Bool = false, completion: (()->())? = nil) {
        
        view?.showOverlayLoading()
        getDataFromRepository(forceRemote: forceRemote) { [weak self] model in
            guard let self = self else { return }
            self.update(model: model)
            self.setupPresenters()
            self.view?.hideOverlayLoading()
            if self.hasEmptyScreen {
                self.emptyScreenPresenter?.show()
                self.view?.willShowEmptyScreen()
            } else {
                self.emptyScreenPresenter?.hide()
                self.view?.willHideEmptyScreen()
            }
            self.view?.reloadView()
            completion?()
        }
    }
    
    open func reloadData() {
        //NOTE: Override this method to reload ui where neccessary
    }
    
    public func enableNavigationButtons() {
        
        navigationPresenter.enableButtons()
    }
    
    public func disableNavigationButtons() {
        
        navigationPresenter.disableButtons()
    }
 
    public func enterSearchMode() {
        
        guard navigationPresenter.isSearchable else { return }
        isSearching = true
        navigationPresenter.startSearch()
        view?.snapNavigation(offset: navigationPresenter.searchModeSize)
        view?.shouldShowTitle(true)
        
    }
    
    public func exitSearchMode() {
        
        guard navigationPresenter.isSearchable else { return }
        isSearching = false
        navigationPresenter.stopSearch()
        view?.snapNavigation(offset: navigationPresenter.size)
        view?.shouldShowTitle(!isLargeTitleVisible)
    }
    
    func updateNavigationTitle() {
        
        view?.shouldShowTitle(!isLargeTitleVisible)
    }

    func canSnap(contentOffset: Float) -> Bool {
        
        return (navigationPresenter.offset > 0 || contentOffset <= 0) && navigationPresenter.isSnapping && !navigationPresenter.isSearching
    }
    
    func didScroll(y scrollViewY: Float) -> Float? {
        
        guard canSnap(contentOffset: scrollViewY) else { return nil }
        
        var scrollViewContentOffsetY = scrollViewY
        let delta =  scrollViewContentOffsetY - scrollViewOldContentOffsetY
        //we compress the top view
        if delta > 0 && navigationPresenter.offset > 0 && scrollViewContentOffsetY > 0 {
            navigationPresenter.update(offset: max(0, navigationPresenter.offset - delta))
            scrollViewContentOffsetY -= delta
            scrollDirection = .collapse
        }

        //we expand the top view
        if delta < 0 && navigationPresenter.offset < navigationPresenter.size && scrollViewContentOffsetY < 0 {
            navigationPresenter.update(offset: min(navigationPresenter.offset - delta, navigationPresenter.size))
            scrollViewContentOffsetY -= delta
            scrollDirection = .expand
        }
        return scrollViewContentOffsetY
    }
    
    func willBeginDecelerating() {
        
        guard navigationPresenter.isHidden == false, navigationPresenter.isSnapping && !navigationPresenter.isSearching else { return }

        if navigationPresenter.offset <= navigationPresenter.size {
            snapView()
        }
    }

    func snapView() {
        
        guard navigationPresenter.isHidden == false, navigationPresenter.isSnapping && !navigationPresenter.isSearching else { return }
        
        let snapOffset = navigationPresenter.handleSnap(isCollapsing: scrollDirection == .collapse)
        view?.snapNavigation(offset: snapOffset)
        scrollDirection = .none
    }
    
    open func navigationViewDidLoad() {}
    
    public func setNavigationRightButtonsDelegate(_ delegate: PagoButtonPresenterDelegate) {
        navigationPresenter.smallRightButtonsPresenters.forEach({$0.delegate = delegate})
        navigationPresenter.largeRightButtonsPresenters.forEach({$0.delegate = delegate})
    }

}

extension ViewControllerPresenter: PagoNavigationPresenterDelegate {
    
    @objc open func didUpdateTitleVisibility(isVisible: Bool) {
        
        guard !isSearching else { return }
        view?.shouldShowTitle(!isVisible)
    }
    
    @objc public func didSetupNavigation() {}
}

open class EmptyModel: Model {
    
    public init() {
        
    }
}
