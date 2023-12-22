//
//  
//  PagoCirclePresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 15/09/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

public protocol PagoCirclePresenterView: PresenterView {
    func setup(style: PagoCircleStyle)
    func update(style: PagoUpdateStyle, animName: String, animationTime: Double, completion: ((Bool)->())?)
}

open class PagoCirclePresenter: BasePresenter {

    internal var style: PagoCircleStyle { return model.style }
    
    internal var model: PagoCircleModel {
        return (self.baseModel as! PagoCircleModel)
    }
    internal var accessibility: PagoAccessibility { return model.accessibility }
    internal let animationTime = 0.15
    
    private var view: PagoCirclePresenterView? { return (basePresenterView as? PagoCirclePresenterView) }

    internal func loadData() {
        
        view?.setup(style: style)
        update(style: .normal, animated: false)
    }
    
    public func update(style: PagoCircleStyleType, animated: Bool, completion: @escaping (Bool)->() = {_ in}) {
        
        let time = animated ? animationTime : 0
        switch style {
        case .error:
            view?.update(style: model.errorStyle, animName: style.rawValue, animationTime: time, completion: completion)
        case .filled:
            view?.update(style: model.highlightStyle, animName: style.rawValue, animationTime: time, completion: completion)
        case .normal:
            view?.update(style: model.defaultStyle, animName: style.rawValue, animationTime: time, completion: completion)
        case .verified:
            view?.update(style: model.verifiedStyle, animName: style.rawValue, animationTime: time, completion: completion)
        }
    }

}
