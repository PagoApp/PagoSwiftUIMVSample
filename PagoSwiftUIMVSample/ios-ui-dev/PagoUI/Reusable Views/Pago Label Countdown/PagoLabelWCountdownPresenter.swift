//
//  PagoLabelWCountdown.swift
//  Pago
//
//  Created by Andrei Chirita on 04.06.2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//

import Foundation

public protocol PagoLabelWCountdownPresenterDelegate: AnyObject {
    func countdownEnd()
}

public protocol PagoLabelWCountdownPresenterView: PresenterView {
    func setupLabel(presenter: PagoLabelPresenter)
}

open class PagoLabelWCountdownPresenter: BasePresenter {
    
    public weak var delegate : PagoLabelWCountdownPresenterDelegate?
    
    private var view: PagoLabelWCountdownPresenterView? { return basePresenterView as? PagoLabelWCountdownPresenterView }

    internal let label: PagoLabelPresenter
    
    internal var model: PagoLabelWCountdownModel {
        get { return (self.baseModel as! PagoLabelWCountdownModel) }
        set { baseModel = newValue }
    }

    public init(model: PagoLabelWCountdownModel) {
        
        label = PagoLabelPresenter(model: model.label)
        super.init(model: model)
    }
    
    internal func loadData() {
        
        view?.setupLabel(presenter: label)
    }
    
    public func startCountdown() {

        countdown()
    }
    
    private func countdown() {
        
        let time = model.endDate.timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate
        if time > 0 {
            let text = String(format: model.text, formatTimeToCountdown(time: time))
            label.update(text: text)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.countdown()
            }
        } else {
            delegate?.countdownEnd()
        }
    }
    
    private func formatTimeToCountdown(time: TimeInterval) -> String {
        let time = Int(time)
        let hours = time / (60 * 60)
        let minutes = (time % (60 * 60)) / 60
        let seconds = time % 60
        var result = ""
        if hours > 0 {
            result += String(format: "%dh ", hours)
        }
        if minutes > 0 || hours > 0 {
            result += String(format: "%dm ", minutes)
        }
        if model.format == .explicit {
            result += String(format: "%ds", seconds)
        }
        return result
    }
    
}
