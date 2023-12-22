//
//  
//  PagoEmailConfirmationViewController.swift
//  PagoRCASDK
//
//  Created by Gabi on 19.10.2022.
//
//

import PagoUISDK
import UIKit

public class PagoEmailConfirmationViewController: BaseStackViewController {


    var presenter: PagoEmailConfirmationPresenter {
        return basePresenter as! PagoEmailConfirmationPresenter
    }
        
    public override func viewDidLoad() {
        super.viewDidLoad()

        stackView.spacing = 0
        presenter.setView(mView: self)
        presenter.loadData()
        let bottomInset = CGFloat(24 + 48 + 24)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
    }
    
    public override func setupViewBackground(hasEmptyScreen: Bool) {
        
        view.backgroundColor = UIColor.Pago.white.color
    }
}

extension PagoEmailConfirmationViewController: PagoEmailConfirmationPresenterView {
    
    public func setup(stackView: PagoStackedInfoPresenter) {
        let scanStackView = PagoStackedInfoView(presenter: stackView)
        self.stackView.addArrangedSubview(scanStackView)
    }
    
    public func setup(label: PagoLabelPresenter) {
        
        let view = PagoLabel(presenter: label)
        stackView.addArrangedSubview(view)
    }
    
    public func setup(textField: PagoTextFieldPresenter) {

        let view = PagoTextField(presenter: textField)
        stackView.addArrangedSubview(view)
    }
    
    public func setup(checkbox: PagoCheckboxPresenter) {

        let view = PagoCheckbox(presenter: checkbox)
        stackView.addArrangedSubview(view)
    }

    public func setup(button: PagoButtonPresenter) {

        let button = PagoButton(presenter: button)
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -24).isActive = true
    }
    
    public func add(space: CGFloat) {
        stackView.addVerticalSpace(space)
    }
}
