//
//  
//  PagoButtonsRepository.swift
//  PagoUI_Sandbox
//
//  Created by LoredanaBenedic on 14.03.2023.
//
//
import PagoUISDK
import Foundation
import UIKit

class PagoButtonsRepository: BaseViewControllerRepository<PagoButtonsPredicate, PagoButtonsModel> {
    
    override func getLocalData(predicate: PagoButtonsPredicate, completion: @escaping (PagoButtonsModel) -> ()) {
        var model = PagoButtonsModel()
		model.styles = DataRepository.getPagoButtonStyles()
		model.models = getModels(styles: model.styles)
        completion(model)
    }
    
    override func getRemoteData(predicate: PagoButtonsPredicate, completion: @escaping (PagoButtonsModel) -> ()) {
        getLocalData(predicate: predicate, completion: completion)
    }
    
	private func getModels(styles: [PagoButtonStyle?]) -> [PagoButtonModel] {
		
		var models: [PagoButtonModel] = []
		for style in styles {
			
			if let style = style {
				let model = PagoButtonModel(title: "Click me", style: style)
				models.append(model)
			}
		}
		return models
	}
}
