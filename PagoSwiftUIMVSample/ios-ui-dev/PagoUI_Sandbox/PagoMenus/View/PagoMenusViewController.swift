//
//  
//  PagoMenusViewController.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 01.11.2023.
//
//

import PagoUISDK
import UIKit

internal class PagoMenusViewController: BaseStackViewController {

    internal var presenter: PagoMenusPresenter {
        return basePresenter as! PagoMenusPresenter
    }
        
    internal override func viewDidLoad() {
        super.viewDidLoad()

        stackView.spacing = 0
        presenter.setView(mView: self)
        presenter.loadData()
    }
    
    internal override func setupViewBackground(hasEmptyScreen: Bool) {
        
        view.backgroundColor = UIColor.Pago.white.color
    }
}

extension PagoMenusViewController: PagoMenusPresenterView {
    
    internal func setup(stackView: PagoStackedInfoPresenter) {
        let scanStackView = PagoStackedInfoView(presenter: stackView)
        self.stackView.addArrangedSubview(scanStackView)
    }
    
    internal func setup(textField: PagoTextFieldPresenter) {

        let view = PagoTextField(presenter: textField)
        stackView.addArrangedSubview(view)
    }
    
    internal func setup(checkbox: PagoCheckboxPresenter) {

        let view = PagoCheckbox(presenter: checkbox)
        stackView.addArrangedSubview(view)
    }

    internal func setup(button: PagoButtonPresenter) {

        let button = PagoButton(presenter: button)
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -24).isActive = true
    }
    
    internal func add(space: CGFloat) {
        stackView.addVerticalSpace(space)
    }
}
