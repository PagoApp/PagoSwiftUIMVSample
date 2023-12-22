//
//  BaseStackViewController.swift
//  Pago
//
//  Created by Gabi Chiosa on 29.07.2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//

import Foundation
import UIKit

open class BaseStackViewController: BaseViewController {
    
    public var scrollView: PagoScrollView!
    public var stackView: PagoStackView!

    private(set) var leadingStackConstraint: NSLayoutConstraint?
    private(set) var trailingStackConstraint: NSLayoutConstraint?
    private(set) var bottomStackConstraint: NSLayoutConstraint?
    private(set) var topStackConstraint: NSLayoutConstraint?
    
    private var presenter: ViewControllerPresenter {
        return basePresenter
    }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.Pago.dividers.color
        scrollView = PagoScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = PagoThemeStyle.custom.primaryBackgroundColor.color
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        self.navScrollView = scrollView
        scrollView.keyboardDismissMode = .interactive
        
        let margins = view.layoutMarginsGuide

        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        if let navigationView = navigationView {
            scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        }
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        let scrollViewBottomConstraint = margins.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        scrollViewBottomConstraint.isActive = true
        self.scrollViewBottomConstraint = scrollViewBottomConstraint
        self.navScrollView = scrollView
        let horizontalMargins = CGFloat(PagoUIConfigurator.customConfig.buttons.marginHorizontal)
        stackView = PagoStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        scrollView.addSubview(stackView)
        leadingStackConstraint = stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        leadingStackConstraint?.isActive = true
        trailingStackConstraint = stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        trailingStackConstraint?.isActive = true
        bottomStackConstraint = stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        bottomStackConstraint?.isActive = true
        topStackConstraint = stackView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        topStackConstraint?.isActive = true
        leadingStackConstraint?.constant = horizontalMargins
        trailingStackConstraint?.constant = horizontalMargins
        topStackConstraint?.constant = 16
        bottomStackConstraint?.constant = 16
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    open override func setupPullToRefresh() {
        setupPullToRefresh(with: scrollView)
    }
    
    open override func removePullToRefresh() {
        removePullToRefresh(from: scrollView)
    }
    
    open func setupCustomMargins(margins : UIEdgeInsets) {

        leadingStackConstraint?.constant = margins.left
        trailingStackConstraint?.constant = -1 * margins.right
        topStackConstraint?.constant = margins.top
        bottomStackConstraint?.constant = -1 * margins.bottom
        self.view.layoutIfNeeded()
    }

    open func updateStackBottomConstraint(constraint: NSLayoutConstraint) {
        if let bottomStackConstraint = bottomStackConstraint {
            bottomStackConstraint.isActive = false
            stackView.removeConstraint(bottomStackConstraint)
        }

        bottomStackConstraint = constraint
        bottomStackConstraint?.isActive = true
        self.view.layoutIfNeeded()
    }
}
