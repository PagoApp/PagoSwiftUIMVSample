//
//
//  PagoEmptyListScreenPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 11.11.2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//

public protocol PagoEmptyListScreenPresenterView: PresenterView {
    
    func setup(stack: PagoStackedInfoPresenter)
    func setupToTop(stack: PagoStackedInfoPresenter)
    func setupToBottom(action: PagoButtonPresenter)
    func show()
    func hide()
}

public protocol PagoEmptyListScreenPresenterDelegate: AnyObject {
    
    func didTapEmptyListAction()
}
public class PagoEmptyListScreenPresenter: BasePresenter {
    
    public weak var delegate: PagoEmptyListScreenPresenterDelegate?
    var model: PagoEmptyListScreenModel {
        get { (self.baseModel as! PagoEmptyListScreenModel) }
        set { baseModel = newValue }
    }
    
    private var view: PagoEmptyListScreenPresenterView? { return basePresenterView as? PagoEmptyListScreenPresenterView }
    private var topStack: PagoStackedInfoPresenter?
    private var actionButton: PagoButtonPresenter?
    private var stackContainer: PagoStackedInfoPresenter!
    
    public func loadData() {
        
        stackContainer = PagoStackedInfoPresenter(model: model.contentStack)
        
        if let topModel = model.topStack {
            topStack = PagoStackedInfoPresenter(model: topModel)
        }
        
        if let actionModel = model.actionModel {
            actionButton = PagoButtonPresenter(model: actionModel)
            actionButton?.delegate = self
        }
        
        view?.setup(stack: stackContainer)
    }
    
    
    /// If main button position == .bottom the bottom stack will stick to the content
    /// Else the bottom stack will stick to the bottom of the button
    /// The top stack will be always at the top of the parent view
    public func setupActionView() {
        
        if let topStack = topStack {
            view?.setupToTop(stack: topStack)
        }
        
        if let actionButton = actionButton {
            if model.actionPosition == .bottom {
                view?.setupToBottom(action: actionButton)
            } else {
                let space40 = model.getEmptyModel(height: 40)
                let spacePresenter = PagoSimpleViewPresenter(model: space40)
                stackContainer.addView(presenter: spacePresenter)
                stackContainer.addButton(presenter: actionButton)
            }
        }
        
        if let bottomStack = model.bottomStack {
            let bottomPresenter = PagoStackedInfoPresenter(model: bottomStack)
            stackContainer.addInfoStack(presenter: bottomPresenter)
        }
    }
    
    public func show() {
        
        topStack?.isHidden = false
        actionButton?.isHidden = false
        view?.show()
    }
    
    public func hide() {
        
        topStack?.isHidden = true
        actionButton?.isHidden = true
        view?.hide()
    }
    
    public var extraButtons: [PagoButtonPresenter] {
        
        return stackContainer.buttonsPresenters
    }
}

extension PagoEmptyListScreenPresenter: PagoButtonPresenterDelegate {
    
    public func didTap(button: PagoButtonPresenter) {
        
        delegate?.didTapEmptyListAction()
    }
}



