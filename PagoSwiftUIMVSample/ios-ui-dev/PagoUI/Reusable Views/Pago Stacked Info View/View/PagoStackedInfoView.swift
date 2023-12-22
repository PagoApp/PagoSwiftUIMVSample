//
//  
//  PagoInfoTView.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit
import Foundation

open class PagoStackedInfoView: BaseView {

    private var stackView: PagoStackView!
    private var stackViewHolder: PagoView!
    
    private var viewPresenter: PagoStackedInfoPresenter { return (presenter as! PagoStackedInfoPresenter) }

    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
        setupUI()
    }

    public init(presenter: PagoStackedInfoPresenter) {
       
        super.init(frame: .zero)
        setupUI()
        setup(presenter: presenter)
    }

    public func setup(presenter: PagoStackedInfoPresenter) {
        
        self.presenter = presenter
        stackView.removeAllPagoSubviews()
        presenter.setView(mView: self)
        setupMarginsConstraints(inset: presenter.style.marginInset)
        setupBreathingConstraints(inset: presenter.style.inset)
        presenter.loadData()
        stackView.backgroundColor =  viewPresenter.style.stackBackgroundColor.color
        stackViewHolder.backgroundColor =  viewPresenter.style.backgroundColor.color
        self.backgroundColor = viewPresenter.style.marginBackgroundColor.color
        stackView.alignment = viewPresenter.style.alignment
        stackView.distribution = viewPresenter.style.distribution
        stackView.spacing = viewPresenter.style.spacing
        stackView.axis = viewPresenter.style.axis
        stackView.isAccessibilityElement = false
        
        isAccessibilityElement = viewPresenter.accessibility.isAccessibilityElement
        accessibilityTraits = viewPresenter.accessibility.accessibilityTraits
        accessibilityLabel = viewPresenter.accessibility.accessibilityLabel
        
        if let border = presenter.style.borderStyle {
            stackViewHolder.borderColor = border.colorType.cgColor
            stackViewHolder.borderWidth = border.width
        }
        
        if let radius = presenter.style.cornerRadius {
            stackViewHolder.layer.cornerRadius = CGFloat(radius)
            stackViewHolder.clipsToBounds = true
        }
        
        if let shadowStyle = self.viewPresenter.style.shadowStyle {
            self.layer.shadowOffset = shadowStyle.offset
            self.layer.shadowRadius = shadowStyle.radius
            self.layer.shadowOpacity = shadowStyle.opacity
            self.layer.shadowColor = shadowStyle.colorType.cgColor
        }
    }

    private func setupBreathingConstraints(inset: UIEdgeInsets) {
    
        stackView.leadingAnchor.constraint(equalTo: stackViewHolder.leadingAnchor, constant: inset.left).isActive = true
        stackView.trailingAnchor.constraint(equalTo: stackViewHolder.trailingAnchor, constant: -inset.right).isActive = true
        stackView.topAnchor.constraint(equalTo: stackViewHolder.topAnchor, constant: inset.top).isActive = true
        stackView.bottomAnchor.constraint(equalTo: stackViewHolder.bottomAnchor, constant: -inset.bottom).isActive = true
    }
    
    private func setupMarginsConstraints(inset: UIEdgeInsets) {
        
        stackViewHolder.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset.left).isActive = true
        stackViewHolder.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset.right).isActive = true
        stackViewHolder.topAnchor.constraint(equalTo: self.topAnchor, constant: inset.top).isActive = true
        stackViewHolder.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset.bottom).isActive = true
    }
    
    public func setupUI() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        stackViewHolder = PagoView()
        stackViewHolder.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackViewHolder)
        
        stackView = PagoStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackViewHolder.addSubview(stackView)
    }
    
    override public  func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        guard viewPresenter.hasUserInteraction else { return }
        viewPresenter.touchDown()
    }
    
    override public  func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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
    
    override public  func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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

extension PagoStackedInfoView: PagoStackedInfoPresenterView {
    
