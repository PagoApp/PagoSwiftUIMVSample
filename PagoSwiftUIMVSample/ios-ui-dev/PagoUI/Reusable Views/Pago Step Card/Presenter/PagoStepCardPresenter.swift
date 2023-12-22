//
//  
//  PagoStepCardPresenter.swift
//  PagoRCASDK
//
//  Created by Gabi on 10.08.2022.
//
//

import PagoUISDK
//TODO: Add PagoCore dependency in PagoUI
//import PagoCoreSDK

public protocol PagoStepCardPresenterView: PresenterView {
    func setup(presenter: PagoStackedInfoPresenter)
    func hide(isHidden: Bool)
}

public protocol PagoStepCardPresenterDelegate: AnyObject {
    func didTapStep(presenter: PagoStepCardPresenter)
}

public class PagoStepCardPresenter: BasePresenter {

    public var isHidden: Bool = false {
        didSet {
            view?.hide(isHidden: isHidden)
        }
    }
    public weak var delegate: PagoStepCardPresenterDelegate?
    public var stepType: PagoStepCardType { return model.step }
    
    private(set) var containerStackPresenter: PagoStackedInfoPresenter!
    private(set) var labelsStackPresenter: PagoStackedInfoPresenter!
    private(set) var labelStepPresenter: PagoLabelPresenter!
    private(set) var checkStepPresenter: PagoLoadedImageViewPresenter!
    private(set) var titleLabelPresenter: PagoLabelPresenter!
    private(set) var detailLabelPresenter: PagoLabelPresenter!
    
    private var model: PagoStepCardModel {
        get { baseModel as! PagoStepCardModel }
        set { baseModel = newValue }
    }
    private var index: Int {
        get { return model.index }
        set { model.index = newValue }
    }
    private var detail: String {
        get { return model.detail }
        set { model.detail = newValue }
    }
    private var step: PagoStepCardType {
        get { return model.step }
        set { model.step = newValue }
    }
    private var view: PagoStepCardPresenterView? {
        return basePresenterView as? PagoStepCardPresenterView
    }
    
    public override init(model: Model = EmptyModel()) {
        
        super.init(model: model)
        containerStackPresenter = PagoStackedInfoPresenter(model: self.model.containerModel)
        containerStackPresenter.delegate = self
        labelStepPresenter = PagoLabelPresenter(model: self.model.labelModel)
        titleLabelPresenter = PagoLabelPresenter(model: self.model.titleLabelModel)
        detailLabelPresenter = PagoLabelPresenter(model: self.model.detailLabelModel)
        checkStepPresenter = PagoLoadedImageViewPresenter(model: self.model.checkBoxImageModel)
    }
    
    public func loadData() {
        
        let verticalStackPresenter = PagoStackedInfoPresenter(model: model.labelsContainerStack)
        let disclosurePresenter = PagoLoadedImageViewPresenter(model: model.disclosureModel)
        view?.setup(presenter: containerStackPresenter)
        containerStackPresenter.addLoadedImage(presenter: checkStepPresenter)
        containerStackPresenter.addLabel(presenter: labelStepPresenter)
        containerStackPresenter.addInfoStack(presenter: verticalStackPresenter)
        verticalStackPresenter.addLabel(presenter: titleLabelPresenter)
        verticalStackPresenter.addLabel(presenter: detailLabelPresenter)
        if let extraModel = model.extra {
            let extraPresenter = PagoStackedInfoPresenter(model: extraModel)
            verticalStackPresenter.addInfoStack(presenter: extraPresenter)
        }
        containerStackPresenter.addLoadedImage(presenter: disclosurePresenter)
        update(step: model.step)
    }
    
    public func update(step: PagoStepCardType) {
        
        self.step = step
        if step == .completed {
            checkStepPresenter.isHidden = false
            labelStepPresenter.isHidden = true
        } else {
            checkStepPresenter.isHidden = true
            labelStepPresenter.isHidden = false
        }
    }
    
    public func update(detail: String) {
        
        self.detail = detail
        detailLabelPresenter.update(text: detail)
    }
    
    public override func update(model: Model) {
        
        super.update(model: model)
        loadData()
    }
    
    public func update(index: Int) {
        
        self.index = index
//        self.labelStepPresenter.update(text: index.toString)
        self.labelStepPresenter.update(text: String(index))
    }
}

extension PagoStepCardPresenter: PagoStackedInfoPresenterDelegate {
    
    public func didTap(presenter: PagoStackedInfoPresenter) {
        
        delegate?.didTapStep(presenter: self)
    }
}
