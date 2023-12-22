//
//  
//  PagoButtonPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 29/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import Foundation
import UIKit

public protocol PagoButtonPresenterView: PresenterView {
    
    func update(accessibility: PagoAccessibility)
    func hide(_ hidden: Bool)
    func reloadStyle(isTouching: Bool)
    func updateUI()
    func updateTitle(text: String)
}

public protocol PagoButtonPresenterDelegate: AnyObject {

    func didTap(button: PagoButtonPresenter)
}

open class PagoButtonPresenter: BasePresenter {

    public weak var delegate: PagoButtonPresenterDelegate?
    
    public var style: PagoButtonStyle { return isEnabled ? activeStyle : inactiveStyle }
    public var borderStyle: BorderStyle? { return style.borderStyle }
    private var highlightedStyle: PagoButtonStyle { return model.highlightedStyle ?? model.style }
    private var inactiveStyle: PagoButtonStyle { return model.inactiveStyle ?? model.style }
    private var activeStyle: PagoButtonStyle { return isTouching ? highlightedStyle : model.style }
    
    public var accessibility: PagoAccessibility { return model.accessibility }
    public var hasCustomHighlightStyle: Bool { return model.highlightedStyle != nil }
    public var placeholderStyle: HighlightedStyle? { return style.placeholderStyle }
    public var isSelfSized: Bool { return model.isSelfSized }
    public var customHeight: CGFloat? { return style.height }
    public var customWidth: CGFloat? { return style.width }
    
    public var index: Int { return model.index }
    public var isEnabled: Bool {
        get { return model.isEnabled }
        set {
            let oldValue = model.isEnabled
            model.isEnabled = newValue
            if oldValue != newValue {
                view?.reloadStyle(isTouching: false)
            }
            let title = "\(model.title ?? "") \(newValue ? "" : "7e91cdaa-2bec-4587-8172-0c0ccb04e2d2".localized)"
            var accessibility = model.accessibility
            accessibility.accessibilityLabel = title
            view?.update(accessibility: accessibility)
        }
    }
    public var hasBadge: Bool {
        return model.badge != nil
    }
    
    public var isTouching: Bool = false
    
    public var highlightedText: String? {
        return model.highlightedText
    }
    
    public var backgroundColorType: UIColor.Pago {
        return style.backgroundColor
    }
    
    public var startBackgroundColorType: UIColor.Pago? {
        return style.startBackgroundColor
    }
    
    public var endBackgroundColorType: UIColor.Pago? {
        return style.endBackgroundColor
    }
    
    public var titleColorType: UIColor.Pago {
        return style.textColor
    }
    
    public var fontType: UIFont.Pago {
        return style.font
    }
    
    public var hasShadow: Bool {
        return style.shadowStyle != nil && isEnabled
    }

    public var cornerRadius: Int {
        return style.cornerRadius
    }
    
    public var model: PagoButtonModel {
        get { return (self.baseModel as! PagoButtonModel) }
        set { baseModel = newValue }
    }
    
    public var imagePresenter: PagoLoadedImageViewPresenter!
    public var badgePresenter: PagoBadgePresenter?
    
    internal var buttonLeadingSpace: CGFloat {
        return imagePresenter.model.style.size == .zero ? 0 : 8
    }

    public var hasTitle: Bool {
        return title.count > 0
    }
    
    public var title: String {
        get { return model.title ?? "" }
        set { model.title = newValue }
    }
    
    public var hasImage: Bool {
        return model.imageView == nil ? false : true
    }
    public var dummyImageModel = PagoLoadedImageViewModel(imageData: PagoImage(image: .none), style: PagoImageViewStyle(size: .zero))

    public override func update(model: Model) {
    
        super.update(model: model)
        if let model = model as? PagoButtonModel {
            if let imageModel = model.imageView {
                imagePresenter.update(model: imageModel)
            }
            if let badgePredicate = model.badge {
                badgePresenter?.update(predicate: badgePredicate)
            }
        }
        
        reloadData()
    }
    
    private var view: PagoButtonPresenterView? { return basePresenterView as? PagoButtonPresenterView }

    public var isHidden: Bool = false {
        didSet {
            view?.hide(isHidden)
        }
    }

    public func update(title: String, highlightedText: String? = nil) {
        
        model.title = title
        if let highlighted = highlightedText {
            model.highlightedText = highlighted
        }
        view?.updateTitle(text: title)
    }
    
    public func update(imageStyle: PagoImageViewStyle) {
        
        imagePresenter.update(style: imageStyle)
    }
    
    public func update(buttonStyle: PagoButtonStyle) {
        
        model.style = buttonStyle
        reloadData()
    }

    public func loadData() {

        let imageModel = model.imageView ?? dummyImageModel
        imagePresenter = PagoLoadedImageViewPresenter(model: imageModel)
        if let badgePredicate = model.badge {
            badgePresenter = PagoBadgePresenter(predicate: badgePredicate)
        }
        view?.updateUI()
        view?.updateTitle(text: title)
    }
    
    public func reloadData() {
        
        let imageModel = model.imageView ?? dummyImageModel
        imagePresenter.update(model: imageModel)
        view?.updateUI()
        view?.updateTitle(text: title)
    }
    
    internal func didTap() {
        
        touchUp()
        view?.updateUI()
        delegate?.didTap(button: self)
    }
    
    internal func touchUp() {
        
        isTouching = false
        view?.reloadStyle(isTouching: false)
    }
    
    internal func touchDown() {
        
        isTouching = true
        view?.reloadStyle(isTouching: true)
    }
    
    public func updateBadge(text: String) {
        
        badgePresenter?.update(text: text)
    }
    
    public func hideBadge() {
        
        badgePresenter?.hide()
    }
    
    public func showBadge() {
        
        badgePresenter?.show()
    }
}
