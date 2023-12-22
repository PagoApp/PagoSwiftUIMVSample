//
//
//  PagoTextPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 13/05/2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//
import UIKit

public protocol PagoTextViewPresenterView: PresenterView {

    func hidePlaceholder()
    func showPlaceholder()
    func focusTextView()
    func setupUI(hasCounter: Bool)
    func setup(style: PagoTextViewStyle)
    func setup(width: CGFloat)
    func setup(height: CGFloat)
    func setup(counter: PagoLabelPresenter)
    func setup(placeholder: PagoLabelPresenter)
    func didLayoutView()
}

public protocol PagoTextViewPresenterDelegate: AnyObject {
    
    func textViewPresenterDidUpdate(presenter: PagoTextViewPresenter, text: String)
}

//TODO(QSA): Add text view limit exceeded style
//TODO(QSA): Add accessibility
open class PagoTextViewPresenter: BasePresenter {

    weak var delegate: PagoTextViewPresenterDelegate?
    public var text: String? { return model.text }
    lazy var placeholderPresenter: PagoLabelPresenter? = {
        
        if let labelModel = model.placeholder {
            let presenter = PagoLabelPresenter(model: labelModel)
            return presenter
        }
        return nil
    }()
    
    lazy var counterPresenter: PagoLabelPresenter? = {
        
        if model.style.showsCounter {
            let counterString = counterText
            let counterModel = PagoLabelModel(text: counterString, style: model.style.counterStyle)
            return PagoLabelPresenter(model: counterModel)
        } else {
            return nil
        }
    }()
    
    var model: PagoTextViewModel {
        get { return (self.baseModel as! PagoTextViewModel) }
        set { baseModel = newValue }
    }
    var style: PagoTextViewStyle { return model.style }
    var accessibility: PagoAccessibility { return model.accessibility }
    private var view: PagoTextViewPresenterView? { return basePresenterView as? PagoTextViewPresenterView}
    private var limit: Int { return model.textLimit }
    
    func loadData() {
        
        view?.setupUI(hasCounter: style.showsCounter)
        view?.setup(style: style)

        if let width = style.width {
            view?.setup(width: width)
        }
        
        if let height = style.height {
            view?.setup(height: height)
        }
        
        if let placeholder = placeholderPresenter {
            view?.setup(placeholder: placeholder)
        }
        
        if style.showsCounter, let counter = counterPresenter {
            view?.setup(counter: counter)
        }
    }
    
    func update(text: String) {
        
        guard canUpdate(text: text) else {
            return
        }
        model.text = text
        delegate?.textViewPresenterDidUpdate(presenter: self, text: text)
        counterPresenter?.update(text: counterText)
    }
    
    func canUpdate(text: String) -> Bool {
        
        let canUpdate = text.count <= limit
        return canUpdate
    }
    
    var counterText: String {
        
        let counterText = model.counterFormat
        let counterString = String.init(format: counterText, (text ?? "").count, limit)
        return counterString
    }

    func stopEditing() {
        
        if (text ?? "").isEmpty {
            view?.showPlaceholder()
        }
    }
    
    func startEditing() {
        
        if (text ?? "").isEmpty {
            view?.hidePlaceholder()
        }
        view?.focusTextView()
    }

    
    public override func update(model: Model) {
        
        super.update(model: model)
        view?.reloadView()
    }
    
    public func didLayoutView() {
        
        view?.didLayoutView()
    }
}