    public func addMenu(presenter: PagoMenuPresenter) {
        
        let menu = PagoMenuView(presenter: presenter)
        menu.isAccessibilityElement = false
        stackView.addArrangedSubview(menu)
    }
    
    
    public func addCheckbox(presenter: PagoCheckboxPresenter) {
        
        let checkBox = PagoCheckbox(presenter: presenter)
        checkBox.isAccessibilityElement = false
        stackView.addArrangedSubview(checkBox)
    }
    
    public func addPageController(presenter: PagoPageControllerPresenter) {
        let view = PagoPageController(presenter: presenter)
        stackView.addArrangedSubview(view)
    }
    

    public func hideView(isHidden: Bool) {
        
        DispatchQueue.main.async { [weak self] in
            self?.isHidden = isHidden
        }
    }
    
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
    
    public func addSwitch(presenter: PagoSwitchPresenter) {
        
        let switchView = PagoSwitchView(presenter: presenter)
        switchView.isAccessibilityElement = false
        stackView.addArrangedSubview(switchView)
    }
    
    public func addInformative(presenter: PagoInformativePresenter) {
        
        let informativeView = PagoInformativeView(presenter: presenter)
        informativeView.isAccessibilityElement = false
        stackView.addArrangedSubview(informativeView)
    }
    
    public func addCheckBox(presenter: PagoCheckboxPresenter) {
        
        let checkBox = PagoCheckbox(presenter: presenter)
        checkBox.isAccessibilityElement = false
        stackView.addArrangedSubview(checkBox)
    }
    
    public func addLine(presenter: PagoLinePresenter) {
        
        let line = PagoLineView(presenter: presenter)
        line.isAccessibilityElement = false
        stackView.addArrangedSubview(line)
    }
    
    public func addButton(presenter: PagoButtonPresenter) {
        
        let button = PagoButton(presenter: presenter)
        button.isAccessibilityElement = false
        stackView.addArrangedSubview(button)
    }
    
    public func addSpace(presenter: PagoSpacePresenter) {
        
        let space = PagoSpaceView(presenter: presenter)
        stackView.addArrangedSubview(space)
    }
    
    public func addLabel(presenter: PagoLabelPresenter) {
        
        let label = PagoLabel(presenter: presenter)
        label.isAccessibilityElement = false
        stackView.addArrangedSubview(label)
    }
    
    public func addView(presenter: PagoSimpleViewPresenter) {
        
        let view = PagoSimpleView(presenter: presenter)
        view.isAccessibilityElement = false
        stackView.addArrangedSubview(view)
    }
    
    public func addField(presenter: PagoTextFieldPresenter) {
    
        let field = PagoTextField(presenter: presenter)
        field.isAccessibilityElement = false
        stackView.addArrangedSubview(field)
    }
    
    public func addLoadedImageView(presenter: PagoLoadedImageViewPresenter) {
        
        let imageView = PagoLoadedImageView(presenter: presenter)
        imageView.isAccessibilityElement = false
        stackView.addArrangedSubview(imageView)
    }
    
//    public func addImageView(presenter: PagoImageViewPresenter) {
//        
//        let imageView = PagoImageView(presenter: presenter)
//        imageView.isAccessibilityElement = false
//        stackView.addArrangedSubview(imageView)
//    }
    
    public func addAnimation(presenter: PagoAnimationPresenter) {
        
        let animation = PagoAnimationView(presenter: presenter)
        animation.isAccessibilityElement = false
        stackView.addArrangedSubview(animation)
    }
    
    public func addCircle(presenter: PagoCirclePresenter) {
        
        let circle = PagoCircleView(presenter: presenter)
        circle.isAccessibilityElement = false
        stackView.addArrangedSubview(circle)
    }
    
    public func addStackInfo(presenter: PagoStackedInfoPresenter) {
        
        let stack = PagoStackedInfoView(presenter: presenter)
        stackView.addArrangedSubview(stack)
    }
    
    public func addCountdownLabel(presenter: PagoLabelWCountdownPresenter) {
        
        let countdown = PagoLabelWCountdown(presenter: presenter)
        stackView.addArrangedSubview(countdown)
    }

    public func removeAllChildren() {
        
        stackView.removeAllPagoSubviews()
    }
}
