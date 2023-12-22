//
//
//  PagoLabelView.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation

open class PagoLabel: BaseView {
    
    private var label: BaseLabel!
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    private var viewPresenter: PagoLabelPresenter { return (presenter as! PagoLabelPresenter) }

    lazy var tapGesture: UITapGestureRecognizer = {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        tapRecognizer.cancelsTouchesInView = false
        return tapRecognizer
    }()
    
    public override func reloadView() {
        super.reloadView()
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.populateData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI(size: nil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI(size: nil)
    }
    
    override open var intrinsicContentSize: CGSize {
        let width = label.intrinsicContentSize.width + viewPresenter.style.inset.left + viewPresenter.style.inset.right
        let height = label.intrinsicContentSize.height + viewPresenter.style.inset.top + viewPresenter.style.inset.bottom
        return CGSize(width: width , height: height)
    }
    
    func populateData() {

        label.textAlignment = viewPresenter.style.alignment
        label.lineBreakMode = viewPresenter.style.lineBreakMode
        label.numberOfLines = viewPresenter.style.numberOfLines
        label.delegate = self
        var attributedText = NSMutableAttributedString()
            
        let text = viewPresenter.text

        if let replacements = viewPresenter.imagePlaceholders, replacements.count > 0 {
            
            if replacements.count == 1, let replacement = replacements.first  {
                attributedText = NSMutableAttributedString(attributedString: text.attributedString(key: replacement.key, image: replacement.image.image ?? UIImage(), imageHeight: replacement.height, yOffset: replacement.yOffset))
                
            } else {
                attributedText = NSMutableAttributedString(attributedString: text.attributedString(replacements: replacements.map({$0.toReplacement()})))
            }
            
            let attributes = NSAttributedString.toAttributes(font: viewPresenter.style.fontType, color: viewPresenter.style.textColorType, striked: viewPresenter.style.isStriked, paragraphStyle: viewPresenter.style.paragraphStyle)
            attributedText.addAttributes(attributes, range: NSRange(location: 0, length: attributedText.length))

        } else {

            attributedText = NSMutableAttributedString(attributedString: viewPresenter.text.toAttributed(font: viewPresenter.style.fontType, color: viewPresenter.style.textColorType, striked: viewPresenter.style.isStriked, paragraphStyle: viewPresenter.style.paragraphStyle))
        }
        
        if let placeholders = viewPresenter.placeholders {
            placeholders.forEach {
                attributedText.update(style: $0.replacement)
            }
            if viewPresenter.hasAction {
                // needed in order to capture the link tap
                label.isUserInteractionEnabled = true
            }
        }

        if viewPresenter.style.isAllCaps {
            label.attributedText = attributedText.uppercased()
        } else {
            label.attributedText = attributedText
        }

        if let tintColor = viewPresenter.style.tintColorType?.color {
            label.tintColor = tintColor
        }
        self.backgroundColor = viewPresenter.style.backgroundColorType.color
        if let contentCompression = viewPresenter.style.contentCompressionResistance {
            label.setContentCompressionResistancePriority(contentCompression.priority, for: contentCompression.axis)
        }
        if let contentHugging = viewPresenter.style.contentHuggingPriority {
            label.setContentHuggingPriority(contentHugging.priority, for: contentHugging.axis)
        }
        if let width = self.viewPresenter.style.size?.width {
            self.widthConstraint?.constant = width
        }
        
        if let height = self.viewPresenter.style.size?.height {
            self.heightConstraint?.constant = height
        }
        
        if let border = viewPresenter.style.borderStyle {
            self.borderColor = border.colorType.cgColor
            self.borderWidth = border.width
        }
        
        if let labelRadius = viewPresenter.style.cornerRadius {
            self.layer.cornerRadius = CGFloat(labelRadius)
            self.clipsToBounds = true
        }
        
        layoutIfNeeded()
        
        label.isAccessibilityElement = false
        let accessibility = viewPresenter.accessibility
        isAccessibilityElement = accessibility.isAccessibilityElement
        accessibilityTraits = accessibility.accessibilityTraits
        accessibilityLabel = accessibility.accessibilityLabel ?? attributedText.string
        
        if viewPresenter.hasAction {
            self.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func tapHandler() {

        viewPresenter.handleTap()
    }
    
    public init(presenter: PagoLabelPresenter) {
        
        super.init(frame: .zero)
        setupUI(size: presenter.style.size)
        presenter.setView(mView: self)
        setup(presenter: presenter)
    }
    
    public func setup(presenter: PagoLabelPresenter) {
        
        self.presenter = presenter
        self.presenter.setView(mView: self)
        setupConstraints()
        populateData()
    }
    
    private func setupConstraints() {
        
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: viewPresenter.style.inset.left).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -viewPresenter.style.inset.right).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: viewPresenter.style.inset.top).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -viewPresenter.style.inset.bottom).isActive = true
    }

    private func setupUI(size: PagoSize?) {

        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        label = BaseLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)

        if let sizeWidth = size?.width {
            let width = label.widthAnchor.constraint(equalToConstant: sizeWidth)
            width.isActive = true
            widthConstraint = width
        }
        
        if let sizeHeight = size?.height {
            let height = label.heightAnchor.constraint(equalToConstant: sizeHeight)
            height.isActive = true
            heightConstraint = height
        }
    }
}

extension PagoLabel: PagoLabelPresenterView {
    
    public func hideView(isHidden: Bool) {
        
        self.isHidden = isHidden
    }
}

extension PagoLabel: BaseLabelDelegate {

    func didTap(url: String) {
        viewPresenter.didTap(url: url)
    }
}
