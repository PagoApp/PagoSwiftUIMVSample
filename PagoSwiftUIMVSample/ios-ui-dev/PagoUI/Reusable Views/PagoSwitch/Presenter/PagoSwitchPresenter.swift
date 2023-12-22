//
//  
//  PagoSwitchPresenter.swift
//  PagoUISDK
//
//  Created by Gabi on 10.08.2022.
//
//


public protocol PagoSwitchPresenterView: PresenterView {
    func update(style: PagoSwitchStyle)
    func update(isOn: Bool)
}

public protocol PagoSwitchPresenterDelegate: AnyObject {
    func didUpdateSwitch(presenter: PagoSwitchPresenter)
}

public class PagoSwitchPresenter: BasePresenter {

    public weak var delegate: PagoSwitchPresenterDelegate?
    public var isOn: Bool {
        get { return model.isOn }
        set { model.isOn = newValue }
    }
    private(set) var containerStack: PagoStackedInfoPresenter!
    private(set) var labelPresenter: PagoLabelPresenter!
    private(set) var fieldPresenter: PagoTextFieldPresenter!
    private var model: PagoSwitchModel {
        get { baseModel as! PagoSwitchModel }
        set { baseModel = newValue }
    }
    private var view: PagoSwitchPresenterView? {
        return basePresenterView as? PagoSwitchPresenterView
    }

    public func loadData() {
        
        view?.update(style: model.style)
        view?.update(isOn: isOn)
    }
    
    public func didSwitch() {
        
        isOn = !isOn
        delegate?.didUpdateSwitch(presenter: self)
    }
    
    public func update(isON: Bool) {
        view?.update(isOn: isON)
    }

}
