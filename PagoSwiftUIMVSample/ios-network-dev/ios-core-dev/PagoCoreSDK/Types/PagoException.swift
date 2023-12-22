//
//  PagoException.swift
//  PagoCoreSDK
//
//  Created by Gabi on 27.05.2022.
//

import Foundation

public enum PagoException: Error, Equatable {
    case missing(String)
    case invalid(String)
}
