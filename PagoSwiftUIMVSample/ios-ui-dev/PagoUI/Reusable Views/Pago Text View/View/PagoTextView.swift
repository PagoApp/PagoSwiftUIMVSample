//
//
//  PagoTextView.swift
//  Pago
//
//  Created by Gabi Chiosa on 13/05/2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//
import UIKit

open class PagoTextView: BaseView {

    private var interactionView: PagoView!
    private var contentView: PagoView!
    private var textViewContainer: PagoView!
    private var textView: UITextView!
    private var placeholder: PagoLabel!
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    private var counterView: PagoLabel?
    private var viewPresenter: PagoTextViewPresenter { return (presenter as! PagoTextViewPresenter) }
    private var tapRecognizer: UITapGestureRecognizer!

    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func tapHandler() {

        interactionView.isUserInteractionEnabled = false
        interactionView.removeGestureRecognizer(tapRecognizer)
        viewPresenter.startEditing()
    }

    public init(presenter: PagoTextViewPresenter) {
        
        super.init(frame: .zero)
        setup(presenter: presenter)
    }

    public func setup(presenter: PagoTextViewPresenter) {
        
        self.presenter = presenter
        self.presenter.setView(mView: self)
        presenter.loadData()
    }
}

extension PagoTextView: PagoTextViewPresenterView {
    
    public func didLayoutView() {
        
        textView.centerVertically()
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    
        guard let textTemp = textView.text else { return false }
        let finalString = (textTemp as NSString).replacingCharacters(in: range, with: text)
        let trimmed = finalString.replacingOccurrences(of: "\n", with: "")
        return viewPresenter.canUpdate(text: trimmed)
    }
    
    public func setup(style: PagoTextViewStyle) {
        
        textView.font = style.fontType.font
        textView.textColor = style.textColorType.color
        textView.textAlignment = style.alignment
        if let maxNrOflines = style.numberOfLines {
            textView.textContainer.maximumNumberOfLines = maxNrOflines
        }
        textView.isScrollEnabled = false
        contentView.backgroundColor = style.backgroundColorType.color
        
        if let border = style.borderStyle {
            textViewContainer.borderColor = border.colorType.cgColor
            textViewContainer.borderWidth = border.width
        }
        
        if let radius = style.cornerRadius {
            textViewContainer.layer.cornerRadius = CGFloat(radius)
            textViewContainer.clipsToBounds = true
        }
        
        layoutIfNeeded()
    }
    
    public func setup(width: CGFloat) {
        
        let width = textView.widthAnchor.constraint(equalToConstant: width)
        width.isActive = true
        widthConstraint = width
    }
    
    public func setup(height: CGFloat) {
        
        let height = textView.heightAnchor.constraint(equalToConstant: height)
        height.isActive = true
        heightConstraint = height
    }
    
    public func setupUI(hasCounter: Bool) {

        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear

        contentView = PagoView()
        contentView.backgroundColor = .clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentView)
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        textViewContainer = PagoView()
        textViewContainer.backgroundColor = .clear
        textViewContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textViewContainer)
        textViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        textViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        textViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
        if !hasCounter {
            textViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        }
        
        textView = UITextView()
        textView.delegate = self
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textViewContainer.addSubview(textView)
        
        //TODO: Add inset to support margin handle
        textView.leadingAnchor.constraint(equalTo: textViewContainer.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: textViewContainer.trailingAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: textViewContainer.topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: textViewContainer.bottomAnchor).isActive = true
        
        placeholder = PagoLabel()
        placeholder.backgroundColor = .clear
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(placeholder)
        placeholder.leadingAnchor.constraint(equalTo: textView.leadingAnchor).isActive = true
        placeholder.trailingAnchor.constraint(equalTo: textView.trailingAnchor).isActive = true
        placeholder.topAnchor.constraint(equalTo: textView.topAnchor).isActive = true
        //TODO: Add handle for placeholder which remains at the top of the text view. now it will expand after the text view
        placeholder.bottomAnchor.constraint(equalTo: textView.bottomAnchor).isActive = true
        
        interactionView = PagoView()
        interactionView.backgroundColor = .clear
        interactionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(interactionView)
        interactionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        interactionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        interactionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        interactionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        interactionView.isUserInteractionEnabled = true
        interactionView.addGestureRecognizer(tapRecognizer)
    }

    public func setup(counter: PagoLabelPresenter) {
        
        let counterView = PagoLabel(presenter: counter)
        counterView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(counterView)
        counterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        counterView.topAnchor.constraint(equalTo: textViewContainer.bottomAnchor, constant: 8).isActive = true
        counterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        self.counterView = counterView
    }
    
    public func setup(placeholder: PagoLabelPresenter) {
        
        self.placeholder.setup(presenter: placeholder)
    }
    
    public func focusTextView() {
            
        textView.becomeFirstResponder()
    }
    
    public func hidePlaceholder() {
        
        placeholder.isHidden = true
    }
    
    public func showPlaceholder() {
        
        placeholder.isHidden = false
    }
}

extension PagoTextView: UITextViewDelegate {

    public func textViewDidChange(_ textView: UITextView) {
        
        let trimmed = textView.text.replacingOccurrences(of: "\n", with: "")
        viewPresenter.update(text: trimmed)
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        
        viewPresenter.stopEditing()
        interactionView.isUserInteractionEnabled = true
        interactionView.addGestureRecognizer(tapRecognizer)
    }
    
    
}


public extension UITextView {
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
}
