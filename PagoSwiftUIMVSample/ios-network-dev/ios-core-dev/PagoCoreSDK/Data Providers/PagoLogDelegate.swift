//
//  PagoLogDelegate.swift
//  PagoSDK
//
//  Created by Gabi on 12.05.2022.
//

import Foundation

public protocol PagoLogDelegate: AnyObject {
    func willLog(_ log: PagoLog)
}
