//
//  
//  PagoCustomComponentViewController.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 21.11.2023.
//
//

import PagoUISDK
import UIKit

internal class PagoCustomComponentViewController: BaseStackViewController {

    internal var presenter: PagoCustomComponentPresenter {
        return basePresenter as! PagoCustomComponentPresenter
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

extension PagoCustomComponentViewController: PagoCustomComponentPresenterView {
    
    internal func setup(custom: PagoStackedInfosPresenter) {
        let view = PagoStackedInfosView(presenter: custom)
        self.stackView.addArrangedSubview(view)
    }
   
}
