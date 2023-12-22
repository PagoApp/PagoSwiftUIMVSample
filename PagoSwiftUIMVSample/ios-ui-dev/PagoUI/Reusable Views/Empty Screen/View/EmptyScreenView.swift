//
//  
//  EmptyScreenView.swift
//  Pago
//
//  Created by Gabi Chiosa on 23/04/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation

class EmptyScreenView: BaseView {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    
    override var presenter: BasePresenter! {
        didSet {
            presenter.setView(mView: self)
            loadData()
        }
    }
    
    init(presenter: EmptyScreenPresenter) {
        
        super.init(frame: .zero)
        setup(presenter: presenter)
    }

    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    public func setup(presenter: EmptyScreenPresenter) {
        
        self.presenter = presenter
    }

    func loadData() {
        
        guard let presenter = self.presenter as? EmptyScreenPresenter else { return }
        
        backgroundColor = presenter.style.backgroundColorType.color
        titleLabel.text = presenter.title
        titleLabel.font = presenter.style.titleFontType.font
        titleLabel.textColor = presenter.style.titleColorType.color
        loadDetail()
        headerImageView.image = presenter.imageType.image
    }
    
    func loadDetail() {
        
        guard let presenter = self.presenter as? EmptyScreenPresenter else { return }
        
        scrollView.contentInset = presenter.style.contentInsets
        let style = presenter.style
        let defaultDetailAttributes = NSAttributedString.toAttributes(font: style.detailFontType, color: style.detailColorType)
        let detailAttributed = NSMutableAttributedString(string: presenter.detail, attributes: defaultDetailAttributes)
        let detailAttributes = NSAttributedString.toAttributes(color: style.placeholderColorType)
        detailAttributed.updateStyle(for: presenter.placeholder, attributes: detailAttributes)
        detailLabel.attributedText = detailAttributed
    }
    
    
    override func reloadView() {
        
        super.reloadView()
        DispatchQueue.main.async { [weak self] in
            self?.loadDetail()
        }
    }
}
