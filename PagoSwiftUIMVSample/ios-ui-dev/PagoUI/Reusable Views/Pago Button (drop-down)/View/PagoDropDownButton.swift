//
//  
//  PagoDropDownButtonView.swift
//  Pago
//
//  Created by Gabi Chiosa on 20/07/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation

public protocol PagoDropDownButtonDelegate: AnyObject {
    func dropDownDidAppear()
    func dropDownDidSelect(index: Int)
}

open class PagoDropDownButton: BaseView {
    
    enum State {
        case collapsed, expanded
    }
    private var bgHeightConstraint: NSLayoutConstraint!
    private var bgWidthConstraint: NSLayoutConstraint!
    private var bgView: UIView!
    private var optionsHolderHeightConstraint: NSLayoutConstraint!
    private var optionsHolderTopConstraint: NSLayoutConstraint!
    private var buttons: [UIButton]!
    private var currentState = State.collapsed
    public weak var delegate: PagoDropDownButtonDelegate?
    var viewPresenter: PagoDropDownButtonPresenter! {
        return (presenter as! PagoDropDownButtonPresenter)
    }
        
    override public func reloadView() {
        
        setup()
    }
    
    public init(presenter: PagoButtonPresenter) {
        
        super.init(frame: .zero)
        self.presenter = presenter
        setup()
    }

    override public  init(frame: CGRect) {
        
        super.init(frame: frame)
        setup()
    }

    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    public func setup(presenter: PagoDropDownButtonPresenter) {
        
        self.presenter = presenter
        setup()
    }
    
    public func dismiss() {
        
        guard currentState == .expanded else { return }
        let button = buttons[viewPresenter.selectedIndex]
        button.isSelected = true
        buttons.filter({$0 != button}).forEach({$0.isSelected = false})
        collapse()
    }
    
    private func setup() {
        
        viewPresenter.setView(mView: self)
        setupUI()
    }
    
    @objc private func handleTap(_ button: UIButton) {
        
        let index = button.tag
        switch currentState {
        case .collapsed:
            delegate?.dropDownDidAppear()
            expand()
        case .expanded:
            delegate?.dropDownDidSelect(index: index)
            button.isSelected = true
            buttons.filter({$0 != button}).forEach({$0.isSelected = false})
            viewPresenter.select(index: index)
            collapse()
        }
    }
    
    private func expand(animated: Bool = true) {
                
        currentState = .expanded
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let duration = animated ? self.viewPresenter.style.animationSpeed : 0
            UIView.animate(withDuration: duration) {
                self.bgHeightConstraint.constant = CGFloat(self.viewPresenter.optionsExpandedHeight)
                self.bgWidthConstraint.constant = CGFloat(self.viewPresenter.style.optionExpandedWidth)
                self.bgView.layer.cornerRadius = CGFloat(self.viewPresenter.style.cornerRadiusExpanded)
                self.optionsHolderHeightConstraint.constant = CGFloat(self.viewPresenter.optionsExpandedHeight)
                self.optionsHolderTopConstraint.constant = 0
                self.buttons.filter({$0.tag != self.viewPresenter.selectedIndex}).forEach({$0.alpha = 1})
                self.layoutIfNeeded()
            }
        }
    }
        
    private func collapse(animated: Bool = true) {
        
        currentState = .collapsed
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let duration = animated ? self.viewPresenter.style.animationSpeed : 0
            UIView.animate(withDuration: duration) {
                self.bgHeightConstraint.constant = CGFloat(self.viewPresenter.style.optionHeight)
                self.bgWidthConstraint.constant = CGFloat(self.viewPresenter.style.optionWidth)
                self.bgView.layer.cornerRadius = CGFloat(self.viewPresenter.style.cornerRadius)
                self.optionsHolderHeightConstraint.constant = CGFloat(self.viewPresenter.optionsCollapsedHeight)
                self.optionsHolderTopConstraint.constant = CGFloat(self.viewPresenter.optionsPositionY)
                self.buttons.filter({$0.tag != self.viewPresenter.selectedIndex}).forEach({$0.alpha = 0})
                self.layoutIfNeeded()
            }
        }
    }
        
    private func setupUI() {

        // the UI has this format:
        // UIView[UIStackView[UIButton, UIButton, UIButton ...]]
        // when user taps a button, we animate the stackview to center the
        // selected option
        
        backgroundColor = UIColor.Pago.clear.color
        bgView = UIView()
        bgView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bgView)
        bgHeightConstraint = bgView.heightAnchor.constraint(equalToConstant: CGFloat(viewPresenter.style.optionHeight))
        bgHeightConstraint.isActive = true
        bgWidthConstraint = bgView.widthAnchor.constraint(equalToConstant: CGFloat(viewPresenter.style.optionWidth))
        bgWidthConstraint.isActive = true
        bgView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bgView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bgView.backgroundColor = UIColor.Pago.lightBlueBackground.color
        bgView.layer.cornerRadius = CGFloat(viewPresenter.style.optionWidth / 2)
        bgView.clipsToBounds = true
        
        let viewsHolder = PagoStackView()
        viewsHolder.distribution = .fillEqually
        viewsHolder.axis = .vertical
        viewsHolder.translatesAutoresizingMaskIntoConstraints = false
        bgView.addSubview(viewsHolder)
        optionsHolderTopConstraint = viewsHolder.topAnchor.constraint(equalTo: bgView.topAnchor)
        optionsHolderTopConstraint.isActive = true
        viewsHolder.widthAnchor.constraint(equalToConstant: CGFloat(viewPresenter.style.optionWidth)).isActive = true
        viewsHolder.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        optionsHolderHeightConstraint = viewsHolder.heightAnchor.constraint(equalToConstant: CGFloat(viewPresenter.optionsCollapsedHeight))
        optionsHolderHeightConstraint.isActive = true
        
        buttons = [UIButton]()
        for i in 0..<viewPresenter.options {
            let button = UIButton()
            buttons.append(button)
            button.addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
            button.tag = i
            button.titleLabel?.font = viewPresenter.style.optionFont.font
            button.setTitleColor(viewPresenter.style.optionColor.color, for: .normal)
            button.setTitleColor(viewPresenter.style.highlightedOptionColor.color, for: .highlighted)
            button.setTitleColor(viewPresenter.style.selectedOptionColor.color, for: .selected)
            button.setTitle(viewPresenter.title(at: i), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            viewsHolder.addArrangedSubview(button)
            button.leadingAnchor.constraint(equalTo: viewsHolder.leadingAnchor).isActive = true
            button.trailingAnchor.constraint(equalTo: viewsHolder.trailingAnchor).isActive = true

            // overwrite the height/width constraints to allow tap on the max
            // drawn area
            if let heightConstraint = self.constraints.first(where: {$0.firstAttribute == .height && $0.relation == .equal}) {
                heightConstraint.constant = CGFloat(viewPresenter.optionsExpandedHeight)
            }
            
            if let widthConstraint = self.constraints.first(where: {$0.firstAttribute == .width && $0.relation == .equal}) {
                widthConstraint.constant = CGFloat(viewPresenter.style.optionExpandedWidth)
            }
        }
        buttons[viewPresenter.selectedIndex].isSelected = true
        collapse(animated: false)
    }
}
