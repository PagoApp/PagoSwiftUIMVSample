//
//  
//  PagoAlertPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import Foundation

public protocol PagoAlertPresenterView: PagoBaseAlertPresenterView {
    func setup(header: PagoStackedInfoPresenter)
    func setup(option: PagoStackedInfoPresenter, hasSeparator: Bool)
    func setup(button: PagoStackedInfoPresenter)
    func setupFooter()
    func setup(datePicker: PagoDatePickerPresenter)
}

public protocol PagoAlertPresenterDelegate: PagoBaseAlertPresenterDelegate {
    
    func didTap(index: Int, dismiss: Bool)
    func didChangeDate(date: Date?)
}

public class PagoAlertPresenter: PagoBaseAlertPresenter {

    var mDelegate: PagoAlertPresenterDelegate? {
        return delegate as? PagoAlertPresenterDelegate
    }
    
    public var isSelfDismissing = true
    private var model: PagoAlertModel {
        get { return baseModel as! PagoAlertModel }
        set { baseModel = newValue }
    }
    private var repository: PagoAlertRepository { return baseRepository as! PagoAlertRepository }
    private var view: PagoAlertPresenterView? { return self.basePresenterView as? PagoAlertPresenterView }
    private var header: PagoStackedInfoPresenter?
    private var options = [BasePresenter]()
    public var style: PagoAlertStyle? { return model.style }
    
    override public func loadData() {
        
        super.loadData()
        baseRepository = PagoAlertRepository()
        if let headerModel = model.header {
            let headerPresenter = PagoStackedInfoPresenter(model: headerModel)
            view?.setup(header: headerPresenter)
            self.header = headerPresenter
        }

        let models: [BasePresenter] = model.options.compactMap({ option in
            if let option = option as? PagoStackedInfoModel {
                let presenter = PagoStackedInfoPresenter(model: option)
                return presenter
            } else if let option = option as? PagoButtonModel {
                let presenter = PagoButtonPresenter(model: option)
                return presenter
            } else if let option = option as? PagoDatePickerModel {
                let presenter = PagoDatePickerPresenter(model: option)
                return presenter
            }
            return nil
        })
        
        for (i, option) in models.enumerated() {
            if let presenter = option as? PagoStackedInfoPresenter {
                presenter.delegate = self
                let hasSeparator = i < options.count - 1
                view?.setup(option: presenter, hasSeparator: hasSeparator)
                if presenter.hasUserInteraction {
                    options.append(presenter)
                }
            } else if let presenter = option as? PagoButtonPresenter {
                presenter.delegate = self
                let stack = PagoStackedInfoPresenter(model: model.buttonStackModel)
                view?.setup(button: stack)
                stack.addButton(presenter: presenter)
                options.append(presenter)
            } else if let presenter = option as? PagoDatePickerPresenter {
                presenter.delegate = self
                view?.setup(datePicker: presenter)
            }
        }
        
    }
    
    func showLoader() {
        view?.showOverlayLoading()
    }
    
    func hideLoader() {
        view?.hideOverlayLoading()
    }
}

extension PagoAlertPresenter: PagoStackedInfoPresenterDelegate {
    
    public func didTap(presenter: PagoStackedInfoPresenter) {
        
        var index: Int?

        //TODO: We should only use hasCustomIndex implicit == true to avoid any wrong uses for indexes
        if style?.hasCustomIndex == true {
            index = presenter.index
        } else {
            index = options.firstIndex(of: presenter)
        }
        
        guard let index = index else { return }

        if isSelfDismissing {
            view?.dismissBackground { [weak self] in
                guard let self = self else { return }
                self.mDelegate?.didTap(index: index, dismiss: self.isSelfDismissing)
            }
        } else {
            mDelegate?.didTap(index: index, dismiss: isSelfDismissing)
        }
    }
}

extension PagoAlertPresenter: PagoButtonPresenterDelegate {
    
    public func didTap(button: PagoButtonPresenter) {
        
        guard let index = options.firstIndex(of: button) else { return }
        
        if isSelfDismissing {
            view?.dismissBackground { [weak self] in
                guard let self = self else { return }
                self.mDelegate?.didTap(index: index, dismiss: self.isSelfDismissing)
            }
        } else {
            mDelegate?.didTap(index: index, dismiss: isSelfDismissing)
        }
    }
}

extension PagoAlertPresenter: PagoDatePickerPresenterDelegate {

    public func didUpdate(presenter: PagoDatePickerPresenter) {

        mDelegate?.didChangeDate(date: presenter.selectedValue)
    }
}
