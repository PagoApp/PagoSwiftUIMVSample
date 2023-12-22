//
//  
//  PagoImagePresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

public protocol PagoSimpleViewPresenterDelgate: AnyObject {
    
    func didTap(presenter: PagoSimpleViewPresenter)
}

public protocol PagoSimpleViewPresenterView: PresenterView {
    
    func reloadStyle(isTouching: Bool)
    func setupView(style: PagoSimpleViewStyle)
    func hide(isHidden: Bool)
}

open class PagoSimpleViewPresenter: BasePresenter {

    public var isHidden: Bool = false {
        didSet {
            view?.hide(isHidden: isHidden)
        }
    }
    var model: PagoSimpleViewModel { return (self.baseModel as! PagoSimpleViewModel) }
    var accessibility: PagoAccessibility { return model.accessibility }
    private var view: PagoSimpleViewPresenterView? { return basePresenterView as? PagoSimpleViewPresenterView}
    
    public weak var delegate: PagoSimpleViewPresenterDelgate?
    var hasUserInteraction: Bool { return model.hasAction }
    var isTouching: Bool = false

    
    func loadData() {
        
        view?.setupView(style: model.style)
        
    }
    
    func handleTap() {
        
        delegate?.didTap(presenter: self)
    }
    
    func didTap() {
        
        touchUp()
        delegate?.didTap(presenter: self)
    }
    
    func touchUp() {
        
        isTouching = false
        view?.reloadStyle(isTouching: false)
    }
    
    func touchDown() {
        
        isTouching = true
        view?.reloadStyle(isTouching: true)
    }
}
