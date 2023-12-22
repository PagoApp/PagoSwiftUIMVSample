//
//  BaseTableViewControllerRepository.swift
//  PagoUISDK
//
//  Created by Gabi on 23.07.2022.
//

import Foundation

open class BaseTableViewControllerRepository<T, M>: BaseViewControllerRepository<T, M> {
    
    lazy var loadingCellModels: [PagoLoadingCellModel] = {
        let loadingModel = PagoLoadingCellModel()
        let loadingModels = [loadingModel, loadingModel, loadingModel, loadingModel, loadingModel, loadingModel, loadingModel, loadingModel]
        return loadingModels
    }()

}
