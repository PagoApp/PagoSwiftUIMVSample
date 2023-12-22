//
//  
//  PagoView.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import Foundation
import UIKit

open class PagoSimpleView: BaseView {
  
    private var baseView: UIView!
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?
    private var topConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    private var trailingConstraint: NSLayoutConstraint?
    
    private var viewPresenter: PagoSimpleViewPresenter { return (presenter as! PagoSimpleViewPresenter) }
    
    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
        setupUI()
    }
    
    public init(presenter: PagoSimpleViewPresenter) {
        
        super.init(frame: .zero)
        setupUI()
        setup(presenter: presenter)
    }
    
    public func setup(presenter: PagoSimpleViewPresenter) {
        
        self.presenter = presenter
        presenter.setView(mView: self)
        presenter.loadData()
        baseView.isAccessibilityElement = false
        isAccessibilityElement = presenter.accessibility.isAccessibilityElement
        accessibilityTraits = presenter.accessibility.accessibilityTraits
        accessibilityLabel = presenter.accessibility.accessibilityLabel
    }
    
    private func setupUI() {

        self.translatesAutoresizingMaskIntoConstraints = false
        baseView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(baseView)
        let leading = baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let top = baseView.topAnchor.constraint(equalTo: self.topAnchor)
        let trailing = self.trailingAnchor.constraint(equalTo: baseView.trailingAnchor)
        let bottom = self.bottomAnchor.constraint(equalTo: baseView.bottomAnchor)
        leading.isActive = true
        trailing.isActive = true
        top.isActive = true
        bottom.isActive = true
        self.leadingConstraint = leading
        self.trailingConstraint = trailing
        self.bottomConstraint = bottom
        self.topConstraint = top
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        guard viewPresenter.hasUserInteraction else { return }
        viewPresenter.touchDown()
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesEnded(touches, with: event)
        guard viewPresenter.hasUserInteraction else { return }
        if let touch = touches.first {
            let location = touch.location(in: self)
            if self.bounds.contains(location) {
                viewPresenter.didTap()
            }
        }
        viewPresenter.touchUp()
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesCancelled(touches, with: event)
        guard viewPresenter.hasUserInteraction else { return }
        if let touch = touches.first {
            let location = touch.location(in: self)
            if self.bounds.contains(location) {
                viewPresenter.didTap()
            }
        }
        viewPresenter.touchUp()
    }
}

extension PagoSimpleView: PagoSimpleViewPresenterView {
    
    public func reloadStyle(isTouching: Bool) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.layer.removeAllAnimations()
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear, animations: { [weak self] in
                guard let self = self else { return }
                self.alpha = isTouching ? 0.8 : 1
            }, completion: nil)
        }
    }
    
    public func setupView(style: PagoSimpleViewStyle) {
        
        if let tintColor = style.tintColorType?.color {
            baseView.tintColor = tintColor
        }
        
        self.layer.cornerRadius = CGFloat(style.cornerRadius)
        
        if let border = style.borderStyle {
            borderColor = border.colorType.cgColor
            borderWidth = border.width
        }
        
        clipsToBounds = true
        backgroundColor = style.backgroundColorType.color
        
        if let viewWidth = style.width {
            let width = self.widthAnchor.constraint(equalToConstant: viewWidth)
            width.isActive = true
            widthConstraint = width
        }
        if let viewHeight = style.height {
            let height = self.heightAnchor.constraint(equalToConstant: viewHeight)
            height.isActive = true
            heightConstraint = height
        }
        if let contentCompression = style.contentCompressionResistance {
            baseView.setContentCompressionResistancePriority(contentCompression.priority, for: contentCompression.axis)
        }
        if let contentHugging = style.contentHuggingPriority {
            baseView.setContentHuggingPriority(contentHugging.priority, for: contentHugging.axis)
        }
        layoutIfNeeded()
    }
    
    public func hide(isHidden: Bool) {
        
        DispatchQueue.main.async { [weak self] in
            self?.isHidden = isHidden
        }
    }
}
