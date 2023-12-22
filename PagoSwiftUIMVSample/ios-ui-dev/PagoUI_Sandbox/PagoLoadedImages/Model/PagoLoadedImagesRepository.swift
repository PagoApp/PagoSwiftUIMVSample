//
//  
//  PagoLoadedImagesRepository.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 21.11.2023.
//
//
import PagoUISDK
import Foundation
import UIKit

internal class PagoLoadedImagesRepository: BaseViewControllerRepository<PagoLoadedImagesPredicate, PagoLoadedImagesModel> {
    
    internal override func getLocalData(predicate: PagoLoadedImagesPredicate, completion: @escaping (PagoLoadedImagesModel) -> ()) {
        let model = PagoLoadedImagesModel()
        completion(model)
    }
    
    internal override func getRemoteData(predicate: PagoLoadedImagesPredicate, completion: @escaping (PagoLoadedImagesModel) -> ()) {
        let model = PagoLoadedImagesModel()
        completion(model)
    }
    
}
