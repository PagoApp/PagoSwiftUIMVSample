//
//  ProvidersHeaderView.swift
//  Pago
//
//  Created by Gabi Chiosa on 22/04/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation

open class TableViewSimpleHeaderView: BaseView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    public override var presenter: BasePresenter! {
        didSet {
            loadData()
        }
    }
    
    public override func reloadView() {
        
        loadData()
    }
    
    private func loadData() {

        guard let viewPresenter = presenter as? TableViewSimpleHeaderPresenter else { return }
        titleLabel.text = viewPresenter.title
        backgroundColor = viewPresenter.style.backgroundColorType.color
        titleLabel.textColor = viewPresenter.style.titleColorType.color
        titleLabel.font = viewPresenter.style.titleFontType.font
        titleLabel.textAlignment = viewPresenter.style.titleAlignment
    }
}
