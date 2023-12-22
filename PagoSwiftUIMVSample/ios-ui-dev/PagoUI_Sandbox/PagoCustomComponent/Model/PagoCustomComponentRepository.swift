//
//  
//  PagoCustomComponentRepository.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 21.11.2023.
//
//
import PagoUISDK
import Foundation
import UIKit

internal class PagoCustomComponentRepository: BaseViewControllerRepository<PagoCustomComponentPredicate, PagoCustomComponentModel> {
    
    internal override func getLocalData(predicate: PagoCustomComponentPredicate, completion: @escaping (PagoCustomComponentModel) -> ()) {
        getCustomData(completion: completion)
    }
    
    internal override func getRemoteData(predicate: PagoCustomComponentPredicate, completion: @escaping (PagoCustomComponentModel) -> ()) {
        getCustomData(completion: completion)
    }
        
    
    private func getCustomData(completion: @escaping (PagoCustomComponentModel) -> ()) {
        
        let components: [PagoStackedInfosModel] = ["A", "B", "C", "D"].map({getCustomComponent(identifier: $0)})
        let model = PagoCustomComponentModel(components: components)
        completion(model)
    }
    
        
    private func getCustomComponent(identifier: String) -> PagoStackedInfosModel  {
        
        return PagoStackedInfosModel(fieldText: "TextField \(identifier)", fieldPlaceholder: "Placeholder \(identifier)", fieldDetail: "Detail \(identifier)", labelText: "Label \(identifier)")
    }

    
}
