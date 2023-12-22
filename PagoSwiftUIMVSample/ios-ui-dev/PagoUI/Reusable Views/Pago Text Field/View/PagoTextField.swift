//
//
//  TextFieldView.swift
//  Pago
//
//  Created by Gabi Chiosa on 27/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

public protocol PagoTextFieldDelegate: AnyObject {
    
    func shouldLayoutIfNeededParent()
    func didUpdateUI()
}

public extension PagoTextFieldDelegate {
    func didUpdateUI() {}
    func shouldLayoutIfNeededParent() {}
}

open class PagoTextField: BaseView {
    
    private var textField: BaseTextField!
    private var titleLabel: UILabel!
    private var detailLabel: UILabel!
    private var lineHolder: UIView!
    private var contentView: UIView!
    private var rightButton: PagoButton!
    private var detailTopConstraint: NSLayoutConstraint!
    
    public weak var delegate: PagoTextFieldDelegate?
    public weak var textFieldDelegate: UITextFieldDelegate?

    private var viewPresenter: PagoTextFieldPresenter? {
        return presenter as? PagoTextFieldPresenter
    }
    private var heightConstraint: NSLayoutConstraint?
    
    public init(presenter: PagoTextFieldPresenter) {
        
        super.init(frame: .zero)
        initSubviews()
        setup(presenter: presenter)
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        initSubviews()
    }
    
    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
        initSubviews()
    }
    
    public func setup(presenter: PagoTextFieldPresenter) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.presenter = presenter
        presenter.setView(mView: self)
        loadData()
    }
    
    private func initSubviews() {
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentView)
                
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        textField = BaseTextField()
        textField.baseDelegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textField)
        textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 22).isActive = true
        detailLabel = UILabel()
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(detailLabel)
        detailTopConstraint = detailLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8)
        detailTopConstraint.isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        lineHolder = UIView()
        lineHolder.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lineHolder)
        lineHolder.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 2).isActive = true
        lineHolder.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
        lineHolder.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
        lineHolder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        let rightButton = PagoButton(frame: .zero)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(rightButton)
        rightButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        rightButton.bottomAnchor.constraint(equalTo: lineHolder.bottomAnchor, constant: -4).isActive = true
        self.rightButton = rightButton
        
        self.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }

    public override func reloadView() {
        
        super.reloadView()
        loadData()
    }
    
    @objc
    func textFieldDidChange(textField: UITextField) {
        
        viewPresenter?.didUpdate()
    }

    private func loadData() {

        guard let viewPresenter = viewPresenter else { return }
        backgroundColor = viewPresenter.style.backgroundColor.color
        lineHolder.backgroundColor = viewPresenter.style.textFieldDefaultLineColor.color
        
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: viewPresenter.style.titleSpace).isActive = true

        textField.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.focus))
        isUserInteractionEnabled = true
        textField.addGestureRecognizer(tapGestureRecognizer)
        textField.textContentType = viewPresenter.style.textFieldContentType
        textField.returnKeyType = viewPresenter.style.returnKeyType
        textField.autocorrectionType = viewPresenter.style.autocorrectionType
        textField.autocapitalizationType = viewPresenter.style.autocapitalizationType
        textField.keyboardType = viewPresenter.style.keyboardType
        textField.isSecureTextEntry = viewPresenter.style.isSecureTextEntry
        textField.isUserInteractionEnabled = viewPresenter.style.isUserInteractionEnabled
        textField.textColor = viewPresenter.style.textFieldColor.color
        textField.font = viewPresenter.style.textFieldFont.font
        textField.textAlignment = viewPresenter.style.textFieldAlignment
        detailLabel.font = viewPresenter.style.detailFont.font
        detailLabel.numberOfLines = viewPresenter.style.detailNumberOfLines
        if viewPresenter.style.isTitleUppercased {
            titleLabel.text = viewPresenter.placeholder.uppercased()
        } else {
            titleLabel.text = viewPresenter.placeholder
        }
        
        if let detail = viewPresenter.detail {
            showDetail(text: detail, colorType: viewPresenter.style.textDetailColor)
        } else {
            hideDetail()
        }
        
        textField.text = viewPresenter.text
        titleLabel.textColor = viewPresenter.style.titleColor.color
        titleLabel.font = viewPresenter.style.titleFont.font
        if let buttonPresenter = viewPresenter.buttonPresenter {
            rightButton.isHidden = false
            rightButton.setup(presenter: buttonPresenter)
        } else {
            rightButton.isHidden = true
//            rightButton.heightAnchor.constraint(equalToConstant: 0).isActive = true
//            rightButton.widthAnchor.constraint(equalToConstant: 0).isActive = true
        }
        
        if let barButtonItem = viewPresenter.style.toolbarButton {
            let button = UIBarButtonItem(barButtonSystemItem: barButtonItem, target: self, action: #selector(didTapToolbar))
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            toolbar.setItems([button], animated: false)
            textField.inputAccessoryView = toolbar
        }
        
        if let datePickerStyle = viewPresenter.style.datePickerStyle {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.backgroundColor = UIColor.white
            datePicker.date = datePickerStyle.current
            datePicker.minimumDate = datePickerStyle.minDate
            datePicker.maximumDate = datePickerStyle.maxDate
            datePicker.addTarget(self, action: #selector(dateDidChanged(_:)), for: .valueChanged)
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            }
            textField.inputView = datePicker
        }
        
        updateLayoutIfNeeded()
        textField.reloadInputViews()
        rightButton.isAccessibilityElement = false
        titleLabel.isAccessibilityElement = false
        detailLabel.isAccessibilityElement = false
        update(accessibility: viewPresenter.accessibility)
    }

    @objc private func dateDidChanged(_ sender: UIDatePicker) {

        textField.text = sender.date.toString(format: .dateWithYear)
        viewPresenter?.style.datePickerStyle?.current = sender.date
        viewPresenter?.validate(text: textField.text)
        viewPresenter?.didUpdate()
    }
    
    @objc private func didTapToolbar() {
    
        self.endEditing(true)
        viewPresenter?.didEndEditing()
    }
    
    private func updateLayoutIfNeeded() {
        if self.delegate == nil {
            self.layoutIfNeeded()
        } else {
            self.delegate?.shouldLayoutIfNeededParent()
        }
    }
}

