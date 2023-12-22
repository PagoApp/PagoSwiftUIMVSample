//
//  
//  PagoEmailConfirmationPredicate.swift
//  PagoRCASDK
//
//  Created by Gabi on 19.10.2022.
//
//

public struct PagoEmailConfirmationPredicate: PagoPredicate {
    
    let screenTitle: String
    let detail: String
    let image: DataImageModel
    var action: String?
    let validationRules: [ValidationRuleModel]
    
    public init(screenTitle: String, detail: String, image: DataImageModel, action: String? = nil, validationRules: [ValidationRuleModel]) {
        
        self.screenTitle = screenTitle
        self.detail = detail
        self.image = image
        self.action = action
        self.validationRules = validationRules
    }
}
