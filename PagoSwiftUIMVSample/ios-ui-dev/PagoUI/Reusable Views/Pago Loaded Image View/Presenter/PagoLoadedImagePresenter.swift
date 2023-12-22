//
//  
//  PagoLoadedImagePresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 31/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import Foundation
import UIKit

public protocol PagoLoadedImageViewPresenterView: PresenterView {
    func hide(isHidden: Bool)
    func setup(backend: BackendImage)
    func setup(data: Data)
    func setup(image: UIImage.Pago)
    func setup(labelPlaceholder: PagoLabelPresenter)
}

open class PagoLoadedImageViewPresenter: BasePresenter {

    public var model: PagoLoadedImageViewModel {
        get { baseModel as! PagoLoadedImageViewModel }
        set { baseModel = newValue }
    }
    public var isHidden: Bool = false {
        didSet {
            view?.hide(isHidden: isHidden)
        }
    }
    public var accessibility: PagoAccessibility { return model.accessibility }
    public var style: PagoImageViewStyle { return model.style }
    public var view: PagoLoadedImageViewPresenterView? { return basePresenterView as? PagoLoadedImageViewPresenterView }
    
    internal func loadData() {
        
        switch model.imageData {
        case is BackendImage:
            let imageURL: String = (model.imageData as! BackendImage).url
            let imagePlaceholder: String = (model.imageData as! BackendImage).placeholderImageName
            let backend = BackendImage(url: imageURL, placeholderImageName: imagePlaceholder)
            view?.setup(backend: backend)
        case is DataImage:
            view?.setup(data: (model.imageData as! DataImage).data)
        case is PagoImage:
            view?.setup(image: (model.imageData as! PagoImage).image)
        case is PlaceholderLabelImage:
            let labelModel = (model.imageData as! PlaceholderLabelImage).label
            let labelPresenter = PagoLabelPresenter(model: labelModel)
            view?.setup(labelPlaceholder: labelPresenter)
        default:
            break
        }
    }
    
    public override func update(model: Model) {
        
        super.update(model: model)
        loadData()
    }
    
    public func update(style: PagoImageViewStyle) {
        
        model.style = style
        view?.reloadView()
    }
    
    
    @available(*, deprecated, message: "Use update(image: DataImageModel) instead")
    public func update(image: PagoImage?) {

        model.imageData = image ?? PagoImage(image: .none)
        view?.reloadView()
    }
    
    public func update(image: DataImageModel) {
        
        model.imageData = image
        loadData()
    }
    
    public func reload() {
        
        view?.reloadView()
    }
}
