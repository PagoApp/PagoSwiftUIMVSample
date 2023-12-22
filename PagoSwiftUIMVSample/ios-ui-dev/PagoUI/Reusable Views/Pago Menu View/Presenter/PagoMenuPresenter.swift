//
//  
//  PagoMenuButtonPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 07/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

public protocol PagoMenuPresenterView: PresenterView {
    func setup(buttons: [PagoButtonPresenter])
    func setupLineSelection()
    func setupBackgroundSelection(bg: UIColor.Pago, selection: UIColor.Pago)
    func selectButton(index: Int, animated: Bool)
}

public protocol PagoMenuPresenterDelegate: AnyObject {
    func menuDidSelectSelected(index: Int)
    func menuDidSelect(index: Int, previousIndex: Int)
}


open class PagoMenuPresenter: BasePresenter {
    
    @available(*, deprecated, message: "This will be removed. underlined option will continue to be without customisable style until we add it")
    public var inactiveColorType: UIColor.Pago {
        return model.style.inactiveSelectionColorType
    }
    @available(*, deprecated, message: "This will be removed. underlined option will continue to be without customisable style until we add it")
    public var activeColorType: UIColor.Pago {
        return model.style.activeSelectionColorType
    }
    @available(*, deprecated, message: "This will be removed. underlined option will continue to be without customisable style until we add it")
    public var selectionWidth: Double {
        return Double(width / Double(model.buttons.count))
    }
    @available(*, deprecated, message: "This will be removed. underlined option will continue to be without customisable style until we add it")
    public var buttonWidthPercentage: Double {
        return 1.0/Double(model.buttons.count)
    }
    
    public weak var delegate: PagoMenuPresenterDelegate?
    
    public var model: PagoMenuModel {
       return (self.baseModel as! PagoMenuModel)
    }
    
    public var buttonsCount: Int {
        return model.buttons.count
    }
    public var insets: UIEdgeInsets {
        return model.style.insets
    }
    
    public var backgroundColor: UIColor.Pago {
        if menuType == .background {
            return repository.backgroundColor(for: menuType)
        } else {
            return model.style.backgroundColor
        }
    }
    
    public var width: Double {
        let screenWidth = UIScreen.main.bounds.width
        return screenWidth - insets.left - insets.right
    }

    public var selectedIndex = 0
    public var isEnabled: Bool = true
    
    internal var menuType: PagoMenuType {
        self.model.style.type
    }
    
    private let repository = PagoMenuRepository()
    private var view: PagoMenuPresenterView? { return basePresenterView as? PagoMenuPresenterView }
    private var buttons = [PagoButtonPresenter]()
    
    public func loadData() {
        
        
        //TODO: After we allow customisation for the nav bar will remove the if else
        if menuType == .background {
            let buttonModels = repository.buttonModels(from: model.buttons, type: menuType, selectedIndex: 0)
            let bgColor = repository.backgroundColor(for: menuType)
            let indicatorColor = repository.indicatorColor(for: menuType)
            buttons = buttonModels.map({PagoButtonPresenter(model: $0)})
            buttons.forEach({$0.delegate = self})
            view?.setup(buttons: buttons)
            view?.setupBackgroundSelection(bg: bgColor, selection: indicatorColor)
            
        } else {
            @available(*, deprecated, message: "This will be dropped when we update the UI Config JSON file to support customisation for the underlined navigation style")
            let buttonModels = repository.buttonModels(from: model.buttons)
            buttons = buttonModels.map({PagoButtonPresenter(model: $0)})
            buttons.forEach({$0.delegate = self})
            view?.setup(buttons: buttons)
            view?.setupLineSelection()
        }

        
    }

    public func select(index: Int) {
        
        guard isInBounds(source: buttons, index: index) else { return }
        let button = buttons[index]
        didTap(button: button, animated: false)
    }

    public func button(at index: Int) -> PagoButtonPresenter? {
        
        guard isInBounds(source: buttons, index: index) else { return nil }
        return buttons[index]
    }
    
    public func updateTitle(at index: Int, text: String) {
        
        guard let button = button(at: index) else { return }
        button.update(title: text)
    }
    
    private func didTap(button: PagoButtonPresenter, animated: Bool = true) {
        
        guard selectedIndex != button.index else {
            delegate?.menuDidSelectSelected(index: button.index)
            return
        }
        updatePreviousSelected(at: selectedIndex)
        updateSelected(at: button.index)
        view?.selectButton(index: button.index, animated: true)
        delegate?.menuDidSelect(index: button.index, previousIndex: selectedIndex)
        selectedIndex = button.index
    }
    
    internal func updatePreviousSelected(at index: Int) {
        
        guard isInBounds(source: buttons, index: index) else { return }
        let buttonPresenter = buttons[index]
        let deselectedStyle = repository.getButtonStyle(for: menuType, selected: false)
        buttonPresenter.update(buttonStyle: deselectedStyle)
    }
    
    internal func updateSelected(at index: Int) {
        
        guard isInBounds(source: buttons, index: index) else { return }
        let buttonPresenter = buttons[index]
        let selectedStyle = repository.getButtonStyle(for: menuType, selected: true)
        buttonPresenter.update(buttonStyle: selectedStyle)
    }
}

extension PagoMenuPresenter: PagoButtonPresenterDelegate {
    
    public func didTap(button: PagoButtonPresenter) {
        
        guard isEnabled else { return }
        didTap(button: button, animated: true)
    }
}
