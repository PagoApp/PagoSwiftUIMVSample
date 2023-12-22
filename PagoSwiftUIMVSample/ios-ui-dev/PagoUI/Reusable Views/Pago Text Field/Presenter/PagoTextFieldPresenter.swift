//
//  
//  PagoTextFieldPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import Foundation

protocol PagoTextFieldPresenterView: PresenterView {
    
    func update(accessibility: PagoAccessibility)
    func update(hasInteraction: Bool)
    func showError(message: String?, hasDetail: Bool)
    func showValid(message: String?, hasDetail: Bool)
    func focus()
    func dismiss()
    func hide(isHidden: Bool)
}

public protocol PagoTextFieldPresenterDelegate: AnyObject {
    
    func willUpdate(presenter: PagoTextFieldPresenter)
    func didTapDelete(presenter: PagoTextFieldPresenter)
    func didBeginEditing(presenter: PagoTextFieldPresenter)
    func didEndEditing(presenter: PagoTextFieldPresenter)
    func didUpdate(presenter: PagoTextFieldPresenter)
    func didDismiss(index: Int)
    func didTapButton(presenter: PagoTextFieldPresenter)
    func didReturn(presenter: PagoTextFieldPresenter)
}

public extension PagoTextFieldPresenterDelegate {

    func willUpdate(presenter: PagoTextFieldPresenter) {}
    func didUpdate(presenter: PagoTextFieldPresenter) {}
    func didDismiss(index: Int) {}
    func didTapDelete(presenter: PagoTextFieldPresenter) {}
    func didBeginEditing(presenter: PagoTextFieldPresenter) {}
    func didEndEditing(presenter: PagoTextFieldPresenter) {}
    func didTapButton(presenter: PagoTextFieldPresenter) {}
    func didReturn(presenter: PagoTextFieldPresenter) {}
}

open class PagoTextFieldPresenter: BasePresenter {

    public weak var delegate: PagoTextFieldPresenterDelegate?
    public var model: PagoTextFieldModel {
        get { return (self.baseModel as! PagoTextFieldModel) }
        set { self.baseModel = newValue }
    }
    public var error: String? { return model.error }
    public var validationError: String?
    public var text: String? {
        get { return model.text }
        set { model.text = newValue }
    }
    public var placeholder: String {
        get { return model.placeholder }
        set { model.placeholder = newValue}
    }
    public var hasRightButton: Bool {
        return buttonPresenter != nil
    }
    public var detail: String? { return model.detail }
    public var isValid: Bool?
    public var style: PagoTextFieldStyle {
        get { return model.style }
        set { model.style = newValue }
    }
    private let linePresenter: PagoLinePresenter

    @available(*, deprecated, message: "Use validation((ValidationModel) -> (Bool))? instead")
    private var validation: ((String?) -> (Bool))? {
        didSet {
            model.updateValidationRules(validation: validation)
        }
    }
    
    var shouldReplaceString: ((String, NSRange, String) -> (Bool))?
    public let index: Int?
    var isFirstTimeEditing = true
    internal var buttonPresenter: PagoButtonPresenter?
    public var buttonIndex: Int? {
        return buttonPresenter?.index
    }
    internal var accessibility: PagoAccessibility { return model.accessibility }
    /**
     Workaround for remote validation, should be refactored when a new solution is implemented
     */
    public var shouldValidateOnDidEndEditing: Bool = true
    
    private var lastText: String?
    
    private var view: PagoTextFieldPresenterView? { return basePresenterView as? PagoTextFieldPresenterView  }
    
    public var isHidden: Bool = false {
        didSet {
            view?.hide(isHidden: isHidden)
        }
    }
    public var isEditable: Bool {
        return model.isEditable
    }
    
    public init(model: PagoTextFieldModel, index: Int? = nil, isValid: Bool? = nil, validation: ((String?) -> (Bool))? = nil, shouldReplaceString: ((String, NSRange, String) -> (Bool))? = nil) {

        self.linePresenter = PagoLinePresenter(model: PagoLineModel(style: PagoLineStyle(color: model.style.textFieldDefaultLineColor)))
        self.validation = validation
        self.index = index
        self.isValid = isValid
        if let shouldReplaceString = shouldReplaceString {
            self.shouldReplaceString = shouldReplaceString
        }
        if let buttonModel = model.button {
            self.buttonPresenter = PagoButtonPresenter(model: buttonModel)
            buttonPresenter?.delegate = delegate as? PagoButtonPresenterDelegate
        }
        super.init()
        if let buttonModel = model.button {
            buttonPresenter = PagoButtonPresenter(model: buttonModel)
            buttonPresenter?.delegate = self
        }
        update(model: model)
        // didSet not called during init, enforce validation rules setup
        self.model.updateValidationRules(validation: validation)
        
        view?.update(accessibility: model.accessibility)
        self.model.didUpdateAccessibility = { [weak self] accessibility in
            self?.view?.update(accessibility: accessibility)
        }
    }
    
    public func updateText(text: String) {
        
        model.text = text
        view?.reloadView()
    }
    
    public func update(placeholder: String, reload: Bool = true) {
        
        model.placeholder = placeholder
        if reload {
            view?.reloadView()
        }
    }
    
    public func update(model: Model, reload: Bool = true) {
        
        super.update(model: model)
        if reload {
            view?.reloadView()
        }
    }

    public func removeButton() {
        
        buttonPresenter = nil
        model.button = nil
        view?.reloadView()
    }
    
