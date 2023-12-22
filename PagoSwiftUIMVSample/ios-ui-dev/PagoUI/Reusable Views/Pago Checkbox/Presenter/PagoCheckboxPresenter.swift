//
//  
//  PagoCheckboxPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 29/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

protocol PagoCheckboxPresenterView: PresenterView {
    
    func update(style: PagoCheckboxStateStyle)
    func update(accessibility: PagoAccessibility)
    func update(title: String)
    func hideView(isHidden: Bool)
}

public protocol PagoCheckboxPresenterDelegate: AnyObject {
    
    func didUpdate(presenter: PagoCheckboxPresenter)
    func didTapInfo(presenter: PagoCheckboxPresenter)
    func confirm(completion: @escaping (Bool)->())
	func handleDisabledTap()
}

extension PagoCheckboxPresenterDelegate {
    
    public func confirm(completion: (Bool)->()) {
        completion(true)
    }
	public func handleDisabledTap() { }
}

public extension PagoCheckboxPresenterDelegate {
    func didTapInfo(presenter: PagoCheckboxPresenter) {}
}

open class PagoCheckboxPresenter: BasePresenter {
    
    public weak var delegate: PagoCheckboxPresenterDelegate?
    var title: String {
        return model.title ?? ""
    }
    var hasInfo: Bool {
        return model.hasInfo == true
    }
    public var isSelected: Bool {
        get { return model.isSelected }
        set { model.isSelected = newValue }
    }
    public var isEnabled: Bool = true
    /**
     Used to disable user interaction without changing the display of the component to a grayish disabled. If false, the component will be used in addition to other components to display information (eg their selection state)
     */
    public var isUserInteractionEnabled: Bool {
        get { return model.isUserInteractionEnabled }
        set {
			model.isUserInteractionEnabled = newValue
			updateView()
		}
    }
    var model: PagoCheckboxModel {
        get { return (self.baseModel as! PagoCheckboxModel) }
        set { baseModel = newValue }
    }
    var forceError: Bool = false
    var highlightedText: String? {
        return model.highlightedText
    }
    var stateStyle: PagoCheckboxStateStyle {
        if forceError, let errorStyleT = errorStyle {
            return errorStyleT
        }
        if !isUserInteractionEnabled, let disabledStyleT = disabledStyle  {
			return disabledStyleT
        } else {
			return isSelected ? selectedStyle : deselectedStyle
        }
    }
    var accessibility: PagoAccessibility {
        get { return model.accessibility }
        set { model.accessibility = newValue }
    }
    
    public var isHidden: Bool = false {
        didSet {
            view?.hideView(isHidden: isHidden)
        }
    }
	
	private var view: PagoCheckboxPresenterView? { return basePresenterView as? PagoCheckboxPresenterView }
	internal var imagePresenter: PagoLoadedImageViewPresenter!
	internal var style: PagoCheckboxStyle { return model.style }
	private var selectedStyle: PagoCheckboxStateStyle { return model.style.selectedStateStyle }
	private var deselectedStyle: PagoCheckboxStateStyle { return model.style.deselectedStateStyle }
	private var errorStyle: PagoCheckboxStateStyle? { return model.style.errorStateStyle }
    private var disabledStyle: PagoCheckboxStateStyle? { return model.style.disabledStateStyle }
	internal var transitionTime: Double { return model.transitionTime }

    public override init(model: Model = EmptyModel()) {

        super.init(model: model)

        updateImageModel(stateStyle: stateStyle)
        if let imageModel = self.model.imageModel {
            imagePresenter = PagoLoadedImageViewPresenter(model: imageModel)
        }
    }

    private func updateImageModel(stateStyle: PagoCheckboxStateStyle) {
        let size = style.imageSize.size
        let imageSize = CGSize(width: size, height: size)
        let imageStyle = PagoImageViewStyle(size: imageSize, contentMode: .scaleAspectFit)
        let imageData = stateStyle.imageData
        let imageModel = PagoLoadedImageViewModel(imageData: imageData, style: imageStyle)
        model.imageModel = imageModel
    }

    public func toggleSelection() {
        
        if model.askForConfirmation {
            delegate?.confirm() { confirmed in
                if confirmed {
                    self.toggle()
                }
            }
        } else {
            toggle()
        }
    }
	
	/// Handle tap or focus on component when isUserInteractionDisabled == true
	public func handleDisabledTap() {
		
		delegate?.handleDisabledTap()
	}

    private func updateView() {

        imagePresenter.update(image: stateStyle.imageData)
        view?.update(style: stateStyle)
    }
    
    private func toggle() {
        
        isSelected = !isSelected
        if forceError, isSelected {
            forceError = false
        }
        updateView()
        update(accessibility: accessibility)
        delegate?.didUpdate(presenter: self)
    }
    
    ///Does the same as updateSelection(selected: ) without the delegate
    ///callback. This is usefull when complex logic with select/deselect
    ///for checkboxes is required
    public func silentUpdateSelection(selected: Bool) {
        guard selected != isSelected else {
            return
        }
        isSelected = selected
        updateView()
        update(accessibility: accessibility)
    }
    
    public func updateSelection(selected: Bool) {
        guard selected != isSelected else {
            return
        }
        isSelected = selected
        updateView()
        update(accessibility: accessibility)
        delegate?.didUpdate(presenter: self)
    }
    
    public func update(title: String) {
        
        model.title = title
        view?.update(title: title)
        accessibility.accessibilityLabel = title
        view?.update(accessibility: accessibility)
    }
    
    func showInfo() {
        
        guard isEnabled else { return }
        delegate?.didTapInfo(presenter: self)
    }
    
    func loadState() {

        updateView()
    }
    
    func validateCheckboxAndForceErrorsIfAny() {
        
        guard forceError != !isSelected else { return }
        forceError = !isSelected
        updateView()
    }
    
    func update(accessibility: PagoAccessibility) {
        
        model.accessibility = accessibility
        view?.update(accessibility: accessibility)
    }
}
