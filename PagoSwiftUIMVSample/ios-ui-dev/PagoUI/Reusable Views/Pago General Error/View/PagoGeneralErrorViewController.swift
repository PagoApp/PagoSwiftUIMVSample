//
//  PagoGeneralErrorViewController.swift
//  Pago
//
//  Created by Gabi Chiosa on 30.03.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation

class PagoGeneralErrorViewController: PagoBaseAlertViewController {
    
    private var contentStackView: PagoStackView!
    
    var presenter: PagoGeneralErrorPresenter {
        return basePresenter as! PagoGeneralErrorPresenter
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        presenter.setView(mView: self)
        presenter.loadData()
    }
    
}

extension PagoGeneralErrorViewController: PagoGeneralErrorPresenterView {

    func setup(stack: PagoStackedInfoPresenter) {
        
        let stackInfoView = PagoStackedInfoView(presenter: stack)
        stackView.addArrangedSubview(stackInfoView)
    }

}
