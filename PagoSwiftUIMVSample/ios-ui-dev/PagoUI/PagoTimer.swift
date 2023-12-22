//
//  PagoTimer.swift
//  Pago
//
//  Created by Gabi Chiosa on 16/09/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import Foundation

open class PagoTimer {

    private var completionHandler: (() -> ())?
    private let timeInterval: TimeInterval
    private lazy var timer: DispatchSourceTimer = {
        let t = DispatchSource.makeTimerSource()
        t.schedule(deadline: .now() + self.timeInterval)
        t.setEventHandler(handler: { [weak self] in
            self?.completionHandler?()
        })
        return t
    }()
    
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    func start(completion: @escaping ()->()) {
        
        completionHandler = completion
        timer.resume()
    }
    
    func stop() {
        
        timer.setEventHandler {}
        timer.cancel()
        completionHandler = nil
        
    }
    
    deinit {
        stop()
    }
}
