//
//  
//  PagoBaseAlertViewController.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

public class PagoBaseAlertViewController: BaseViewController {
    
    var scrollView: PagoScrollView!
    var stackView: PagoStackView!
    var fakeBg: UIView!
    var contentHeightView: UIView!
    var transparentView: UIView!
    private var fakeBgTopConstraint: NSLayoutConstraint!
    
    private var presenter: PagoBaseAlertPresenter {
        return basePresenter as! PagoBaseAlertPresenter
    }
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        let margins = view.layoutMarginsGuide

        scrollView = PagoScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        scrollView.topAnchor.constraint(greaterThanOrEqualTo: margins.topAnchor, constant: 42).isActive = true
        scrollView.backgroundColor = .clear
        
        stackView = PagoStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        stackView.backgroundColor = .clear
        
        contentHeightView = PagoView()
        contentHeightView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contentHeightView)
        contentHeightView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        contentHeightView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contentHeightView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        contentHeightView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentHeightView.heightAnchor.constraint(equalTo: stackView.heightAnchor).isActive = true
        contentHeightView.backgroundColor = .clear
        
        transparentView = UIView()
        transparentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(transparentView)
        transparentView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        transparentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        transparentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        transparentView.bottomAnchor.constraint(equalTo: contentHeightView.topAnchor).isActive = true
        transparentView.backgroundColor = .clear
        
        fakeBg = UIView()
        fakeBg.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(fakeBg)
        fakeBg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fakeBg.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        fakeBg.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        let fakeBgTopAnchor = fakeBg.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40)
        fakeBgTopAnchor.isActive = true
        self.fakeBgTopConstraint = fakeBgTopAnchor
        fakeBg.backgroundColor = .white
        
        view.bringSubviewToFront(scrollView)
        
        scrollView.clipsToBounds = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissScreen))
        transparentView.addGestureRecognizer(tapRecognizer)
    }

    public override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        UIView.animate(withDuration: presenter.backgroundAnimationTime) { [weak self] in
            self?.view.backgroundColor = self?.presenter.backgroundColor.color
        }
    }
    
    @objc func dismissScreen() {

        dismissWithAnimation { [weak self] in
            self?.presenter.dismiss()
        }
    }
    
    func dismissWithAnimation(completion: @escaping ()->()) {
        
        let completionHandler: (Bool)->() = { (_) in
            completion()
        }
        let animation: ()->() = { [weak self] in
            self?.view.backgroundColor = .clear
            self?.scrollView.setContentOffset(CGPoint(x: 0, y: 50), animated: true)
        }
        UIView.animate(withDuration: 0.2, animations: animation, completion: completionHandler)
    }
}

extension PagoBaseAlertViewController: PagoBaseAlertPresenterView {
    
    public func dismissBackground(completion: @escaping () -> ()) {
        
        dismissWithAnimation(completion: completion)
    }
    
    public func setupTopHeader() {
        let smallRoundedView = UIView()
        smallRoundedView.translatesAutoresizingMaskIntoConstraints = false
        smallRoundedView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        smallRoundedView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        smallRoundedView.layer.cornerRadius = 4
        smallRoundedView.backgroundColor = UIColor.Pago.dividers.color
        
        let topRounded = UIView()
        topRounded.layer.cornerRadius = 12
        topRounded.heightAnchor.constraint(equalToConstant: 20).isActive = true
        topRounded.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomSquare = UIView()
        bottomSquare.translatesAutoresizingMaskIntoConstraints = false
        topRounded.addSubview(bottomSquare)
        bottomSquare.heightAnchor.constraint(equalTo: topRounded.heightAnchor, multiplier: 0.5).isActive = true
        bottomSquare.centerXAnchor.constraint(equalTo: topRounded.centerXAnchor).isActive = true
        bottomSquare.topAnchor.constraint(equalTo: topRounded.centerYAnchor).isActive = true
        bottomSquare.widthAnchor.constraint(equalTo: topRounded.widthAnchor).isActive = true
        
        topRounded.backgroundColor = .white
        bottomSquare.backgroundColor = .white
        
        topRounded.addSubview(smallRoundedView)
        smallRoundedView.topAnchor.constraint(equalTo: topRounded.topAnchor, constant: 8).isActive = true
        smallRoundedView.centerXAnchor.constraint(equalTo: topRounded.centerXAnchor).isActive = true
        
        stackView.insertArrangedSubview(topRounded, at: 0)
    }
    
    public func resetBackground(colorType: UIColor.Pago, animationTime: Double) {
        UIView.animate(withDuration: animationTime) { [weak self] in
            self?.view.backgroundColor = colorType.color
        }
    }
}

extension PagoBaseAlertViewController {

    public override func scrollViewDidScroll(_ scrollView: UIScrollView) {

        super.scrollViewDidScroll(scrollView)
        
        guard scrollView == self.scrollView else { return }
        let offset = Float(scrollView.contentOffset.y)
        fakeBgTopConstraint.constant = CGFloat(-offset + 40)
        guard scrollView.isDragging else { return }
        if offset < 0 {
            let percent = min(abs(offset) / 50, 1)
            let value = CGFloat(0.5)
            let t: CGFloat = value - (CGFloat(percent) * value)
            view.backgroundColor = UIColor.Pago.blackWithAlpha(t).color
        }
    }

    public override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        super.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
        
        guard scrollView == self.scrollView else { return }
        presenter.dismissView(offset: scrollView.contentOffset.y)
    }

    public override func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {

        guard scrollView == self.scrollView else { return }
        super.scrollViewWillBeginDecelerating(scrollView)
    }

    public override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        super.scrollViewDidEndDecelerating(scrollView)
        guard scrollView == self.scrollView else { return }
        presenter.dismissView(offset: scrollView.contentOffset.y)
    }
}
