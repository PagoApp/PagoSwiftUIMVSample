//
//  
//  PagoInformativePresenter.swift
//  PagoUISDK
//
//  Created by Gabi on 10.08.2022.
//
//

public protocol PagoInformativePresenterView: PresenterView {
    func setup(presenter: PagoStackedInfoPresenter)
}

public protocol PagoInformativePresenterDelegate: AnyObject {
    func didTapInformative(presenter: PagoInformativePresenter)
}

public class PagoInformativePresenter: BasePresenter {

    public weak var delegate: PagoInformativePresenterDelegate?
    private(set) var containerStack: PagoStackedInfoPresenter!
    private(set) var labelPresenter: PagoLabelPresenter!
    private(set) var imagePresenter: PagoLoadedImageViewPresenter!
    private var model: PagoInformativeModel {
        get { baseModel as! PagoInformativeModel }
        set { baseModel = newValue }
    }
    private var view: PagoInformativePresenterView? {
        return basePresenterView as? PagoInformativePresenterView
    }
    
    public override init(model: Model = EmptyModel()) {
        
        super.init(model: model)
        containerStack = PagoStackedInfoPresenter(model: self.model.containerModel)
        containerStack.delegate = self
        imagePresenter = PagoLoadedImageViewPresenter(model: self.model.iconModel)
        labelPresenter = PagoLabelPresenter(model: self.model.labelModel)
    }
    
    public func loadData() {
        
        view?.setup(presenter: containerStack)
        containerStack.addLoadedImage(presenter: imagePresenter)
        containerStack.addLabel(presenter: labelPresenter)
    }

}

extension PagoInformativePresenter: PagoStackedInfoPresenterDelegate {
    
    public func didTap(presenter: PagoStackedInfoPresenter) {
        
        delegate?.didTapInformative(presenter: self)
    }
}
