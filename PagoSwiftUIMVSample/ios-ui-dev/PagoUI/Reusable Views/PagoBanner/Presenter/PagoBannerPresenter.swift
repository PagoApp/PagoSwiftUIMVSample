//
//  
//  PagoBannerPresenter.swift
//  PagoRCASDK
//
//  Created by Gabi on 13.10.2022.
//
//

import Foundation

public protocol PagoBannerPresenterView: PresenterView {
    func setup(presenter: PagoStackedInfoPresenter)
}

public protocol PagoBannerPresenterDelegate: AnyObject {
    func pagoBannerDidTap(presenter: PagoBannerPresenter)
    func pagoBannerDidTapBlocked(remaining: Int64, presenter: PagoBannerPresenter)
}

public class PagoBannerPresenter: BasePresenter {

    public weak var delegate: PagoBannerPresenterDelegate?

    private(set) var containerPresenter: PagoStackedInfoPresenter!
    private(set) var titlePresenter: PagoLabelPresenter?
    private(set) var detailPresenter: PagoLabelPresenter?
    private(set) var actionPresenter: PagoButtonPresenter?
    private(set) var remainingInactiveSeconds: Int64 = 0
    private var repeater: PagoRepeater = PagoRepeater()
    
    private var model: PagoBannerModel {
        get { baseModel as! PagoBannerModel }
        set { baseModel = newValue }
    }
    private var view: PagoBannerPresenterView? {
        return basePresenterView as? PagoBannerPresenterView
    }
    
    public override init(model: Model = EmptyModel()) {
        
        super.init(model: model)
        
        containerPresenter = PagoStackedInfoPresenter(model: self.model.containerModel)
        if let titleModel = self.model.titleModel {
            titlePresenter = PagoLabelPresenter(model: titleModel)
        }
        if let detailModel = self.model.detailModel {
            detailPresenter = PagoLabelPresenter(model: detailModel)
        }
        if let actionModel = self.model.actionModel {
            actionPresenter = PagoButtonPresenter(model: actionModel)
            if let blocked = self.model.blockActionForSeconds {
                blockActionFor(seconds: blocked)
            }
        }
    }
    
    public func blockActionFor(seconds: Int) {
        
        remainingInactiveSeconds = Int64(seconds)
        self.actionPresenter?.isEnabled = false
        let update: (Int)->() = { [weak self] time in
            self?.remainingInactiveSeconds = Int64(time)
        }
        
        let completion: ()->() = { [weak self] in
            self?.actionPresenter?.isEnabled = true
        }
        
        repeater.startTimer(time: seconds, update: update, completion: completion)
    }
    
    public func loadData() {
        
        view?.setup(presenter: containerPresenter)
        
        if let titlePresenter = titlePresenter {
            containerPresenter.addLabel(presenter: titlePresenter)
        }
        if let detailPresenter = detailPresenter {
            containerPresenter.addLabel(presenter: detailPresenter)
        }
        if let actionPresenter = actionPresenter {
            let actionTopSpacePresenter = PagoSpacePresenter(model: model.actionTopSpaceModel)
            containerPresenter.addSpace(presenter: actionTopSpacePresenter)
            containerPresenter.addButton(presenter: actionPresenter)
            actionPresenter.delegate = self
        }
    }

}

extension PagoBannerPresenter: PagoButtonPresenterDelegate {
    
    public func didTap(button: PagoButtonPresenter) {
        
        if button.isEnabled {
            delegate?.pagoBannerDidTap(presenter: self)
        } else {
            delegate?.pagoBannerDidTapBlocked(remaining: remainingInactiveSeconds, presenter: self)
        }
    }
}
