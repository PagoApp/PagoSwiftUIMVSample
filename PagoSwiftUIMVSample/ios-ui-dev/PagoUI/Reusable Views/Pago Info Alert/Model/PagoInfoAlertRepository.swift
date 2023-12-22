//
//  PagoInfoAlertRepository.swift
//  Pago
//
//  Created by Gabi Chiosa on 30.03.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation
import UIKit

class PagoInfoAlertRepository: PagoBaseAlertRepository {
	
	func getData(predicate: PagoPredicate) -> Model? {
		
		guard let repoPredicate = predicate as? PagoInfoAlertPredicate else { return nil }
		
		let width = UIScreen.main.bounds.width - 48
		
		var imageModel: PagoLoadedImageViewModel? = nil
		if let infoType = repoPredicate.infoType {
			var image: UIImage.Pago?
			switch infoType {
			case .confirmation:
				image = .checkmark
			case .warning:
				image = .warning
			case .error:
				image = .error
			}
			if let image = image {
				let pagoImage = PagoImage(image: image)
				let imageSize = CGSize(width: width, height: 20)
				let imageStyle = PagoImageViewStyle(size: imageSize, contentMode: .scaleAspectFit)
				imageModel = PagoLoadedImageViewModel(imageData: pagoImage, style: imageStyle)
			}
		}
		
		var titleModel: PagoLabelModel? = nil
		if let titleText = repoPredicate.title {
			let style = PagoLabelStyle(customStyle: .blackBold16, size: PagoSize(width: width, height: nil), alignment: .center, numberOfLines: 0)
			titleModel = PagoLabelModel(text: titleText, style: style)
		}
		
		var messageModel: PagoLabelModel? = nil
		if let messageText = repoPredicate.message {
			let style = PagoLabelStyle(customStyle: .greyRegular14, size: PagoSize(width: width, height: nil), alignment: .center, numberOfLines: 0)
			messageModel = PagoLabelModel(text: messageText, style: style)
		}
		
		return PagoInfoAlertModel(imageModel: imageModel, titleModel: titleModel, detailModel: messageModel)
	}
}
