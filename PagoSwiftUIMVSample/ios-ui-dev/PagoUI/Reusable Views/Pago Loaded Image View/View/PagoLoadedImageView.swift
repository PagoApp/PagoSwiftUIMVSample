//
//
//  PagoLoadedImageView.swift
//  Pago
//
//  Created by Gabi Chiosa on 31/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import CoreGraphics
import Foundation
import UIKit

open class PagoLoadedImageView: BaseView {
    
    private(set) var imageView: UIImageView!
    private var activityIndicatorView: UIActivityIndicatorView!

    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?
    private var topConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    private var trailingConstraint: NSLayoutConstraint?
    private var label: PagoLabel?
    
    private var datasource: PagoSDWebImageDataSource? {
        return PagoUIConfigurator.datasource?.sdwebImage
    }
    
    private var viewPresenter: PagoLoadedImageViewPresenter { return (presenter as! PagoLoadedImageViewPresenter) }
    
    public init(presenter: PagoLoadedImageViewPresenter) {
        super.init(frame: .zero)
        setupUI(size: presenter.style.size)
        setup(presenter: presenter)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI(size: CGSize(width: 8, height: 8))
    }
    
    override open var intrinsicContentSize: CGSize {
        let widthValue = viewPresenter.style.size?.width ?? imageView.intrinsicContentSize.width
        let heightValue = viewPresenter.style.size?.width ?? imageView.intrinsicContentSize.height
        let width = widthValue + viewPresenter.style.inset.left + viewPresenter.style.inset.right
        let height = heightValue + viewPresenter.style.inset.top + viewPresenter.style.inset.bottom
        return CGSize(width: width , height: height)
    }
    
    public func setup(presenter: PagoLoadedImageViewPresenter) {
        self.presenter = presenter
        presenter.setView(mView: self)
        setupConstraints()
        presenter.loadData()
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
            self.setupImage()
        }
    }
    
    
    private func setupConstraints() {
        
        self.imageView.contentMode = self.viewPresenter.style.contentMode
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(self.viewPresenter.style.backgroundCornerRadius)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat(self.viewPresenter.style.cornerRadius)
        self.backgroundColor = self.viewPresenter.style.backgroundColorType.color
        if let size = self.viewPresenter.style.size {
            self.widthConstraint?.constant = size.width
            self.heightConstraint?.constant = size.height
            self.widthConstraint?.isActive = size.width > 0
            self.heightConstraint?.isActive = size.height > 0
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
        self.setNeedsLayout()
    }
    
    private func setupUI(size: CGSize?) {

        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        imageView = UIImageView()
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
        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicatorView)
        activityIndicatorView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        activityIndicatorView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
    }
}

extension PagoLoadedImageView: PagoLoadedImageViewPresenterView {
    
    public func hide(isHidden: Bool) {
    
        DispatchQueue.main.async { [weak self] in
            self?.isHidden = isHidden
        }
    }
    
    public func setup(labelPlaceholder: PagoLabelPresenter) {
        
        activityIndicatorView.stopAnimating()
        imageView.contentMode = viewPresenter.style.contentMode
        if let size = self.viewPresenter.style.size {
            self.widthConstraint?.constant = size.width
            self.heightConstraint?.constant = size.height
            self.widthConstraint?.isActive = size.width > 0
            self.heightConstraint?.isActive = size.height > 0
        } else {
            self.widthConstraint?.isActive = false
            self.heightConstraint?.isActive = false
        }
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(self.viewPresenter.style.backgroundCornerRadius)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat(self.viewPresenter.style.cornerRadius)
        self.backgroundColor = self.viewPresenter.style.backgroundColorType.color
        
        //TODO: Refactor when needed
        if label != nil {
            label?.removeFromSuperview()
        }
        
        label = PagoLabel(presenter: labelPlaceholder)
        if let label = label {
            label.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(label)
            label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            label.topAnchor.constraint(equalTo: topAnchor).isActive = true
            label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            label.alpha = viewPresenter.style.alpha
        }
        imageView.image = nil
        layoutIfNeeded()
    }
    
    public func setup(image: UIImage.Pago) {
        
        activityIndicatorView.stopAnimating()
        imageView.contentMode = viewPresenter.style.contentMode
        if let size = self.viewPresenter.style.size {
            self.widthConstraint?.constant = size.width
            self.heightConstraint?.constant = size.height
            self.widthConstraint?.isActive = size.width > 0
            self.heightConstraint?.isActive = size.height > 0
        } else {
            self.widthConstraint?.isActive = false
            self.heightConstraint?.isActive = false
        }
        imageView.alpha = viewPresenter.style.alpha
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(self.viewPresenter.style.backgroundCornerRadius)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat(self.viewPresenter.style.cornerRadius)
        self.backgroundColor = self.viewPresenter.style.backgroundColorType.color
       
        setupImage(with: image)
        layoutIfNeeded()
    }

    
    public func setup(data: Data) {
        
        activityIndicatorView.stopAnimating()
        imageView.contentMode = viewPresenter.style.contentMode
        if let size = self.viewPresenter.style.size {
            self.widthConstraint?.constant = size.width
            self.heightConstraint?.constant = size.height
            self.widthConstraint?.isActive = size.width > 0
            self.heightConstraint?.isActive = size.height > 0
        } else {
            self.widthConstraint?.isActive = false
            self.heightConstraint?.isActive = false
        }
        imageView.alpha = viewPresenter.style.alpha
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(self.viewPresenter.style.backgroundCornerRadius)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat(self.viewPresenter.style.cornerRadius)
        self.backgroundColor = self.viewPresenter.style.backgroundColorType.color
        
        setupImage(with: data)
        layoutIfNeeded()
    }
    
