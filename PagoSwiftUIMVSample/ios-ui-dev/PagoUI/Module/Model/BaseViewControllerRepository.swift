//
//  BaseViewControllerRepository.swift
//  PagoUISDK
//
//  Created by Gabi on 23.07.2022.
//

import UIKit

open class BaseViewControllerRepository<T, M>: SyncWithDelayRepository<T, M> {
    
    public func getEmptySceenModel(imageData: DataImageModel, title: String, detail: String, action: String? = nil, topStack: PagoStackedInfoModel? = nil, extraStack: PagoStackedInfoModel? = nil, actionPosition: PagoEmptyListScreenModel.ActionPosition = .bottom, stackBackgroundColor: UIColor.Pago? = nil) -> PagoEmptyListScreenModel {
        
        let imageStyle = PagoImageViewStyle(size: CGSize(width: 124, height: 124), contentMode: .scaleAspectFit)
        let imageModel = PagoLoadedImageViewModel(imageData: imageData, style: imageStyle)
        
        let emptyModel = PagoEmptyListScreenModel(imageModel: imageModel, titleText: title, detailText: detail, actionText: action, topStack: topStack, bottomStack: extraStack, actionPosition: actionPosition, stackBackgroundColor: stackBackgroundColor)
        return emptyModel
    }
    
    open var emptyListScreenModel: PagoEmptyListScreenModel? {
        //NOTE: Override for empty screen model
        return nil
    }
    
    open var screenLoaderModel: PagoStackedInfoModel? {
        
        let animation = PagoDataAnimation(animation: .statusLoadingBT)
        let animLoadingModel = PagoLoadedAnimationModel(animationType: animation, loop: true, style: PagoAnimationStyle(size: CGSize(width: 40, height: 40)))
        let infoStackStyle = PagoStackedInfoStyle(backgroundColor: .clear, distribution: .fill, alignment: .center, axis: .vertical, spacing: 8)
        let stackModel = PagoStackedInfoModel(models: [animLoadingModel], style: infoStackStyle)
        return stackModel
    }
    
    open var screenLoaderBackground: UIColor.Pago {
        
        return .blackWithAlpha(0.2)
    }
    
    
    //TODO: Add array for more button if needed
    open var navigationButtonModel: PagoButtonModel? {
        //NOTE: Override for empty screen model
        return nil
    }
}
