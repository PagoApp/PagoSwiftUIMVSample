//
//  
//  PagoNavigationView.swift
//  Pago
//
//  Created by Gabi Chiosa on 29/07/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit
//import CommonExtensions

public protocol PagoNavigationViewDelegate: AnyObject {
    func didStartSearch(text: String?)
    func didStopSearch()
}

public class PagoNavigationView: BaseView {
      
    public weak var delegate: PagoNavigationViewDelegate?
    
    enum Priority: Int {
        
        case search = 700
        case bottomTitleDetail = 750
        case topTitle = 900
        case title = 910
        case detail = 920
        case bottom = 960
        
        case searchMode = 950
    }
    
    var presenterView: PagoNavigationPresenter {
        return presenter as! PagoNavigationPresenter
    }

    var viewHeight: Float {
        return Float(heightConstraint?.constant ?? 0)
    }
    
    var titleLabel: UILabel?
    var detailLabel: UILabel?
    var searchBar: PagoSearchBarView?
    var buttonsStackView: PagoStackView?
    
    var searchBarView: UIView?
    var searchBarTopBreathView: UIView?
    var searchBarBottomBreathView: UIView?
    
    @objc dynamic var heightConstraint: NSLayoutConstraint?

    func setup(presenter: PagoNavigationPresenter) {

        self.presenter = presenter
        presenter.setView(mView: self)
        presenterView.setView(mView: self)
        presenterView.loadData()
    }
    
    public func hideRightButtons() {
        
        buttonsStackView?.isHidden = true
    }
    
    public func showRightButtons() {
        
        buttonsStackView?.isHidden = false
    }
    
    public func disableRightButtons() {
        
        presenterView.disableButtons()
    }

    public func enableRightButtons() {
        presenterView.enableButtons()
    }
    
    public func handleSnap(offset: CGFloat, parent: UIView) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.heightConstraint?.constant = offset
            self.presenterView.offset = Float(offset)
            parent.layoutIfNeeded()
        }
    }
    
    private func setupBreathingSpace(top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, priority: Priority) -> UIView? {
        
        guard let holderView = setupViewHolder(top: top, bottom: bottom, height: CGFloat(presenterView.breathSpace), heightPriority: priority.rawValue) else {
            return nil
        }
        return holderView
    }
    
    private func setupTitleLabel(top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, priority: Priority) -> UIView? {
        
        guard let holderView = setupViewHolder(top: top, bottom: bottom, height: CGFloat(presenterView.titleSize), heightPriority: priority.rawValue) else {
            return nil
        }
        
        let title = UILabel()
        title.backgroundColor = presenterView.style.backgroundColor.color
        title.textAlignment = presenterView.style.textAlignment
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        holderView.addSubview(title)
        title.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 24).isActive = true
        title.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -24).isActive = true
        title.bottomAnchor.constraint(equalTo: holderView.bottomAnchor).isActive = true
        title.heightAnchor.constraint(equalToConstant: CGFloat(presenterView.titleSize)).isActive = true
        title.font = UIFont.Pago.bold24.font
        title.textColor = presenterView.style.titleColor.color
        self.titleLabel = title
        return holderView
    }
    
    private func setupDetailLabel(top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, priority: Priority) -> UIView? {
        
        guard let holderView = setupViewHolder(top: top, bottom: bottom, height: CGFloat(presenterView.detailSize), heightPriority: priority.rawValue) else {
            return nil
        }
        
        let detail = UILabel()
        detail.backgroundColor = presenterView.style.backgroundColor.color
        detail.textAlignment = presenterView.style.textAlignment
        detail.numberOfLines = 0
        detail.translatesAutoresizingMaskIntoConstraints = false
        holderView.addSubview(detail)
        detail.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 24).isActive = true
        detail.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -24).isActive = true
        detail.bottomAnchor.constraint(equalTo: holderView.bottomAnchor).isActive = true
        detail.heightAnchor.constraint(equalToConstant: CGFloat(presenterView.detailSize)).isActive = true
        detail.font = UIFont.Pago.medium15.font
        detail.textColor = UIColor.Pago.grayTertiaryText.color
        self.detailLabel = detail
        return holderView
    }
    
    private func setupSearchBar(top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, priority: Priority) -> UIView? {
        
        guard let holderView = setupViewHolder(top: top, bottom: bottom, height: CGFloat(presenterView.searchSize), heightPriority: priority.rawValue) else {
            return nil
        }
        searchBarView = holderView
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.red
        
        let searchHolder = PagoSearchBarView(presenter: presenterView.searchBarPresenter)
        searchHolder.translatesAutoresizingMaskIntoConstraints = false
        holderView.addSubview(searchHolder)
        
        searchHolder.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 24).isActive = true
        searchHolder.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -24).isActive = true
        searchHolder.bottomAnchor.constraint(equalTo: holderView.bottomAnchor).isActive = true
        searchHolder.heightAnchor.constraint(equalToConstant: 44).isActive = true

        self.searchBar = searchHolder
        self.searchBar?.delegate = self
        return holderView
    }
    
    private func setupViewHolder(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor? = nil, height: CGFloat, heightPriority: Int) -> UIView? {
        
        guard let topAnchor = top else { return nil }
        
        let holderView = UIView()
        holderView.backgroundColor = presenterView.style.backgroundColor.color
        holderView.clipsToBounds = true
        holderView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(holderView)
        let heightAnchor = holderView.heightAnchor.constraint(equalToConstant: height)
        heightAnchor.priority = UILayoutPriority(Float(heightPriority))
        heightAnchor.isActive = true
        holderView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        holderView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        holderView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        if let bottomAnchor = bottom {
            holderView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
        return holderView
    }
    
    func setupButtonsStackView(bottom: NSLayoutYAxisAnchor) {
        
        let stack = PagoStackView()
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stack)
        stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottom).isActive = true
        self.buttonsStackView = stack
    }

}

