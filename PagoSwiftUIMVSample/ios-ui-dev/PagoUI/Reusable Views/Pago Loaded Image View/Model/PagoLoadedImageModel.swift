//
//  
//  PagoLoadedImageModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 31/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit

public struct PagoLoadedImageViewModel: Model {
    public var imageData: DataImageModel
    public var style: PagoImageViewStyle
    public var accessibility = PagoAccessibility(isAccessibilityElement: false, accessibilityTraits: UIAccessibilityTraits.image)
    
    public init(imageData: DataImageModel, style: PagoImageViewStyle, accessibility: PagoAccessibility = PagoAccessibility(isAccessibilityElement: false, accessibilityTraits: UIAccessibilityTraits.image)) {
        self.imageData = imageData
        self.style = style
        self.accessibility = accessibility
    }
}

public struct BackendImage: DataImageModel {
    public let url: String
    public let placeholderImageName: String
    
    public init(url: String, placeholderImageName: String) {
        self.url = url
        self.placeholderImageName = placeholderImageName
    }
}

public struct DataImage: DataImageModel {
    public let data: Data
    
    public init(data: Data) {
        self.data = data
    }
}

public struct PagoImage: DataImageModel {
    public let image: UIImage.Pago
    
    public init(image: UIImage.Pago) {
        self.image = image
    }
}

public struct PlaceholderLabelImage: DataImageModel {
    public let label: PagoLabelModel
    
    public init(label: PagoLabelModel) {
        self.label = label
    }
}

public protocol DataImageModel: Model {}
