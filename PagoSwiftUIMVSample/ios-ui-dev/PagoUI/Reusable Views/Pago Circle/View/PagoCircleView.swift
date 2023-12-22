//
//  
//  PagoCircleView.swift
//  Pago
//
//  Created by Gabi Chiosa on 15/09/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import Foundation
import UIKit


class PagoCircleView: BaseView {
    
    private var circle: UIView!
    private var heightConstraint: NSLayoutConstraint!
    private var widthConstraint: NSLayoutConstraint!
    private var circleHeightConstraint: NSLayoutConstraint!
    private var circleWidthConstraint: NSLayoutConstraint!
    
    private var viewPresenter: PagoCirclePresenter { return (presenter as! PagoCirclePresenter) }
    
    
    public init(presenter: PagoCirclePresenter) {
       
        super.init(frame: .zero)
        setupUI()
        setup(presenter: presenter)
    }
    
    
    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
        setupUI()
    }
    
    public func setup(presenter: PagoCirclePresenter) {
    
        self.presenter = presenter
        presenter.setView(mView: self)
        presenter.loadData()
        
        circle.isAccessibilityElement = false
        isAccessibilityElement = presenter.accessibility.isAccessibilityElement
        accessibilityTraits = presenter.accessibility.accessibilityTraits
        accessibilityLabel = presenter.accessibility.accessibilityLabel
    }

    private func setupUI() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(circle)
        circle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        circle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        circle.layer.cornerRadius = 5
    }
}

extension PagoCircleView: PagoCirclePresenterView {
 
    internal func setup(style: PagoCircleStyle) {
        DispatchQueue.main.async { [weak self] in
                
            guard let self = self else { return }
            self.heightConstraint = self.heightAnchor.constraint(equalToConstant: style.viewSize.height)
            self.widthConstraint = self.widthAnchor.constraint(equalToConstant: style.viewSize.width)
            self.heightConstraint.isActive = true
            self.widthConstraint.isActive = true
            
            self.circleHeightConstraint = self.circle.heightAnchor.constraint(equalToConstant: style.circleRadius)
            self.circleWidthConstraint = self.circle.widthAnchor.constraint(equalToConstant: style.circleRadius)
            self.circleHeightConstraint.isActive = true
            self.circleWidthConstraint.isActive = true
            self.circle.layer.cornerRadius = style.circleRadius / 2
            self.circle.layer.backgroundColor = UIColor.Pago.lightGrayInactive.cgColor
        }
    }
    
    internal func update(style: PagoUpdateStyle, animName: String, animationTime: Double, completion: ((Bool)->())?) {
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: animationTime, delay: 0, options: .curveEaseIn, animations: { [weak self] in
                
                guard let self = self else { return }
                
                var animations = [CAAnimation]()
                if let values = style.updates {
                    let scaleUp = CAKeyframeAnimation(keyPath: "transform.scale")
                    scaleUp.values = values
                    animations.append(scaleUp)
                }
                
                let colorAnimation:CABasicAnimation = CABasicAnimation(keyPath: "backgroundColor")
                colorAnimation.toValue = style.tintColorType.cgColor
                colorAnimation.isRemovedOnCompletion = false
                colorAnimation.fillMode = CAMediaTimingFillMode.forwards
                animations.append(colorAnimation)
                
                let shakeGroup: CAAnimationGroup = CAAnimationGroup()
                shakeGroup.animations = animations
                shakeGroup.duration = CFTimeInterval(style.duration)
                shakeGroup.isRemovedOnCompletion = false
                shakeGroup.fillMode = CAMediaTimingFillMode.forwards
                self.circle.layer.add(shakeGroup, forKey: animName)
                
                self.layoutIfNeeded()
                
            }, completion: completion)
        }
        
    }
}
