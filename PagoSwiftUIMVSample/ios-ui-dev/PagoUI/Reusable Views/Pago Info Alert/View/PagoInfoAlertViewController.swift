//
//  PagoInfoAlertViewController.swift
//  Pago
//
//  Created by Gabi Chiosa on 30.03.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation

class PagoInfoAlertViewController: PagoBaseAlertViewController {
    
    private var contentStackView: PagoStackView!
    
    var presenter: PagoInfoAlertPresenter {
        return basePresenter as! PagoInfoAlertPresenter
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
		
        presenter.setView(mView: self)
        presenter.loadData()
    }
    
}

extension PagoInfoAlertViewController: PagoInfoAlertPresenterView {

	func add(space: CGFloat) {
		
		stackView.addVerticalSpace(space, color: .white)
	}
	
	func setup(loadedImage: PagoLoadedImageViewPresenter) {
		
		let imageView = PagoLoadedImageView(presenter: loadedImage)
		stackView.addArrangedSubview(imageView)
	}
	
	func setup(label: PagoLabelPresenter) {
		
		let labelView = PagoLabel(presenter: label)
		stackView.addArrangedSubview(labelView)
	}

}
