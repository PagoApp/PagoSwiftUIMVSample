//
//  
//  PagoEmptyScreenView.swift
//  Pago
//
//  Created by Gabi Chiosa on 15/04/2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//
import UIKit
import Foundation

class PagoEmptyScreenView: BaseView {
    
    @IBOutlet private  weak var titleLabel: UILabel!
    @IBOutlet private  weak var detailLabel: UILabel!
    @IBOutlet private  weak var headerImageView: UIImageView!
    @IBOutlet private  weak var stackView: UIStackView!
    
    override var presenter: BasePresenter! {
        didSet {
            presenter.setView(mView: self)
            loadData()
        }
    }
    
    public init(presenter: EmptyScreenPresenter) {
        
        super.init(frame: .zero)
        setup(presenter: presenter)
    }

    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    public func setup(presenter: EmptyScreenPresenter) {
        
        self.presenter = presenter
    }

    private func loadData() {
        
        guard let presenter = self.presenter as? EmptyScreenPresenter else { return }
        
        backgroundColor = presenter.style.backgroundColorType.color
        if let space = presenter.style.space {
            stackView.spacing = space
        }
        titleLabel.text = presenter.title
        titleLabel.font = presenter.style.titleFontType.font
        titleLabel.textColor = presenter.style.titleColorType.color
        loadDetail()
        headerImageView.image = presenter.imageType.image
    }
    
    internal func loadDetail() {
        
        guard let presenter = self.presenter as? EmptyScreenPresenter else { return }
        
        let style = presenter.style
        let defaultDetailAttributes = NSAttributedString.toAttributes(font: style.detailFontType, color: style.detailColorType)
        let detailAttributed = NSMutableAttributedString(string: presenter.detail, attributes: defaultDetailAttributes)
        let detailAttributes = NSAttributedString.toAttributes(color: style.placeholderColorType)
        detailAttributed.updateStyle(for: presenter.placeholder, attributes: detailAttributes)
        detailLabel.attributedText = detailAttributed
    }
    
    
    override func reloadView() {
        
        super.reloadView()
        loadDetail()
    }
}
