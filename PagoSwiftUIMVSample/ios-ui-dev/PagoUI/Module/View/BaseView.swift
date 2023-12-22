//
//  BaseView.swift
//  Pago
//
//  Created by Bogdan-Gabriel Chiosa on 17/02/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation


open class BaseView: PagoView, PresenterView {

    var gradientLayer: CAGradientLayer?
    
    public var presenter: BasePresenter!
    public func reloadView() {}
    
    open override func layoutSubviews() {
        
        super.layoutSubviews()
        gradientLayer?.frame = bounds
    }
    
    public func removeAllSubviews() {
        for v in subviews {
            v.removeFromSuperview()
        }
    }
    public func rotate(to angle: Double) {
        UIView.animate(withDuration: 0.5) {
            self.transform = CGAffineTransform(rotationAngle: angle)
        }
    }
}

//TODO: Use generics or protocol to avoid duplicate code
open class BaseCollectionViewCell: UICollectionViewCell, PresenterView {
    
    var presenter: BasePresenter!
    public func reloadView() {}

}

//TODO: Use generics or protocol to avoid duplicate code
open class BaseButton: UIButton, PresenterView {
    
    var presenter: BasePresenter!
    public func reloadView() {}

}

//TODO: Use generics or protocol to avoid duplicate code
open class BasePageControl: UIPageControl, PresenterView {
    
    var presenter: BasePresenter!
    public func reloadView() {}

}


public extension BaseView {

    class func fromNib(presenter: BasePresenter) -> Self {
        let view = fromNib()
        view.presenter = presenter
        return view
    }
}
//TODO: Use generics or protocol to avoid duplicate code
public extension BaseButton {

    class func fromNib(presenter: BasePresenter) -> Self {
        let view = fromNib()
        view.presenter = presenter
        return view
    }
}
//TODO: Use generics or protocol to avoid duplicate code
public extension BasePageControl {

    class func fromNib(presenter: BasePresenter) -> Self {
        let view = fromNib()
        view.presenter = presenter
        return view
    }
}
