//
//  
//  PagoStackedInfoPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

public protocol PagoStackedInfoPresenterView: PresenterView {
    
    func reloadStyle(isTouching: Bool)
    func addLoadedImageView(presenter: PagoLoadedImageViewPresenter)
    func addLabel(presenter: PagoLabelPresenter)
    func addSwitch(presenter: PagoSwitchPresenter)
    func addMenu(presenter: PagoMenuPresenter)
    func addInformative(presenter: PagoInformativePresenter)
    func addField(presenter: PagoTextFieldPresenter)
    func addButton(presenter: PagoButtonPresenter)
    func addAnimation(presenter: PagoAnimationPresenter)
    func addCircle(presenter: PagoCirclePresenter)
    func addCheckBox(presenter: PagoCheckboxPresenter)
    func addSpace(presenter: PagoSpacePresenter)
    func addCountdownLabel(presenter: PagoLabelWCountdownPresenter)
    func addView(presenter: PagoSimpleViewPresenter)
    func addStackInfo(presenter: PagoStackedInfoPresenter)
    func addPageController(presenter: PagoPageControllerPresenter)

    func removeAllChildren()
    func hideView(isHidden: Bool)
}

public protocol PagoStackedInfoPresenterDelegate: AnyObject {
    func didTap(presenter: PagoStackedInfoPresenter)
}

open class PagoStackedInfoPresenter: BasePresenter {

    public weak var delegate: PagoStackedInfoPresenterDelegate?

    public var model: PagoStackedInfoModel {
        get { return (self.baseModel as! PagoStackedInfoModel) }
        set { baseModel = newValue }
    }
    public var index: Int? { return model.index }
    public var style: PagoStackedInfoStyle { return model.style }
    public var childPresenters = [BasePresenter]()
    public var isTouching: Bool = false
    public var hasUserInteraction: Bool { return model.hasAction }
    public var accessibility: PagoAccessibility {
        get { return model.accessibility }
        set { model.accessibility = newValue }
    }
    
    public var buttonsPresenters: [PagoButtonPresenter] {
        
        var buttons = [PagoButtonPresenter]()
        for child in childPresenters {
            if let stackChild = child as? PagoStackedInfoPresenter {
                buttons.append(contentsOf: getButtonFromStack(stackChild))
            }
            if let button = child as? PagoButtonPresenter {
                buttons.append(button)
            }
        }
        return buttons
    }
    
    private var view: PagoStackedInfoPresenterView? { return (basePresenterView as? PagoStackedInfoPresenterView) }
    
    internal func loadData() {
        
        for childModel in model.models {
            if childModel is PagoLabelModel {
                let labelPresenter = PagoLabelPresenter(model: childModel)
                addLabel(presenter: labelPresenter)
            } else if childModel is PagoCheckboxModel {
                let checkBoxPresenter = PagoCheckboxPresenter(model: childModel)
                addCheckBox(presenter: checkBoxPresenter)
            } else if childModel is PagoLoadedAnimationModel {
                let animationPresenter = PagoAnimationPresenter(model: childModel)
                addAnimation(presenter: animationPresenter)
            } else if childModel is PagoCircleModel {
                let circlePresenter = PagoCirclePresenter(model: childModel)
                addCircle(presenter: circlePresenter)
            } else if childModel is PagoLoadedImageViewModel {
                let imagePresenter = PagoLoadedImageViewPresenter(model: childModel)
                addLoadedImage(presenter: imagePresenter)
            } else if childModel is PagoStackedInfoModel {
                let childPresenter = PagoStackedInfoPresenter(model: childModel)
                addInfoStack(presenter: childPresenter)
            } else if childModel is PagoSimpleViewModel {
                let childPresenter = PagoSimpleViewPresenter(model: childModel)
                addView(presenter: childPresenter)
            } else if let childModel = childModel as? PagoTextFieldModel {
                let childPresenter = PagoTextFieldPresenter(model: childModel) { (_) -> (Bool) in
                    return true
                }
                childPresenter.isValid = true
                addField(presenter: childPresenter)
            } else if childModel is PagoButtonModel {
                let childPresenter = PagoButtonPresenter(model: childModel)
                addButton(presenter: childPresenter)
            } else if childModel is PagoSpaceModel {
                let childPresenter = PagoSpacePresenter(model: childModel)
                addSpace(presenter: childPresenter)
            } else if let model = childModel as? PagoLabelWCountdownModel {
                let childPresenter = PagoLabelWCountdownPresenter(model: model)
                addCountdownLabel(presenter: childPresenter)
            } else if let model = childModel as? PagoSwitchModel {
                let childPresenter = PagoSwitchPresenter(model: model)
                addSwitch(presenter: childPresenter)
            } else if let model = childModel as? PagoInformativeModel {
                let childPresenter = PagoInformativePresenter(model: model)
                addInformative(presenter: childPresenter)
            } else if let model = childModel as? PagoMenuModel {
                let childPresenter = PagoMenuPresenter(model: model)
                addMenu(presenter: childPresenter)
            } else if let model = childModel as? PagoPageControllerModel {
                let childPresenter = PagoPageControllerPresenter(model: model)
                addPageController(presenter: childPresenter)
            }
            
        }
    }
    
