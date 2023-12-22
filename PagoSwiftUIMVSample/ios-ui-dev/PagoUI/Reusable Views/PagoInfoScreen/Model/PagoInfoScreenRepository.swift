//
//  PagoInfoScreenRepository.swift
//  Pago
//
//  Created by Gabi Chiosa on 29/09/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

class PagoInfoScreenRepository: PagoRepository {
    
    func getData(predicate: PagoPredicate) -> Model? {
        guard let repoPredicate = predicate as? PagoInfoScreenBasePredicate else { return nil }

        var titleModel: PagoLabelModel?
        if let titleText = repoPredicate.title {
            titleModel = PagoLabelModel(text: titleText, style: PagoLabelStyle(textColorType: .blackBodyText, fontType: .bold24, backgroundColorType: .clear, alignment: .center, lineBreakMode: .byWordWrapping, numberOfLines: 0))
        }

        var errorModel: PagoLabelModel?
        if let error = repoPredicate.error {
            let errorStyle = PagoLabelStyle(textColorType: .redNegative, fontType: .medium15, backgroundColorType: .lightRedBackground, alignment: .center, numberOfLines: 0, cornerRadius: 18, inset: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
            errorModel = PagoLabelModel(text: error, style: errorStyle)
        }
        var detailText: String? = repoPredicate.detail
        //NOTE: We don't support replacement string custom initialisation in here. the string MUST be already composed when passed to the model
        // Don't pass %@ or other equivalant formats
        let placeholderModels: [PagoPlaceholderModel]? = repoPredicate.placeholders
        let imagePlaceholders = repoPredicate.detailImagePlaceholders

        var detailModel: PagoLabelModel?
        if let detailText = detailText {
            detailModel = PagoLabelModel(text: detailText, imagePlaceholders: imagePlaceholders, placeholders: placeholderModels, style: PagoLabelStyle(textColorType: .darkGraySecondaryText, fontType: .regular17, backgroundColorType: .clear, alignment: .center, lineBreakMode: .byWordWrapping, numberOfLines: 0), hasAction: repoPredicate.hasDetailInteraction)
        }

        var mainAction: PagoButtonModel?
        if let mainActionTitle = repoPredicate.mainButton {
            mainAction = PagoButtonModel(title: repoPredicate.mainButton, isEnabled: true, type: .main)
        }

        var secondaryAction: PagoButtonModel?
        if let secondaryT = repoPredicate.secondaryButton {
            secondaryAction = PagoButtonModel(title: secondaryT.title, isEnabled: secondaryT.delay == 0, style: PagoButtonStyle.style(for: .tertiaryActive), inactiveStyle: PagoButtonStyle.style(for: .tertiaryInactive))
        }

        let imageWidth = CGFloat(DeviceSizeHelper.smallerScreen ? 200 : 260)
        let imageSize = CGSize(width: imageWidth, height: imageWidth)

        if let noImagePredicate = repoPredicate as? PagoNoImageInfoScreenPredicate {
            let model = PagoInfoScreenModel(image: nil, title: titleModel, detail: detailModel, error: errorModel, extra: noImagePredicate.extra, mainAction: mainAction, secondaryAction: secondaryAction, footer: noImagePredicate.footer)
            return model
        } else if let simplePredicate = repoPredicate as? PagoInfoScreenPredicate {
            let imageModel = PagoImageViewModel(imageType: simplePredicate.imageType, style: PagoImageViewStyle(size: imageSize))
            let imageHeader = PagoInfoScreenSimpleImage(image: imageModel)
            let model = PagoInfoScreenModel(image: imageHeader, title: titleModel, detail: detailModel, error: errorModel, extra: simplePredicate.extra, mainAction: mainAction, secondaryAction: secondaryAction, footer: simplePredicate.footer)
            return model
        } else if let animatedPredicate = repoPredicate as? PagoAnimatedInfoScreenPredicate {
            let animation = PagoDataAnimation(animation: animatedPredicate.imageType)
            let imageAnimation = PagoLoadedAnimationModel(animationType: animation, loop: true, style: PagoAnimationStyle(size: imageSize))
            let imageHeader = PagoInfoScreenAnimatedImage(image: imageAnimation)
            let model = PagoInfoScreenModel(image: imageHeader, title: titleModel, detail: detailModel, error: errorModel, extra: animatedPredicate.extra, mainAction: mainAction, secondaryAction: secondaryAction, footer: animatedPredicate.footer)
            return model
        } else if let loadedPredicate = repoPredicate as? PagoLoadedInfoScreenPredicate {
            let backendImage = BackendImage(url: loadedPredicate.loadedImageUrl, placeholderImageName: "")
            let imageModel = PagoLoadedImageViewModel(imageData: backendImage, style: PagoImageViewStyle(size: imageSize))
            let _imageModel = PagoInfoScreenLoadedImage(image: imageModel)
            let model = PagoInfoScreenModel(image: _imageModel, title: titleModel, detail: detailModel, error: errorModel, extra: loadedPredicate.extra, mainAction: mainAction, secondaryAction: secondaryAction, footer: loadedPredicate.footer)
            return model
        } else if let deletePredicate = repoPredicate as? PagoDeleteInfoScreenPredicate {
            let style = PagoImageViewStyle(size: imageSize)
            let imageModel = PagoLoadedImageViewModel(imageData: deletePredicate.image, style: style)
            mainAction = PagoButtonModel(title: deletePredicate.mainButton, isEnabled: true, type: .mainRed)
            let imageHeader = PagoInfoScreenLoadedImage(image: imageModel)
            let model = PagoInfoScreenModel(image: imageHeader, title: titleModel, detail: detailModel, error: errorModel, extra: deletePredicate.extra, mainAction: mainAction, secondaryAction: secondaryAction, footer: deletePredicate.footer)
            return model
        } else if let dynamicPredicate = repoPredicate as? PagoDynamicImageInfoScreenPredicate {
            let style = PagoImageViewStyle(size: imageSize)
            let dynamicImageModel = PagoLoadedImageViewModel(imageData: dynamicPredicate.image, style: style)
            let imageModel = PagoInfoScreenLoadedImage(image: dynamicImageModel)
            let model = PagoInfoScreenModel(image: imageModel, title: titleModel, detail: detailModel, error: errorModel, extra: dynamicPredicate.extra, mainAction: mainAction, secondaryAction: secondaryAction, footer: dynamicPredicate.footer)
            return model
        }
        return nil
    }
}