    public func addButton(button: PagoButtonModel, reload: Bool = true) {
        
        model.button = button
        buttonPresenter = PagoButtonPresenter(model: button)
        buttonPresenter?.delegate = self
        if reload {
            view?.reloadView()
        }
    }
    
    public func update(button: PagoButtonModel) {
        
        buttonPresenter?.update(model: button)
    }
    
    public func update(style: PagoTextFieldStyle, reload: Bool = true) {
        
        model.style = style
        if reload {
            view?.reloadView()
        }
    }
    
    public func reloadLine() {
        
        linePresenter.view?.reloadView()
    }
    
    public func validateFieldAndForceErrorsIfAny() {
        
        isFirstTimeEditing = false
        validateField()
    }
    
    public func validateFieldWithoutShowingErrors() {
            
            if isFirstTimeEditing {
                isFirstTimeEditing = false
            }

            (isValid, _) = checkValidationRules(text: self.text)
        }
    
    public func validateField(shouldShowError: ValidationErrorShouldBeDisplayedType = .always) {
        
        if isFirstTimeEditing {
            isFirstTimeEditing = false
        }
        validate(text: text, shouldShowError: shouldShowError)
    }
    
    public func didUpdate() {
        
        delegate?.didUpdate(presenter: self)
    }

    public func checkValidationsTypingBlockedNewText(on text: String) -> Bool {

        let validated = validate(for: .blocksTypingNewText, text: text)
        return validated
    }

    public func checkValidationsTypingBlockedAllText(on text: String) -> Bool {

        let validated = validate(for: .blocksTypingAllText, text: text)
        return validated
    }

    private func validate(for ruleType: ValidationRuleType, text: String) -> Bool {

        guard let rules = model.validationRules else { return true }
        for rule in rules where rule.type == ruleType {
            let validated = rule.validation(text)
            if !validated {
                return false
            }
        }
        return true
    }

    public func validate(text: String?, shouldShowError: ValidationErrorShouldBeDisplayedType = .always) {
        
        self.text = text

        var failedValidationRule: ValidationRuleModel? = nil
        (isValid, failedValidationRule) = checkValidationRules(text: self.text)
        if let rule = failedValidationRule {
            validationError = rule.error
        }

        //TODO: check if isFirstTimeEditing is still needed
//        if isValid == true {
//            hideError()
//        } else {if !isFirstTimeEditing, isValid == false {
//            switch shouldShowError {
//            case .always:
//                showError()
//            case .byRule:
//                if let rule = failedValidationRule, rule.type != .regular {
//                    showError()
//                }
//            }
//        }

        hideError()
        if isValid == false {
            switch shouldShowError {
            case .always:
                showError()
            case .byRule:
                // allow error display while typing for specific rules only (eg char not allowed for VIN)
                if let rule = failedValidationRule, rule.type != .regular {
                    showError()
                }
            }
        }


        if lastText != text {
            lastText = text
            delegate?.willUpdate(presenter: self)
        }
    }

    private func checkValidationRules(text: String?) -> (Bool, ValidationRuleModel?) {

        guard let validationRules = model.validationRules else { return (true, nil) }
        for rule in validationRules {
            // rules that apply to each typed in key shouldn't be rechecked here as the entire text might be formatted
            if rule.type != .blocksTypingNewText && rule.type != .blocksTypingAllText {
                if rule.validation(text) == false {
                    return (false, rule)
                }
            }
        }
        return (true, nil)
    }
    
    public func showCustomError(message: String) {
        
        view?.showError(message: message, hasDetail: true)
        linePresenter.update(color: model.style.textFieldInvalidLineColor)
    }
    
    public func showError() {
        
        view?.showError(message: validationError, hasDetail: validationError != nil)
        linePresenter.update(color: model.style.textFieldInvalidLineColor)
    }
    
    public func hideError() {
        
        view?.showValid(message: detail, hasDetail: detail != nil)
        linePresenter.update(color: model.style.textFieldDefaultLineColor)
    }
    
    public func shouldReturn() {
        
        isFirstTimeEditing = false
        validateField()
        shouldDismiss()
        delegate?.didReturn(presenter: self)
    }
    
    public func shouldDismiss() {
        
        if let indexT = index {
            delegate?.didDismiss(index: indexT)
        } else {
            dismiss()
        }
    }
    
    public func clearData() {
        
        model.text = nil
        view?.reloadView()
    }
    
    public func focus() {
        
        guard style.isUserInteractionEnabled else {
            if let indexT = index {
                delegate?.didDismiss(index: indexT)
            }
            return
        }
        view?.focus()
    }

    public func dismiss() {
        
        view?.dismiss()
    }

    public func didTapDelete() {
        
        delegate?.didTapDelete(presenter: self)
    }
    
    public func didEndEditing() {
        
        delegate?.didEndEditing(presenter: self)
        if shouldValidateOnDidEndEditing {
            validate(text: text)
        }
    }
    
    public func didBeginEditing() {
        
        delegate?.didBeginEditing(presenter: self)
    }

    public func enable() {
        model.style.isUserInteractionEnabled = true
        view?.update(hasInteraction: true)
    }
    
    public func disable() {
        model.style.isUserInteractionEnabled = false
        view?.update(hasInteraction: false)
    }
    
    public func forceInvalidStyle() {
        showError()
    }
    
    public func forceDefaultStyle() {
        hideError()
    }
}

extension PagoTextFieldPresenter: PagoButtonPresenterDelegate {
    
    public func didTap(button: PagoButtonPresenter) {
        
        delegate?.didTapButton(presenter: self)
    }
}
