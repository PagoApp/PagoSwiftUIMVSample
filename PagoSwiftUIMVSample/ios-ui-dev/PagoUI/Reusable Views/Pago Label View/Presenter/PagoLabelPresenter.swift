//
//  
//  PagoLabelPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit

public protocol PagoLabelPresenterDelegate: AnyObject {
    func didTap(label: PagoLabelPresenter)
    func didTap(url: String)
}

public extension PagoLabelPresenterDelegate {
    func didTap(url: String) {}
}

public protocol PagoLabelPresenterView: PresenterView {
    
    func hideView(isHidden: Bool)
}

open class PagoLabelPresenter: BasePresenter {

    public weak var delegate: PagoLabelPresenterDelegate?
    var text: String { return model.text }
    var imagePlaceholders: [PagoImagePlaceholderModel]? {
        return model.imagePlaceholders
    }
    var placeholders: [PagoPlaceholderModel]? { return model.placeholders }
    var model: PagoLabelModel {
        get { return (self.baseModel as! PagoLabelModel) }
        set { baseModel = newValue }
    }
    var hasAction: Bool { return model.hasAction }
    var style: PagoLabelStyle { return model.style }
    var accessibility: PagoAccessibility { return model.accessibility }
    private var view: PagoLabelPresenterView? { return basePresenterView as? PagoLabelPresenterView }
    
    public var isHidden: Bool = false {
        didSet {
            view?.hideView(isHidden: isHidden)
        }
    }
    
    public func update(text: String, style: PagoLabelStyle? = nil) {
        
        if let style = style {
            model.style = style
        }
        model.text = text
        view?.reloadView()
    }
    
    public func update(text: String, placeholders: [PagoPlaceholderModel]?) {
        model.text = text
        model.placeholders = placeholders
        view?.reloadView()
    }
    
    public override func update(model: Model) {
        
        super.update(model: model)
        view?.reloadView()
    }
    
    func handleTap() {
        
        delegate?.didTap(label: self)
    }

    public func didTap(url: String) {

         delegate?.didTap(url: url)
    }

}
