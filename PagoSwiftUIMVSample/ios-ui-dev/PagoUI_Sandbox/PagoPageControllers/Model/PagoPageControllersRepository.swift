//
//  
//  PagoPageControllersRepository.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 21.11.2023.
//
//
import PagoUISDK
import Foundation
import UIKit

internal class PagoPageControllersRepository: BaseViewControllerRepository<PagoPageControllersPredicate, PagoPageControllersModel> {
    
    internal override func getLocalData(predicate: PagoPageControllersPredicate, completion: @escaping (PagoPageControllersModel) -> ()) {
        let model = PagoPageControllersModel()
        completion(model)
    }
    
    internal override func getRemoteData(predicate: PagoPageControllersPredicate, completion: @escaping (PagoPageControllersModel) -> ()) {
        let model = PagoPageControllersModel()
        completion(model)
    }
    
}