extension PagoTextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                   
        guard let text = textField.text else { return false }
        
        //TODO: This enables a bug in the component. it starts default with errors ignoring the isFirstTimeEditing
//        if let presenter = viewPresenter {
//            if presenter.isFirstTimeEditing {
//                presenter.isFirstTimeEditing = false
//            }
//        }

        var stringInternal = string

        // apply formatting os user types in before updating
        var _typedIn = string
        var _finalString = (text as NSString).replacingCharacters(in: range, with: string)
        var _formatted: String = _typedIn
        var didFormatKey = false
        if let rules = viewPresenter?.model.formattingRules {
            rules.forEach { rule in
                if rule.type == .keyTyped,
                   let _string = rule.formatting(_formatted) {
                    // reset the value to apply further rules
                    _formatted = _string
                    didFormatKey = true
                }
            }
        }

        if didFormatKey {
            stringInternal = _formatted
        }

        var finalString = (text as NSString).replacingCharacters(in: range, with: stringInternal)

        // intercept and deny keypress when validation rules are not met; validate only typed in (stringInternal) not entire string as it may be formatted
        if viewPresenter?.checkValidationsTypingBlockedNewText(on: stringInternal) == false{
            return false
        }

        // apply validations on whole text, if any
        if viewPresenter?.checkValidationsTypingBlockedAllText(on: finalString) == false{
            return false
        }

        var didFormatText = false
        // apply formatting to whole text after replacement
        if let rules = viewPresenter?.model.formattingRules {
            rules.forEach { rule in
                if rule.type == .allText,
                   let _string = rule.formatting(finalString) {
                    _formatted = _string
                    didFormatText = true
                }
            }
        }
        if didFormatText {
            finalString = _formatted
        }

        if let shouldReplaceString = viewPresenter?.shouldReplaceString {
            let shouldReplace = shouldReplaceString(textField.text ?? "", range, stringInternal)
            if shouldReplace {
                viewPresenter?.validate(text: finalString, shouldShowError: .byRule)
            }
            return shouldReplace
        }

        viewPresenter?.validate(text: finalString, shouldShowError: .byRule)

        if didFormatKey || didFormatText {
            viewPresenter?.updateText(text: finalString)
            viewPresenter?.didUpdate()
            return false
        }

        return true
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        viewPresenter?.shouldReturn()
        return true
    }

    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

        viewPresenter?.didEndEditing()
        return true
    }

    public func textFieldShouldClear(_ textField: UITextField) -> Bool {

        viewPresenter?.validate(text: nil)
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
        viewPresenter?.didBeginEditing()
    }
}

