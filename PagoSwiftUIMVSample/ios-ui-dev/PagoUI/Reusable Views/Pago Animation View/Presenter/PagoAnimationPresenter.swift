//
//  
//  PagoAnimationPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import Foundation
import UIKit

public protocol PagoAnimationPresenterView: PresenterView {
   
    func setup(animation: String, bundle: Bundle?)
    func setup(animation: PagoBackendAnimation)
    func play()
    func stop()
}

open class PagoAnimationPresenter: BasePresenter {

    public var model: PagoLoadedAnimationModel { return (self.baseModel as! PagoLoadedAnimationModel) }
    public var style: PagoAnimationStyle { return model.style }
    public var loop: Bool { return model.loop }
    public var accessibility: PagoAccessibility { return model.accessibility }
    private(set) var isAnimating: Bool = false
    private var view: PagoAnimationPresenterView? { return basePresenterView as? PagoAnimationPresenterView }
    
    internal func loadData() {
        
        switch model.animationType {
        case is PagoBackendAnimation:
            let animationUrl: String = (model.animationType as! PagoBackendAnimation).url
            let animationPlaceholder: UIImage.PagoAnimation = (model.animationType as! PagoBackendAnimation).placeholder
            let animation = PagoBackendAnimation(url: animationUrl, placeholder: animationPlaceholder)
            view?.setup(animation: animation)
        case is PagoDataAnimation:
            let model = model.animationType as! PagoDataAnimation
            view?.setup(animation: model.animation.rawValue, bundle: model.bundle)
        default:
            break
        }
    }
    
    public override func update(model: Model) {
        
        super.update(model: model)
        view?.reloadView()
        loadData()
    }
    
    public func play() {
        
        isAnimating = true
        view?.play()
    }
    
    public func stop() {
        
        isAnimating = false
        view?.stop()
    }
}
