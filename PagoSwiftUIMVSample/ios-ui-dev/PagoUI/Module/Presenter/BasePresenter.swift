//
//  BasePresenterT.swift
//  Pago
//
//  Created by Bogdan-Gabriel Chiosa on 06/12/2019.
//  Copyright © 2019 cleversoft. All rights reserved.
//

import Foundation
import UIKit


open class BasePresenter: Presenter, Equatable {
    
    public static func == (lhs: BasePresenter, rhs: BasePresenter) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    let uuid = UUID().uuidString
    public var baseModel: Model!
    public weak var basePresenterView: PresenterView?
    
    public init(model: Model = EmptyModel()) {
        
        self.baseModel = model
    }
    
    public func update(model: Model) {
        
        self.baseModel = model
    }
    
    public func setView(mView: PresenterView) {
        
        self.basePresenterView = mView
    }
    
    public func isInBounds<T>(source: [T], index: Int) -> Bool {
        
        return index < source.count
    }
    
    public func rotate(to angle: Double) {
        self.basePresenterView?.rotate(to: angle)
    }
}