    public func resizeImage(width: CGFloat, height: CGFloat) {

        guard width > 0, height > 0 else { return }
        let aspectRatio = width / height
        if let size = self.viewPresenter.style.size, size.width ==  0 || size.height == 0 {
            if size.width > 0, size.height == 0 {
                let height = aspectRatio * -1 * size.width
                self.heightConstraint?.constant = height
                self.heightConstraint?.isActive = true
            }

            if size.height > 0, size.width == 0 {
                let width = aspectRatio * size.height
                self.widthConstraint?.constant = width
                self.widthConstraint?.isActive = true
            }
        }

    }
    
    public func setup(backend: BackendImage) {
        
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(self.viewPresenter.style.backgroundCornerRadius)
        imageView.alpha = viewPresenter.style.alpha
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat(self.viewPresenter.style.cornerRadius)
        self.backgroundColor = self.viewPresenter.style.backgroundColorType.color
        let url = URL(string: backend.url)
        self.activityIndicatorView.startAnimating()
        let placeholder = backend.placeholderImageName.isEmpty ? UIImage() : UIImage(named: backend.placeholderImageName)
        
        self.resizeImage(width: placeholder?.size.width ?? 0, height: placeholder?.size.height ?? 0)

        self.datasource?.loadImage(imageView: self.imageView, urlString: url, placeholderImage: placeholder, completion: { [weak self] image in
            DispatchQueue.main.async { [weak self] in
                
                guard let self = self,
                      let image = image else {
                    self?.activityIndicatorView.stopAnimating()
                    return
                }
                
                self.resizeImage(width: image.size.width, height: image.size.height)
                self.setupBackendImage(with: image)
            }
        })
        
        imageView.contentMode = viewPresenter.style.contentMode
        if let size = self.viewPresenter.style.size {
            self.widthConstraint?.constant = size.width
            self.heightConstraint?.constant = size.height
            self.widthConstraint?.isActive = size.width > 0
            self.heightConstraint?.isActive = size.height > 0
        } else {
            self.widthConstraint?.isActive = false
            self.heightConstraint?.isActive = false
        }
        layoutIfNeeded()
    }
    
    private func setupImage() {
        
        let isBlackAndWhite = viewPresenter.style.isBlackAndWhite
        let currentImage = imageView.image
        
        if isBlackAndWhite {
            self.imageView.image = currentImage?.blackAndWhiteImage()
        } else if let tintColor = self.viewPresenter.style.tintColorType?.color {
            self.imageView.image = currentImage?.tint(with: tintColor)
        } else {
            self.imageView.image = currentImage
        }
        
    }
    
    private func setupImage(with image: UIImage.Pago) {
        
        let isBlackAndWhite = viewPresenter.style.isBlackAndWhite
        
        if isBlackAndWhite {
            self.imageView.image = image.image?.blackAndWhiteImage()
        } else if let tintColorType = self.viewPresenter.style.tintColorType {
            self.imageView.image = image.image(tinted: tintColorType)
        } else {
            self.imageView.image = image.image
        }
        
    }
    
    private func setupImage(with data: Data) {
        
        let isBlackAndWhite = viewPresenter.style.isBlackAndWhite
        
        if isBlackAndWhite {
            self.imageView.image = UIImage(data: data)?.blackAndWhiteImage()
        } else if let tintColor = self.viewPresenter.style.tintColorType?.color {
            self.imageView.image = UIImage(data: data)?.withRenderingMode(.alwaysTemplate)
            self.imageView.tintColor = tintColor
        } else {
            self.imageView.image = UIImage(data: data)
        }
    }
    
    private func setupBackendImage(with image: UIImage) {
        
        let isBlackAndWhite = viewPresenter.style.isBlackAndWhite
        
        if isBlackAndWhite {
            self.imageView.image = image.blackAndWhiteImage()
            self.activityIndicatorView.stopAnimating()
        } else if let tintColor = self.viewPresenter.style.tintColorType?.color {
            image.bw { bw in
                bw?.tint(color: tintColor) { bw in
                    let backgroundColor = self.viewPresenter.style.backgroundColorType.color
                    self.imageView.backgroundColor = backgroundColor
                    self.imageView.image = bw
                    self.activityIndicatorView.stopAnimating()
                }
            }
        } else {
            let backgroundColor = self.viewPresenter.style.backgroundColorType.color
            self.imageView.backgroundColor = backgroundColor
            self.imageView.image = image
            self.activityIndicatorView.stopAnimating()
        }
    }
    
}
