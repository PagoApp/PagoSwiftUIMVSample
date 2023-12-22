//
//  
//  PagoEmailConfirmationRepository.swift
//  PagoRCASDK
//
//  Created by Gabi on 19.10.2022.
//
//
import PagoUISDK
import Foundation
import UIKit

public class PagoEmailConfirmationRepository: BaseViewControllerRepository<PagoEmailConfirmationPredicate, PagoEmailConfirmationModel> {
    
    public override func getLocalData(predicate: PagoEmailConfirmationPredicate, completion: @escaping (PagoEmailConfirmationModel) -> ()) {
        
        let model: PagoEmailConfirmationModel
        if let action = predicate.action {
            model = PagoEmailConfirmationModel(detail: predicate.detail, image: predicate.image, action: action, emailValidation: predicate.validationRules)
        } else {
            model = PagoEmailConfirmationModel(detail: predicate.detail, image: predicate.image, emailValidation: predicate.validationRules)
        }
        
        completion(model)
    }
    
    public override func getRemoteData(predicate: PagoEmailConfirmationPredicate, completion: @escaping (PagoEmailConfirmationModel) -> ()) {
        getLocalData(predicate: predicate, completion: completion)
    }
    
}
