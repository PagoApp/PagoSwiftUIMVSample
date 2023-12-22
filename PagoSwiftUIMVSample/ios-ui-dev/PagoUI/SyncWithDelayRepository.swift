//
//  SyncWithDelayRepository.swift
//  PagoUISDK
//
//  Created by Gabi on 03.08.2022.
//

import Foundation

open class SyncWithDelayRepository<T, M>: BaseRepository<T, M> {

    open func isLocalDataEmpty(predicate: T, completion: @escaping (Bool)->()) {
        completion(false)
    }
    
    open var isSyncTime: Bool {
        return false
    }
    
    open func getRemoteData(predicate: T, completion: @escaping (M)->()) {
        fatalError("This method is mandatory")
    }
    
    open func getLocalData(predicate: T, completion: @escaping (M)->()) {
        fatalError("This method is mandatory")
    }
    
    public final func hasToFetchFromRemote(predicate: T, completion: @escaping (Bool)->()) {
        isLocalDataEmpty(predicate: predicate) { [weak self] isEmptyDb in
            guard let self = self else { return }
            let shouldFetchfromRemote = isEmptyDb || self.isSyncTime
            completion(shouldFetchfromRemote)
        }
    }

    public override func getData(predicate: T, completion: @escaping (M) -> ()) {
        hasToFetchFromRemote(predicate: predicate) { [weak self] fetchFromRemote in
            guard let self = self else { return }
            if fetchFromRemote {
                self.getRemoteData(predicate: predicate, completion: completion)
            } else {
                self.getLocalData(predicate: predicate, completion: completion)
            }
        }
    }
}
