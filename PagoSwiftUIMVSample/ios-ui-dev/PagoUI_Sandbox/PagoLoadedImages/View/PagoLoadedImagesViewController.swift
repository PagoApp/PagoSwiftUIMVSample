//
//  
//  PagoLoadedImagesViewController.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 21.11.2023.
//
//

import PagoUISDK
import UIKit

internal class PagoLoadedImagesViewController: BaseStackViewController {

    internal var presenter: PagoLoadedImagesPresenter {
        return basePresenter as! PagoLoadedImagesPresenter
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

extension PagoLoadedImagesViewController: PagoLoadedImagesPresenterView {
    
    internal func setup(stackView: PagoStackedInfoPresenter) {
        let scanStackView = PagoStackedInfoView(presenter: stackView)
        self.stackView.addArrangedSubview(scanStackView)
    }
  
    internal func add(space: CGFloat) {
        stackView.addVerticalSpace(space)
    }
}