extension PagoNavigationView: PagoSearchBarDelegate {
    
    public func searchBarDidSearch(_ text: String?) {
        
        delegate?.didStartSearch(text: text)
    }
    
    public func searchBarDidClear() {

        delegate?.didStopSearch()
    }

    public func searchBarDidStop() {
        
        if let search = presenterView.search, search.count > 0 {
            
        } else {
            stopSearch()
        }
    }
    
    public func searchBarDidStart() {
        
        delegate?.didStartSearch(text: nil)
    }
}

extension PagoNavigationView: PagoNavigationPresenterView {

    public func setupView(background: UIColor.Pago) {
        
        backgroundColor = background.color
    }
    
    public func setup(button: PagoButtonPresenter) {
        
        guard let buttonsView = buttonsStackView  else { return }
        let buttonView = PagoButton(presenter: button)
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        buttonsView.addArrangedSubview(buttonView)
    }
    
    public func update(offset: Float) {
        
        DispatchQueue.main.async { [weak self] in
            self?.heightConstraint?.constant = CGFloat(offset)
        }
    }
    
    public func setup(type: PagoNavigationType) {
        
        let screenWidth = UIScreen.main.bounds.width - 64
        presenterView.detailSize = Float(presenterView.detail?.height(constraintedWidth: screenWidth, font: UIFont.Pago.medium15.font) ?? 16)
        presenterView.titleSize = Float(presenterView.title?.height(constraintedWidth: screenWidth, font: UIFont.Pago.bold24.font) ?? 34)
        let hasButtons = presenterView.hasButtons
        let heightConstraints = self.constraints.filter({$0.firstAttribute == .height})
        self.removeConstraints(heightConstraints)
        
        switch type {
        case .simple:
            let breath = setupBreathingSpace(top: self.topAnchor, priority: .topTitle)
            let titleHolder = setupTitleLabel(top: breath?.bottomAnchor, priority: .title)
            _ = setupBreathingSpace(top: titleHolder?.bottomAnchor, bottom: self.bottomAnchor, priority: .bottom)
            if hasButtons, let bottom = titleHolder?.bottomAnchor {
                setupButtonsStackView(bottom: bottom)
            }
        case .detailed:
            let topBreath = setupBreathingSpace(top: self.topAnchor, priority: .topTitle)
            let titleHolder = setupTitleLabel(top: topBreath?.bottomAnchor, priority: .title)
            let detailHolder = setupDetailLabel(top: titleHolder?.bottomAnchor, priority: .detail)
            _ = setupBreathingSpace(top: detailHolder?.bottomAnchor, bottom: self.bottomAnchor, priority: .bottom)
            if hasButtons, let bottom = titleHolder?.bottomAnchor {
                setupButtonsStackView(bottom: bottom)
            }
        case .simpleSearchable:
            let topBreath = setupBreathingSpace(top: self.topAnchor, priority: .topTitle)
            let titleHolder = setupTitleLabel(top: topBreath?.bottomAnchor, priority: .title)
            searchBarTopBreathView = setupBreathingSpace(top: titleHolder?.bottomAnchor, priority: .bottomTitleDetail)
            let searchHolder = setupSearchBar(top: searchBarTopBreathView?.bottomAnchor, priority: .search)
            searchBarBottomBreathView = setupBreathingSpace(top: searchHolder?.bottomAnchor, bottom: self.bottomAnchor, priority: .bottom)
            if hasButtons, let bottom = titleHolder?.bottomAnchor {
                setupButtonsStackView(bottom: bottom)
            }
        case .detailedSearchable:
            let topBreath = setupBreathingSpace(top: self.topAnchor, priority: .topTitle)
            let titleHolder = setupTitleLabel(top: topBreath?.bottomAnchor, priority: .title)
            let detailHolder = setupDetailLabel(top: titleHolder?.bottomAnchor, priority: .detail)
            searchBarTopBreathView = setupBreathingSpace(top: detailHolder?.bottomAnchor, priority: .bottomTitleDetail)
            let searchHolder = setupSearchBar(top: searchBarTopBreathView?.bottomAnchor, priority: .search)
            searchBarBottomBreathView = setupBreathingSpace(top: searchHolder?.bottomAnchor, bottom: self.bottomAnchor, priority: .bottom)
            if hasButtons, let bottom = titleHolder?.bottomAnchor {
                setupButtonsStackView(bottom: bottom)
            }
        default:
            break
        }
        
        self.heightConstraint = self.heightAnchor.constraint(equalToConstant: CGFloat(presenterView.size))
        self.heightConstraint?.isActive = true
    }

    public func update(title: String?, detail: String?) {
        
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel?.text = title
            self?.detailLabel?.text = detail
            self?.layoutIfNeeded()
        }
    }
    
    public func startSearch() {
        
        updateHeightPriority(view: searchBarTopBreathView, priority: .searchMode)
        updateHeightPriority(view: searchBarBottomBreathView, priority: .searchMode)
        updateHeightPriority(view: searchBarView, priority: .searchMode)
    }
    
    public func stopSearch() {
        
        updateHeightPriority(view: searchBarTopBreathView, priority: .bottomTitleDetail)
        updateHeightPriority(view: searchBarBottomBreathView, priority: .bottom)
        updateHeightPriority(view: searchBarView, priority: .search)
        
    }
    
    private func updateHeightPriority(view: UIView?, priority: Priority) {
        
        let heightConstraint = view?.constraints.first(where: {$0.firstAttribute == .height && $0.relation == .equal})
        heightConstraint?.priority = .init(Float(priority.rawValue))
    }
}
