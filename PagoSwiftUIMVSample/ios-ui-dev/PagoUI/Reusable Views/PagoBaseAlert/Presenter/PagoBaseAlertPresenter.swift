//
//  
//  PagoBaseAlertPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

public protocol PagoBaseAlertPresenterView: ViewControllerPresenterView {
    func setupTopHeader()
    func resetBackground(colorType: UIColor.Pago, animationTime: Double)
    func dismissBackground(completion: @escaping ()->())
}

public protocol PagoBaseAlertPresenterDelegate: AnyObject {
    
    func dismiss()
}


public class PagoBaseAlertPresenter: ViewControllerPresenter {

    weak var delegate: PagoBaseAlertPresenterDelegate?
    private var model: PagoBaseAlertModel {
        get { return baseModel as! PagoBaseAlertModel }
        set { baseModel = newValue }
    }
    private var repository: PagoBaseAlertRepository { return baseRepository as! PagoBaseAlertRepository }
    private var view: PagoBaseAlertPresenterView? { return self.basePresenterView as? PagoBaseAlertPresenterView }
    var backgroundColor: UIColor.Pago { return repository.backgroundColor }
    var backgroundAnimationTime: Double { return repository.backgroundAnimationTime }
    
    override public func loadData() {
        
        super.loadData()
        view?.setupTopHeader()
    }
    
    func dismissView(offset: CGFloat) {
        
        if offset < 0 {
            let percent = min(abs(offset) / 25, 1)
            if percent >= 1 {
                dismiss()
            }
        } else {
            view?.resetBackground(colorType: backgroundColor, animationTime: backgroundAnimationTime)
        }
    }
    
    func dismiss() {
        
        delegate?.dismiss()
    }
}
