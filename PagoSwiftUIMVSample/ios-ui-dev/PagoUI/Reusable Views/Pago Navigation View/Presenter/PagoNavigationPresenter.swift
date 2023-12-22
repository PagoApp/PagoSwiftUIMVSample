//
//  
//  PagoNavigationPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 29/07/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import Foundation
import UIKit

public protocol PagoNavigationPresenterView: PresenterView {
    func setup(type: PagoNavigationType)
    func setup(button: PagoButtonPresenter)
    func update(offset: Float)
    func update(title: String?, detail: String?)
    func startSearch()
    func stopSearch()
    func setupView(background: UIColor.Pago)
    func hideRightButtons()
    func showRightButtons()
}

public protocol PagoNavigationPresenterDelegate: AnyObject {
    func didUpdateTitleVisibility(isVisible: Bool)
    func didSetupNavigation()
}

public extension PagoNavigationPresenterDelegate {
    func didUpdateTitleVisibility(isVisible: Bool) {}
    func didSetupNavigation() {}
}

open class PagoNavigationPresenter: BasePresenter {

    weak var delegate: PagoNavigationPresenterDelegate?

    var model: PagoNavigationModel {
        get { return  (self.baseModel as! PagoNavigationModel) }
        set { baseModel = newValue }
    }
    
    var offset: Float = 0 {
        didSet {
            guard offset != oldValue else { return }
            delegate?.didUpdateTitleVisibility(isVisible: isTitleVisible)
        }
    }

    var hasButtons: Bool {
        return smallRightButtonsPresenters.count > 0
    }
    
    var handlesPop: Bool {
        return model.handlesPop
    }
    
    var title: String? { return model.title }
    var titleColor: UIColor.Pago { return style.titleColor }
    var shortTitle: String? { return model.shortTitle }
    var backButtonTitle: String? { return model.backButtonTitle }
    var image: String? { return model.image }
    var backendImage: BackendImage? { return model.backendImage }
    var hidesBackButton: Bool { return model.hidesBackButton }
    var searchPlaceholder: String? { return model.searchPlaceholder }
    var detail: String? { return model.detail }
    var type: PagoNavigationType { return model.type }
    var searchSize: Float { return model.style.searchSize }
    var breathSpace: Float { return model.style.breathSpace }
    var isSnapping: Bool { return model.isSnapping }
    var isHidden: Bool { return offset == 0 || type == .none }
    var isSearchable: Bool { return type == .simpleSearchable || type == .detailedSearchable }
    var isSearching: Bool { return model.search?.count ?? 0 > 0 }
    var searchModeSize: Float { return breathSpace + searchSize + breathSpace }
    public var smallRightButtonsPresenters = [PagoButtonPresenter]()
    public var largeRightButtonsPresenters = [PagoButtonPresenter]()
    
    private var view: PagoNavigationPresenterView? { return basePresenterView as? PagoNavigationPresenterView }

    public var search: String? {
        get { return model.search }
        set { model.search = newValue}
    }
    var style: PagoNavigationStyle {
        return model.style
    }
    
    var titleSize: Float {
        get { return model.style.titleSize }
        set { model.style.titleSize = newValue }
    }
    
    var detailSize: Float {
        get { return model.style.detailSize }
        set { model.style.detailSize = newValue }
    }
    
    public var isTitleVisible: Bool {
        switch self.type {
        case .simpleSearchable, .simple:
            return offset > breathSpace
        case .detailedSearchable, .detailed:
            return offset > breathSpace + detailSize
        case .none:
            return false
        }
    }
    
    var size: Float {
        switch self.type {
        case .none:
            return 0
        case .simple:
            return breathSpace + titleSize + breathSpace
        case .detailed:
            return breathSpace + titleSize + detailSize + breathSpace
        case .simpleSearchable:
            return breathSpace + titleSize + breathSpace + searchSize + breathSpace
        case .detailedSearchable:
            return breathSpace + titleSize + detailSize + breathSpace + searchSize + breathSpace
        }
    }
    
    let offsetHideAll = Float(0)
    var searchBarPresenter: PagoSearchBarPresenter!

    internal func showRightButtons() {
        view?.showRightButtons()
    }
    
