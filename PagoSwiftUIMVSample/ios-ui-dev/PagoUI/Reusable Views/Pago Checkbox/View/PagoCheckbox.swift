//
//  
//  PagoCheckbox.swift
//  Pago
//
//  Created by Gabi Chiosa on 29/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation

open class PagoCheckbox: BaseView {
    
    var titleLabel: UILabel!
    var imageView: PagoLoadedImageView!
    var contentView: UIView!
    var focusView: UIView!
    
    private var heightConstraint: NSLayoutConstraint?
    private var minHeightConstraint: NSLayoutConstraint?
    private var widthConstraint: NSLayoutConstraint?
    private var contentViewLeadingConstraint: NSLayoutConstraint?
    private var contentViewTrailingConstraint: NSLayoutConstraint?
    private var contentViewTopConstraint: NSLayoutConstraint?
    private var contentViewBottomConstraint: NSLayoutConstraint?
    
    private var imageHeightConstraint: NSLayoutConstraint?
    
    var viewPresenter: PagoCheckboxPresenter! {
        return (presenter as! PagoCheckboxPresenter)
    }
    
    public init(presenter: PagoCheckboxPresenter) {
        
        super.init(frame: .zero)

        self.presenter = presenter

        initSubviews()
        setup(presenter: presenter)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        initSubviews()
    }
    
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        initSubviews()
    }
    
    private func initSubviews() {

        self.translatesAutoresizingMaskIntoConstraints = false
        presenter.setView(mView: self)

        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentView)
        viewPresenter.setView(mView: self)

        contentViewLeadingConstraint = self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.viewPresenter.style.contentInset.left)
        contentViewTrailingConstraint = self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.viewPresenter.style.contentInset.right)
        contentViewTopConstraint = self.contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: self.viewPresenter.style.contentInset.top)
        contentViewBottomConstraint = self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.viewPresenter.style.contentInset.bottom)
        contentViewLeadingConstraint?.isActive = true
        contentViewTrailingConstraint?.isActive = true
        contentViewTopConstraint?.isActive = true
        contentViewBottomConstraint?.isActive = true
        
        heightConstraint = contentView.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint?.isActive = false
        minHeightConstraint = contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        minHeightConstraint?.isActive = false
        widthConstraint = contentView.widthAnchor.constraint(equalToConstant: 0)
        widthConstraint?.isActive = false
        
        imageView = PagoLoadedImageView(presenter: viewPresenter.imagePresenter)
		imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        imageHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: CGFloat(viewPresenter.style.imageSize.size))
        imageHeightConstraint?.isActive = true
        
        titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func setup(presenter: PagoCheckboxPresenter) {

        loadData()
        titleLabel.isAccessibilityElement = false
        focusView.isAccessibilityElement = false
        contentView.isAccessibilityElement = false
        imageView.isAccessibilityElement = false
        updateAccessibilityLabel(value: presenter.accessibility.accessibilityLabel)
    }
    
    public override func reloadView() {
        
        loadData()
    }

    @objc func focus() {

        guard let viewPresenter = viewPresenter else { return }
        if viewPresenter.isUserInteractionEnabled {
            viewPresenter.toggleSelection()
		} else {
			viewPresenter.handleDisabledTap()
		}
    }
    
    @objc func showInfo() {
        
        viewPresenter?.showInfo()
    }

    private func loadData() {

        var focusArea = UIView()
        
        let focusHeight = CGFloat(40)
        let focusWidth = CGFloat(40)
        
        if viewPresenter?.hasInfo == true {
            
            focusArea.backgroundColor = .clear
            contentView.addSubview(focusArea)
            focusArea.translatesAutoresizingMaskIntoConstraints = false
            focusArea.widthAnchor.constraint(equalToConstant: focusWidth).isActive = true
            focusArea.heightAnchor.constraint(equalToConstant: focusHeight).isActive = true
            focusArea.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
            focusArea.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
            
            let infoArea = UIView()
            infoArea.backgroundColor = .clear
            infoArea.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(infoArea)
            infoArea.leadingAnchor.constraint(equalTo: focusArea.trailingAnchor).isActive = true
            infoArea.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            infoArea.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            infoArea.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            
            let infoTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.showInfo))
            infoArea.isUserInteractionEnabled = true
            infoArea.addGestureRecognizer(infoTapGestureRecognizer)
            
        } else if viewPresenter.title.isEmpty {
           
            imageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor).isActive = true
            imageView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor).isActive = true
            contentView.addSubview(focusArea)
            focusArea.translatesAutoresizingMaskIntoConstraints = false
            focusArea.widthAnchor.constraint(equalToConstant: focusWidth).isActive = true
            focusArea.heightAnchor.constraint(equalToConstant: focusHeight).isActive = true
            focusArea.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
            focusArea.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        } else {

            focusArea = contentView
        }
        let focusTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.focus))
        focusArea.isUserInteractionEnabled = true
        focusArea.addGestureRecognizer(focusTapGestureRecognizer)
        viewPresenter.loadState()
        focusView = focusArea

        layoutIfNeeded()
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let pointForTarget = focusView.convert(point, from: self)
        
        if focusView.bounds.contains(pointForTarget) {
            return focusView.hitTest(pointForTarget, with: event)
        }
        return super.hitTest(point, with: event)
    }

}

extension PagoCheckbox: PagoCheckboxPresenterView {
    
    func hideView(isHidden: Bool) {
        
        self.isHidden = isHidden
    }
    
    func update(style: PagoCheckboxStateStyle) {
        
        DispatchQueue.main.async {
            let defaultAttributes = NSAttributedString.toAttributes(font: style.fontType, color: style.fontColorType)
            let title = self.viewPresenter.title
            self.titleLabel.attributedText = NSAttributedString(string: title, attributes: defaultAttributes)
            self.imageView.reloadView()
            
            var minHeight = self.titleLabel.frame.size.height
            if self.imageView.frame.size.height > minHeight {
                minHeight = self.imageView.frame.size.height
            }
            self.minHeightConstraint?.constant = minHeight
            self.minHeightConstraint?.isActive = true
            
            if self.viewPresenter.style.hasBackground == true {
                self.backgroundColor = style.backgroundColor.color
                self.layer.cornerRadius = CGFloat(PagoCheckboxStyle.customStyle.cornerRadius)
            }
            self.clipsToBounds = true
            if let size = self.viewPresenter.style.size {
                if let height = size.height {
                    self.heightConstraint?.constant = height
                    self.heightConstraint?.isActive = true
                } else {
                    self.heightConstraint?.isActive = false
                }
                
                if let width = size.width {
                    self.widthConstraint?.constant = width
                    self.widthConstraint?.isActive = true
                } else {
                    self.widthConstraint?.isActive = false
                }
            } else {
                self.heightConstraint?.isActive = false
                self.widthConstraint?.isActive = false
            }
        }
    }
    
    func update(title: String) {
        
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.text = title
            self?.updateAccessibilityLabel(value: title)
        }
    }
    
    func update(accessibility: PagoAccessibility) {
        
        isAccessibilityElement = accessibility.isAccessibilityElement
        accessibilityTraits = accessibility.accessibilityTraits
        updateAccessibilityLabel(value: accessibility.accessibilityLabel)
    }
    
    func updateAccessibilityLabel(value: String?) {
        
        accessibilityLabel = String.init(format: viewPresenter.isSelected ? "0f313080-6863-4259-81bb-cc96e1ad9a5c".localized : "28b0a124-ee9e-4bcb-95fe-20ecbd7dc2b1".localized, value ?? "")
    }
}
