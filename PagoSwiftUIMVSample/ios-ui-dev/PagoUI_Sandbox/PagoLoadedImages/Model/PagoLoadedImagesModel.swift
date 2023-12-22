//
//  
//  PagoLoadedImagesModel.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 21.11.2023.
//
//
import PagoUISDK
import UIKit

internal struct PagoLoadedImagesModel: Model {
            
    internal var imageStackModel: PagoStackedInfoModel  {

        let urls = ["https://pago.ro/assets/sdk/bt/img_car_intro.png",
                    "https://pago.ro/assets/sdk/bt/img_car_list_empty.png",
                    "https://assets.pago.ro/sdk/bcr/bills/img_providers_empty_list.png",
                    "https://assets.pago.ro/sdk/bcr/bills/img_sync_provider_success_history.png"]
        let imageModels = urls.map({getImageModel(url: $0)})
        
        let stackStyle = PagoStackedInfoStyle(backgroundColor: .white, distribution: .fill, alignment: .center, axis: .vertical)
        return PagoStackedInfoModel(models: imageModels, style: stackStyle)
    }
    
    
    private func getImageModel(url: String) -> PagoLoadedImageViewModel {
        
        let dataImageModel = BackendImage(url: url, placeholderImageName: "")
        let imageStyle = PagoImageViewStyle(size: CGSize(width: 260, height: 260))
        let imageModel = PagoLoadedImageViewModel(imageData: dataImageModel, style: imageStyle)
        return imageModel
    }

}
