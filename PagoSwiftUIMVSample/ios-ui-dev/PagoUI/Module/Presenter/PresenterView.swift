//
//  PresenterViewT.swift
//  Pago
//
//  Created by Bogdan-Gabriel Chiosa on 05/12/2019.
//  Copyright © 2019 cleversoft. All rights reserved.
//

import UIKit

public protocol PresenterView: AnyObject {
    
    func reloadView()
    func rotate(to angle: Double)
}

extension PresenterView {
    public func rotate(to angle: Double) {}
}
