//
//  PagoOperationStatus.swift
//  
//
//  Created by Gabi on 11.05.2022.
//

import Foundation

public enum PagoOperationStatus<T> {
    case success(T)
    case error(Error)

    public var isSuccess: Bool {
        switch self {
        case .success(_):
            return true
        default:
            return false
        }
    }
    
    public var result: T? {
        guard isSuccess else { return nil }
        switch self {
        case .success(let result):
            return result
        default:
            return nil
        }
    }
    
    public var error: Error? {
        guard !isSuccess else { return nil }
        switch self {
        case .error(let error):
            return error
        default:
            return nil
        }
    }
}
