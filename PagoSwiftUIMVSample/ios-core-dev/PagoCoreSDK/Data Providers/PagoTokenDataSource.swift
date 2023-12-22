//
//  File.swift
//  
//
//  Created by Gabi on 11.05.2022.
//

import Foundation

public protocol PagoTokenDataSource: AnyObject {
    func getNewToken(completion: @escaping (PagoOperationStatus<PagoToken>)->())
}