extension PagoTextField: PagoTextFieldPresenterView {
   
    func update(hasInteraction: Bool) {
        textField.isUserInteractionEnabled = hasInteraction
    }
    
    
    internal func update(accessibility: PagoAccessibility) {
        
        textField.isAccessibilityElement = accessibility.isAccessibilityElement
        textField.accessibilityTraits = accessibility.accessibilityTraits
        textField.accessibilityLabel = accessibility.accessibilityLabel
    }
    
    @objc public func focus() {
        
        OperationQueue.main.addOperation { [weak self] in
            guard self?.viewPresenter?.isEditable == true else {
                self?.textField.resignFirstResponder()
                return
            }
            self?.textField.becomeFirstResponder()
        }
    }
    
    internal func dismiss() {
        
        OperationQueue.main.addOperation { [weak self] in
            self?.textField.resignFirstResponder()
        }
    }
    
    private func hideDetail() {
        
        detailTopConstraint.constant = 0
        self.detailLabel.text = nil
    }
    
    private func highlightLine(colorType: UIColor.Pago?) {
        
        lineHolder.backgroundColor = colorType?.color
    }
    
    private func showDetail(text: String?, colorType: UIColor.Pago?) {
        
        detailTopConstraint.constant = 8
        self.detailLabel.text = text
        self.detailLabel.textColor = colorType?.color
    }
    
    internal func showValid(message: String?, hasDetail: Bool) {
    
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            if hasDetail {
                self.showDetail(text: message, colorType: self.viewPresenter?.style.textDetailColor)
            } else {
                self.hideDetail()
            }
            //TODO: There's a bug here. after the text has it's color reset it needs to readd the text
            //If we readd it here we will have duplicate strings
            self.titleLabel.textColor = self.viewPresenter?.style.titleColor.color
            self.textField.textColor = self.viewPresenter?.style.textFieldColor.color
            self.highlightLine(colorType: self.viewPresenter?.style.textFieldDefaultLineColor)
            self.updateLayoutIfNeeded()
            self.delegate?.didUpdateUI()
        }
        
    }
    
    internal func showError(message: String?, hasDetail: Bool) {
    
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            if hasDetail {
                self.showDetail(text: message, colorType: self.viewPresenter?.style.textErrorColor)
            } else {
                self.hideDetail()
            }
            //TODO: There's a bug here. after the text has it's color reset it needs to readd the text
            //If we readd it here we will have duplicate strings
            self.titleLabel.textColor = self.viewPresenter?.style.titleInvalidColor.color
            self.textField.textColor = self.viewPresenter?.style.textFieldInvalidColor.color
            self.highlightLine(colorType: self.viewPresenter?.style.textFieldInvalidLineColor)
            self.updateLayoutIfNeeded()
            self.delegate?.didUpdateUI()
        }
    }
    
    internal func hide(isHidden: Bool) {
        
        self.isHidden = isHidden
    }
}

extension PagoTextField: BaseTextFieldDelegate {
    
    internal func deleteBackward() {
        
        viewPresenter?.didTapDelete()
    }
}
