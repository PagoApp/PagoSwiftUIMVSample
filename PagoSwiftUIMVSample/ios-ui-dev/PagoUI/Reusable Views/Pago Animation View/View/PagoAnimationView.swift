//
//  
//  PagoAnimationView.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//


import UIKit
import Foundation

open class PagoAnimationView: BaseView {
        
    lazy var datasource: PagoLottieAnimationDataSource? = {
        return PagoUIConfigurator.datasource?.lottie
    }()
    
    private var animationView: UIView = UIView()
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    private var viewPresenter: PagoAnimationPresenter { return (presenter as! PagoAnimationPresenter) }
    private lazy var bundle = Bundle.init(for: Self.classForCoder())
    
    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    public init(presenter: PagoAnimationPresenter) {
        
        super.init(frame: .zero)
        self.animationView = datasource?.animationViewWrapper ?? UIView()
        setup(presenter: presenter)
    }
    
    public func setup(presenter: PagoAnimationPresenter) {
        
        self.presenter = presenter
        self.presenter.setView(mView: self)
        loadData()
        presenter.loadData()
    }

    private func loadData() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        animationView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(animationView)
        animationView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        animationView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        let width = self.widthAnchor.constraint(equalToConstant: self.viewPresenter.style.size.width)
        width.isActive = true
        widthConstraint = width
        let height = self.heightAnchor.constraint(equalToConstant: self.viewPresenter.style.size.height)
        height.isActive = true
        heightConstraint = height
        animationView.isAccessibilityElement = false
        isAccessibilityElement = viewPresenter.accessibility.isAccessibilityElement
        accessibilityTraits = viewPresenter.accessibility.accessibilityTraits
        accessibilityLabel = viewPresenter.accessibility.accessibilityLabel
    }
    
    public override func reloadView() {

        super.reloadView()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.3) {
                self.widthConstraint?.constant = self.viewPresenter.style.size.width
                self.heightConstraint?.constant = self.viewPresenter.style.size.height
                self.layoutIfNeeded()
            }
        }
    }
}

extension PagoAnimationView: PagoAnimationPresenterView {
    
    public func setup(animation: String, bundle: Bundle? = nil) {
        
        self.datasource?.setupAnimation(view: animationView, animation: animation, bundle: bundle ?? self.bundle, loop: self.viewPresenter.loop)
    }
    
    public func setup(animation: PagoBackendAnimation) {
        
        self.datasource?.setupAnimation(view: self.animationView, animation: animation.url, animationPlaceholder: animation.placeholder.animation, bundle: self.bundle, loop: self.viewPresenter.loop)
    }
    
    public func play() {
     
        self.datasource?.play(view: self.animationView)
    }
    
    public func stop() {
        
        self.datasource?.stop(view: self.animationView)
    }
}
