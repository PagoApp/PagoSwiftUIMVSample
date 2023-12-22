//
//  PagoLogger.swift
//  PagoCoreSDK
//
//  Created by Gabi on 18.07.2022.
//

import Foundation

public struct PagoLogger {
    
    weak var delegate: PagoLogDelegate?
    
    private let subsystem: String
    private let category: String
    
    public init(subsystem: String, category: String) {
        
        self.subsystem = subsystem
        self.category = category
    }

    public func debug(_ log: String) {
        
        let log = PagoLog(message: log)
        delegate?.willLog(log)
//        print(log.message)
    }
}