    internal func hideRightButtons() {
        view?.hideRightButtons()
    }
    
    public func loadData() {
        
        view?.setupView(background: style.backgroundColor)
        if let rightButtons = model.rightButtons {
            smallRightButtonsPresenters = [PagoButtonPresenter]()
            for buttonModel in rightButtons {
                let smallButtonPresenter = PagoButtonPresenter(model: buttonModel)
                smallRightButtonsPresenters.append(smallButtonPresenter)
                let largeButtonPresenter = PagoButtonPresenter(model: buttonModel)
                largeRightButtonsPresenters.append(largeButtonPresenter)
            }
        }
        
        let searchModel = PagoSearchBarModel(text: nil, placeholder: model.searchPlaceholder)
        searchBarPresenter = PagoSearchBarPresenter(model: searchModel)
        view?.setup(type: type)
        for button in largeRightButtonsPresenters {
            view?.setup(button: button)
        }
        updateContent()
        delegate?.didSetupNavigation()
    }
    
    func updateTitle(short: String, long: String) {
        
        model.title = long
        model.shortTitle = short
    }

    func updateContent() {
        
        switch type {
        case .simple:
            view?.update(title: title, detail: nil)
        case .detailed:
            view?.update(title: title, detail: detail)
        case .simpleSearchable:
            view?.update(title: title, detail: nil)
            searchBarPresenter.update(text: search, placeholder: searchPlaceholder)
        case .detailedSearchable:
            view?.update(title: title, detail: detail)
            searchBarPresenter.update(text: search, placeholder: searchPlaceholder)
        default:
            break
        }
        offset = size
        view?.update(offset: offset)
    }
    
    public func cancel() {
        
        search = nil
        updateContent()
    }
    
    public override func update(model: Model) {
        
        super.update(model: model)
        updateContent()
    }
    
    public func update(offset: Float) {
        
        self.offset = offset
        view?.update(offset: offset)
    }
    
    public func disableButtons() {
        largeRightButtonsPresenters.forEach { rightButtons in
            rightButtons.isEnabled = false
        }
        smallRightButtonsPresenters.forEach { rightButtons in
            rightButtons.isEnabled = false
        }
    }
    
    public func enableButtons() {
        largeRightButtonsPresenters.forEach { rightButtons in
            rightButtons.isEnabled = true
        }
        smallRightButtonsPresenters.forEach { rightButtons in
            rightButtons.isEnabled = true
        }
    }
    
    public func offsetSnaps(for type: PagoNavigationType) -> [Float] {
        switch type {
        case .simple:
            return [0, breathSpace + titleSize + breathSpace]
        case .detailed:
            return [0, breathSpace + titleSize + detailSize + breathSpace]
        case .simpleSearchable:
            return [0, breathSpace + titleSize + breathSpace, breathSpace + titleSize + breathSpace + searchSize + breathSpace]
        case .detailedSearchable:
            return [0, breathSpace + titleSize + detailSize + breathSpace, breathSpace + titleSize + detailSize + breathSpace + searchSize + breathSpace]
        default:
            return [0]
        }
    }
    
    public func handleSnap(isCollapsing: Bool) -> Float? {
        
        guard type != .none, isSnapping, !isSearching else { return nil }
        let snaps = offsetSnaps(for: type)
        
        if isCollapsing {
            return firstSnapFromEnd(offset: offset, snaps: snaps)
        } else {
            return firstSnapFromStart(offset: offset, snaps: snaps)
        }
    }
    
    func firstSnapFromStart(offset: Float, snaps: [Float]) -> Float? {
        
        var i = 0
        while i < snaps.count {
            if snaps[i] > offset {
                return snaps[i]
            }
            i += 1
        }
        return nil
    }
    
    func firstSnapFromEnd(offset: Float, snaps: [Float]) -> Float? {
        
        var i = snaps.count - 1
        while i >= 0 {
            if snaps[i] < offset {
                return snaps[i]
            }
            i -= 1
        }
        return nil
    }
    
    func startSearch() {
        
        guard isSearchable else { return }
        view?.startSearch()
    }
    
    func stopSearch() {
        
        guard isSearchable else { return }
        view?.stopSearch()
    }
}
