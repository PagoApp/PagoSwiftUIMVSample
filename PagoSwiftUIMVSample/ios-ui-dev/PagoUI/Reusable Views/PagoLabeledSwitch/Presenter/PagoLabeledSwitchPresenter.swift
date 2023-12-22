//
//  
//  PagoLabeledSwitchPresenter.swift
//  PagoUISDK
//
//  Created by Gabi on 10.08.2022.
//
//


public protocol PagoLabeledSwitchPresenterView: PresenterView {
    func setup(presenter: PagoStackedInfoPresenter)
}

public protocol PagoLabeledSwitchPresenterDelegate: AnyObject {
    func didUpdateSwitch(presenter: PagoLabeledSwitchPresenter)
}

public class PagoLabeledSwitchPresenter: BasePresenter {

    public weak var delegate: PagoLabeledSwitchPresenterDelegate?
    private(set) var containerStack: PagoStackedInfoPresenter!
    private(set) var labelPresenter: PagoLabelPresenter!
    public private(set) var switchPresenter: PagoSwitchPresenter!
    public var switchValue: Bool {
        get { switchPresenter.isOn }
    }
    
    private var model: PagoLabeledSwitchModel {
        get { baseModel as! PagoLabeledSwitchModel }
        set { baseModel = newValue }
    }
    private var view: PagoLabeledSwitchPresenterView? {
        return basePresenterView as? PagoLabeledSwitchPresenterView
    }
    
    public override init(model: Model = EmptyModel()) {
        
        super.init(model: model)
        containerStack = PagoStackedInfoPresenter(model: self.model.containerModel)
        switchPresenter = PagoSwitchPresenter(model: self.model.switchModel)
        switchPresenter.delegate = self
        labelPresenter = PagoLabelPresenter(model: self.model.labelModel)
    }
    
    public func update(isOn: Bool) {
        switchPresenter.isOn = isOn
        delegate?.didUpdateSwitch(presenter: self)
    }
    
    public func loadData() {
        
        view?.setup(presenter: containerStack)
        containerStack.addLabel(presenter: labelPresenter)
        containerStack.addSwitch(presenter: switchPresenter)
    }
}

extension PagoLabeledSwitchPresenter: PagoSwitchPresenterDelegate {
    
    public func didUpdateSwitch(presenter: PagoSwitchPresenter) {
        delegate?.didUpdateSwitch(presenter: self)
    }
    
}