    public override func update(model: Model) {
        
        super.update(model: model)
        view?.reloadView()
    }
    
    public func removeAllChildren() {
        
        view?.removeAllChildren()
    }
    
    public var isHidden: Bool = false {
        didSet {
            view?.hideView(isHidden: isHidden)
        }
    }
    
    public func addSwitch(presenter: PagoSwitchPresenter) {
    
        childPresenters.append(presenter)
        view?.addSwitch(presenter: presenter)
    }
    
    public func addMenu(presenter: PagoMenuPresenter) {
    
        childPresenters.append(presenter)
        view?.addMenu(presenter: presenter)
    }
    
    public func addInformative(presenter: PagoInformativePresenter) {
    
        childPresenters.append(presenter)
        view?.addInformative(presenter: presenter)
    }
    
    public func addCountdownLabel(presenter: PagoLabelWCountdownPresenter) {
    
        childPresenters.append(presenter)
        view?.addCountdownLabel(presenter: presenter)
    }
    
    public func addLabel(presenter: PagoLabelPresenter) {
        
        childPresenters.append(presenter)
        view?.addLabel(presenter: presenter)
    }
    
#warning("Remove Pago Line. Use only Pago Simple View")
//    public func addLine(presenter: PagoLinePresenter) {
//
//        childPresenters.append(presenter)
//        view?.addLine(presenter: presenter)
//    }
    
    #warning("Remove Pago Image. Use only Pago loaded image")
//    public func addImageView(presenter: PagoImageViewPresenter) {
//
//        childPresenters.append(presenter)
//        view?.addImageView(presenter: presenter)
//    }
    
    public func addAnimation(presenter: PagoAnimationPresenter) {
        
        childPresenters.append(presenter)
        view?.addAnimation(presenter: presenter)
    }
    
    public func addCheckBox(presenter: PagoCheckboxPresenter) {
        
        childPresenters.append(presenter)
        view?.addCheckBox(presenter: presenter)
    }
    
    public func addCircle(presenter: PagoCirclePresenter) {
        
        childPresenters.append(presenter)
        view?.addCircle(presenter: presenter)
    }
    
    public func addLoadedImage(presenter: PagoLoadedImageViewPresenter) {
        
        childPresenters.append(presenter)
        view?.addLoadedImageView(presenter: presenter)
    }
    
    public func addInfoStack(presenter: PagoStackedInfoPresenter) {
        
        childPresenters.append(presenter)
        view?.addStackInfo(presenter: presenter)
    }
    
    public func addView(presenter: PagoSimpleViewPresenter) {
    
        childPresenters.append(presenter)
        view?.addView(presenter: presenter)
    }
    
    public func addField(presenter: PagoTextFieldPresenter) {
        
        childPresenters.append(presenter)
        view?.addField(presenter: presenter)
    }
    
    public func addButton(presenter: PagoButtonPresenter) {
        
        childPresenters.append(presenter)
        view?.addButton(presenter: presenter)
    }

    public func addSpace(presenter: PagoSpacePresenter) {
        
        childPresenters.append(presenter)
        view?.addSpace(presenter: presenter)
    }
    
    public func addPageController(presenter: PagoPageControllerPresenter) {
        
        childPresenters.append(presenter)
        view?.addPageController(presenter: presenter)
    }


    public func update(index: Int, model: Model) {
        
        guard isInBounds(source: childPresenters, index: index) else { return }
        childPresenters[index].update(model: model)
    }
    
    public func updateInteraction(enabled: Bool) {
        
        model.hasAction = enabled
    }

    public func getButtonFromStack(_ stack: PagoStackedInfoPresenter) -> [PagoButtonPresenter] {
        
        var buttons = [PagoButtonPresenter]()
        for child in stack.childPresenters {
            if let stackChild = child as? PagoStackedInfoPresenter {
                buttons.append(contentsOf: getButtonFromStack(stackChild))
            }
            if let button = child as? PagoButtonPresenter {
                buttons.append(button)
            }
        }
        return buttons
    }
    
    public func handleTap() {
        
        delegate?.didTap(presenter: self)
    }
    
    internal func didTap() {
        
        touchUp()
        delegate?.didTap(presenter: self)
    }
    
    internal func touchUp() {
        
        isTouching = false
        view?.reloadStyle(isTouching: false)
    }
    
    internal func touchDown() {
        
        isTouching = true
        view?.reloadStyle(isTouching: true)
    }
}
