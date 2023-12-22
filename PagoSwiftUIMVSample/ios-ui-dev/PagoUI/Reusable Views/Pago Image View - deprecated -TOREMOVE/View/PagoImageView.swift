//
//
//  PagoImageView.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation

open class PagoImageView: BaseView {
  
    private var imageView: UIImageView!
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    private var leadingConstraint: NSLayoutConstraint?
    private var topConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    private var trailingConstraint: NSLayoutConstraint?
    
    private var viewPresenter: PagoImageViewPresenter { return (presenter as! PagoImageViewPresenter) }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI(size: CGSize(width: 8, height: 8))
    }
    
    public init(presenter: PagoImageViewPresenter) {
        
        super.init(frame: .zero)
        setupUI(size: presenter.style.size)
        setup(presenter: presenter)
    }
    
    public func setup(presenter: PagoImageViewPresenter) {
        
        self.presenter = presenter
        presenter.setView(mView: self)
        setupConstraints()
        
        imageView.isAccessibilityElement = false
        isAccessibilityElement = presenter.accessibility.isAccessibilityElement
        accessibilityTraits = presenter.accessibility.accessibilityTraits
        accessibilityLabel = presenter.accessibility.accessibilityLabel
    }
    
    public override func reloadView() {
        
        super.reloadView()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.setupConstraints()
        }
    }
    
    private func setupConstraints() {
        
        self.imageView.contentMode = self.viewPresenter.style.contentMode
        if let tintColor = self.viewPresenter.style.tintColorType?.color {
            self.imageView.image = UIImage(pagoImage: self.viewPresenter.imageType)?.withRenderingMode(.alwaysTemplate)
            self.imageView.tintColor = tintColor
        } else {
            self.imageView.image = UIImage(pagoImage: self.viewPresenter.imageType)
        }
        self.imageView.alpha = self.viewPresenter.style.alpha
        self.clipsToBounds = true

        self.layer.cornerRadius = CGFloat(self.viewPresenter.style.backgroundCornerRadius)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat(self.viewPresenter.style.cornerRadius)
        self.backgroundColor = self.viewPresenter.style.backgroundColorType.color
        if let size = self.viewPresenter.style.size {
            self.widthConstraint?.constant = size.width
            self.heightConstraint?.constant = size.height
        } else {
            self.widthConstraint?.isActive = false
            self.heightConstraint?.isActive = false
        }
        self.topConstraint?.constant = self.viewPresenter.style.inset.top
        self.bottomConstraint?.constant = self.viewPresenter.style.inset.bottom
        self.trailingConstraint?.constant = self.viewPresenter.style.inset.right
        self.leadingConstraint?.constant = self.viewPresenter.style.inset.left
        if let borderStyle = self.viewPresenter.style.borderStyle {
            self.borderWidth = borderStyle.width
            self.borderColor = borderStyle.colorType.cgColor
        }
        self.layoutIfNeeded()
    }
    
    private func setupUI(size: CGSize?) {

        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        let leading = imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let top = imageView.topAnchor.constraint(equalTo: self.topAnchor)
        let trailing = self.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        let bottom = self.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        leading.isActive = true
        trailing.isActive = true
        top.isActive = true
        bottom.isActive = true
        self.leadingConstraint = leading
        self.trailingConstraint = trailing
        self.bottomConstraint = bottom
        self.topConstraint = top
        if let size = size {
            let width = imageView.widthAnchor.constraint(equalToConstant: size.width)
            width.isActive = true
            widthConstraint = width
            let height = imageView.heightAnchor.constraint(equalToConstant: size.height)
            height.isActive = true
            heightConstraint = height
        }
    }
}
