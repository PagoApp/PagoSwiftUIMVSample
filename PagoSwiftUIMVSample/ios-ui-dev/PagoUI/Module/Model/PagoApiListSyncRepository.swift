//
//  PagoApiListSyncRepository.swift
//  PagoUISDK
//
//  Created by Gabi on 14.10.2022.
//

import Foundation

open class PagoApiListSyncRepository<T, M>: SyncWithDelayRepository<T, M> {
    
    open var state: PagoApiState = .started
    open var viewType: PagoApiDataType = .list
    
    open override func getRemoteData(predicate: T, completion: @escaping (M) -> ()) {
        
        state = .started
    }
    
    open override func getLocalData(predicate: T, completion: @escaping (M) -> ()) {
        
        state = .started
    }
    
    public final func didCompleteGet(model list: [Model]) {
    
        viewType = getViewType(model: list)
        state = .completed
    }
    
    final func getViewType(model list: [Model]) -> PagoApiDataType {
        
        return list.count > 0 ? .list : .details
    }
}
