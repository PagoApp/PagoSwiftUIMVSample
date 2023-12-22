//
//  
//  PagoInfoScreenModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//


struct PagoInfoScreenModel: Model {
    
    let image: PagoInfoScreenImage?
    let title: PagoLabelModel?
    let detail: PagoLabelModel?
    var error: PagoLabelModel?
    var extra: PagoStackedInfoModel?
    let mainAction: PagoButtonModel?
    let secondaryAction: PagoButtonModel?
    let footer: PagoStackedInfoModel?
}

protocol PagoInfoScreenImage {}

struct PagoInfoScreenSimpleImage: PagoInfoScreenImage {
    let image: PagoImageViewModel
}

struct PagoInfoScreenAnimatedImage: PagoInfoScreenImage {
    let image: PagoLoadedAnimationModel
}

struct PagoInfoScreenLoadedImage: PagoInfoScreenImage {
    let image: PagoLoadedImageViewModel
}
