//
//  
//  PagoButtonsViewController.swift
//  PagoUI_Sandbox
//
//  Created by LoredanaBenedic on 14.03.2023.
//
//

import PagoUISDK
import UIKit

class PagoButtonsViewController: BaseStackViewController {

    var presenter: PagoButtonsPresenter {
        return basePresenter as! PagoButtonsPresenter
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        stackView.spacing = 0
        presenter.setView(mView: self)
        presenter.loadData()
    }
    
    override func setupViewBackground(hasEmptyScreen: Bool) {
        
        view.backgroundColor = UIColor.Pago.white.color
    }
}

extension PagoButtonsViewController: PagoButtonsPresenterView {
 
    func setup(textField: PagoTextFieldPresenter) {

        let view = PagoTextField(presenter: textField)
        stackView.addArrangedSubview(view)
    }
    
    func setup(button: PagoButtonPresenter) {

        let button = PagoButton(presenter: button)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true

		stackView.addArrangedSubview(button)
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
    }
    
    func add(space: CGFloat) {
        stackView.addVerticalSpace(space)
    }
}
