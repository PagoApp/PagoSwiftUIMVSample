//
//  
//  PagoMenusRepository.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 01.11.2023.
//
//
import PagoUISDK
import Foundation
import UIKit

internal class PagoMenusRepository: BaseViewControllerRepository<PagoMenusPredicate, PagoMenusModel> {
    
    internal override func getLocalData(predicate: PagoMenusPredicate, completion: @escaping (PagoMenusModel) -> ()) {
        let model = PagoMenusModel()
        completion(model)
    }
    
    internal override func getRemoteData(predicate: PagoMenusPredicate, completion: @escaping (PagoMenusModel) -> ()) {
        let model = PagoMenusModel()
        completion(model)
    }
    
}
