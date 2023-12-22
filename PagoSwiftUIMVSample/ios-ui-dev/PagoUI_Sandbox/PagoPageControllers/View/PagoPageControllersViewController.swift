//
//  
//  PagoPageControllersViewController.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 21.11.2023.
//
//

import PagoUISDK
import UIKit

internal class PagoPageControllersViewController: BaseStackViewController {

    internal var presenter: PagoPageControllersPresenter {
        return basePresenter as! PagoPageControllersPresenter
    }
        
    internal override func viewDidLoad() {
        super.viewDidLoad()

        stackView.spacing = 0
        stackView.backgroundColor = .red
        presenter.setView(mView: self)
        presenter.loadData()
    }
    
    internal override func setupViewBackground(hasEmptyScreen: Bool) {
        
        view.backgroundColor = UIColor.Pago.white.color
    }
}

extension PagoPageControllersViewController: PagoPageControllersPresenterView {
    
    internal func setup(stackView: PagoStackedInfoPresenter) {
        let scanStackView = PagoStackedInfoView(presenter: stackView)
        self.stackView.addArrangedSubview(scanStackView)
    }
}
