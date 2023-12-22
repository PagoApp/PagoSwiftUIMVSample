//
//  BaseRepository.swift
//  PagoUISDK
//
//  Created by Gabi on 23.07.2022.
//

import Foundation

open class BaseRepository<T, M>: PagoRepository {

    public init () {}
    open func getData(predicate: T, completion: @escaping (M)->()) {}
}
