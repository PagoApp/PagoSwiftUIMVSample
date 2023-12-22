//
//  PagoInfoScreenPredicate.swift
//  Pago
//
//  Created by Gabi Chiosa on 29/09/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit

public struct PagoNoImageInfoScreenPredicate: PagoInfoScreenBasePredicate {

    public var dismissable: Bool = true
    public var isFullScreen: Bool = false
    public var title: String?
    public var detail: String?
    public var detailImagePlaceholders: [PagoImagePlaceholderModel]?
    public var error: String?
    public var extra: PagoStackedInfoModel?
    public var hasDetailInteraction: Bool = false
    public var placeholders: [PagoPlaceholderModel]?
    public var mainButton: String?
    public var secondaryButton: PagoDelayButton?
    public var footer: PagoStackedInfoModel? = nil

    public init(dismissable: Bool = true, isFullScreen: Bool = false, title: String? = nil, detail: String? = nil, detailImagePlaceholders: [PagoImagePlaceholderModel]? = nil, error: String? = nil, extra: PagoStackedInfoModel? = nil, hasDetailInteraction: Bool = false, placeholders: [PagoPlaceholderModel]? = nil, mainButton: String? = nil, secondaryButton: PagoDelayButton? = nil, footer: PagoStackedInfoModel? = nil) {

        self.dismissable = dismissable
        self.isFullScreen = isFullScreen
        self.title = title
        self.detail = detail
        self.detailImagePlaceholders = detailImagePlaceholders
        self.error = error
        self.extra = extra
        self.hasDetailInteraction = hasDetailInteraction
        self.placeholders = placeholders
        self.mainButton = mainButton
        self.secondaryButton = secondaryButton
        self.footer = footer
    }
}

public struct PagoInfoScreenPredicate: PagoInfoScreenBasePredicate {

    public var dismissable: Bool = true
    public var isFullScreen: Bool = false
    public var title: String?
    public var detail: String?
    public var detailImagePlaceholders: [PagoImagePlaceholderModel]?
    public var error: String?
    public var extra: PagoStackedInfoModel?
    public var hasDetailInteraction: Bool = false
    public var placeholders: [PagoPlaceholderModel]?
    public var imageType: UIImage.Pago
    public var mainButton: String?
    public var secondaryButton: PagoDelayButton?
    public var footer: PagoStackedInfoModel? = nil
    
    public init(dismissable: Bool = true, isFullScreen: Bool = false, title: String, detail: String?, detailImagePlaceholders: [PagoImagePlaceholderModel]? = nil, error: String? = nil, extra: PagoStackedInfoModel? = nil, hasDetailInteraction: Bool = false, placeholders: [PagoPlaceholderModel]? = nil, imageType: UIImage.Pago, mainButton: String? = nil, secondaryButton: PagoDelayButton? = nil, footer: PagoStackedInfoModel? = nil) {
        
        self.dismissable = dismissable
        self.isFullScreen = isFullScreen
        self.title = title
        self.detail = detail
        self.detailImagePlaceholders = detailImagePlaceholders
        self.error = error
        self.extra = extra
        self.hasDetailInteraction = hasDetailInteraction
        self.placeholders = placeholders
        self.imageType = imageType
        self.mainButton = mainButton
        self.secondaryButton = secondaryButton
        self.footer = footer
    }
}

public struct PagoDynamicImageInfoScreenPredicate: PagoInfoScreenBasePredicate {
    public var dismissable: Bool = true
    public var isFullScreen: Bool = false
    public var title: String?
    public var detail: String?
    public var detailImagePlaceholders: [PagoImagePlaceholderModel]?
    public var error: String?
    public var extra: PagoStackedInfoModel?
    public var hasDetailInteraction: Bool = false
    public var placeholders: [PagoPlaceholderModel]?
    public var image: BackendImage
    public var mainButton: String?
    public var secondaryButton: PagoDelayButton?
    public var footer: PagoStackedInfoModel? = nil
    
    public init(dismissable: Bool = true, isFullScreen: Bool = false, title: String, detail: String?, detailImagePlaceholders: [PagoImagePlaceholderModel]? = nil, error: String? = nil, extra: PagoStackedInfoModel? = nil, hasDetailInteraction: Bool = false, placeholders: [PagoPlaceholderModel]? = nil, image: BackendImage, mainButton: String, secondaryButton: PagoDelayButton? = nil, footer: PagoStackedInfoModel? = nil) {
        
        self.dismissable = dismissable
        self.isFullScreen = isFullScreen
        self.title = title
        self.detail = detail
        self.detailImagePlaceholders = detailImagePlaceholders
        self.error = error
        self.extra = extra
        self.hasDetailInteraction = hasDetailInteraction
        self.placeholders = placeholders
        self.image = image
        self.mainButton = mainButton
        self.secondaryButton = secondaryButton
        self.footer = footer
    }
}

public struct PagoLoadedInfoScreenPredicate: PagoInfoScreenBasePredicate {
    public var dismissable: Bool = true
    public var isFullScreen: Bool = false
    public var title: String?
    public var detail: String?
    public var detailImagePlaceholders: [PagoImagePlaceholderModel]?
    public var error: String?
    public var extra: PagoStackedInfoModel?
    public var hasDetailInteraction: Bool = false
    public var placeholders: [PagoPlaceholderModel]?
    public var loadedImageUrl: String
    public var mainButton: String?
    public var secondaryButton: PagoDelayButton?
    public var footer: PagoStackedInfoModel? = nil
    
    public init(dismissable: Bool = true, isFullScreen: Bool = false, title: String, detail: String?, detailImagePlaceholders: [PagoImagePlaceholderModel]? = nil, error: String? = nil, extra: PagoStackedInfoModel? = nil, hasDetailInteraction: Bool = false, placeholders: [PagoPlaceholderModel]? = nil, loadedImageUrl: String, mainButton: String, secondaryButton: PagoDelayButton? = nil, footer: PagoStackedInfoModel? = nil) {
        
        self.dismissable = dismissable
        self.isFullScreen = isFullScreen
        self.title = title
        self.detail = detail
        self.detailImagePlaceholders = detailImagePlaceholders
        self.error = error
        self.extra = extra
        self.hasDetailInteraction = hasDetailInteraction
        self.placeholders = placeholders
        self.loadedImageUrl = loadedImageUrl
        self.mainButton = mainButton
        self.secondaryButton = secondaryButton
        self.footer = footer
    }
}

public struct PagoDeleteInfoScreenPredicate: PagoInfoScreenBasePredicate {

    public var dismissable: Bool = true
    public var isFullScreen: Bool = false
    public var title: String?
    public var detail: String?
    public var detailImagePlaceholders: [PagoImagePlaceholderModel]?
    public var error: String?
    public var extra: PagoStackedInfoModel?
    public var hasDetailInteraction: Bool = false
    public var placeholders: [PagoPlaceholderModel]?
    public var image: DataImageModel
    public var mainButton: String?
    public var secondaryButton: PagoDelayButton?
    public var footer: PagoStackedInfoModel? = nil
    
    public init(dismissable: Bool = true, isFullScreen: Bool = false, title: String, detail: String?, detailImagePlaceholders: [PagoImagePlaceholderModel]? = nil, error: String? = nil, extra: PagoStackedInfoModel? = nil, hasDetailInteraction: Bool = false, placeholders: [PagoPlaceholderModel]? = nil, image: DataImageModel, mainButton: String, secondaryButton: PagoDelayButton? = nil, footer: PagoStackedInfoModel? = nil) {
        
        self.dismissable = dismissable
        self.isFullScreen = isFullScreen
        self.title = title
        self.detail = detail
        self.detailImagePlaceholders = detailImagePlaceholders
        self.error = error
        self.extra = extra
        self.hasDetailInteraction = hasDetailInteraction
        self.placeholders = placeholders
        self.image = image
        self.mainButton = mainButton
        self.secondaryButton = secondaryButton
        self.footer = footer
    }
    
}

public struct PagoAnimatedInfoScreenPredicate: PagoInfoScreenBasePredicate {
    
    public var dismissable: Bool
    public var isFullScreen: Bool
    public var title: String?
    public var detail: String?
    public var detailImagePlaceholders: [PagoImagePlaceholderModel]?
    public var error: String?
    public var extra: PagoStackedInfoModel?
    public var hasDetailInteraction: Bool
    public var placeholders: [PagoPlaceholderModel]?
    public var imageType: UIImage.PagoAnimation
    public var mainButton: String?
    public var secondaryButton: PagoDelayButton?
    public var footer: PagoStackedInfoModel?
    
    public init(dismissable: Bool = true, isFullScreen: Bool = false, title: String? = nil, detail: String? = nil, detailImagePlaceholders: [PagoImagePlaceholderModel]? = nil, error: String? = nil, extra: PagoStackedInfoModel? = nil, hasDetailInteraction: Bool = false, placeholders: [PagoPlaceholderModel]? = nil, imageType: UIImage.PagoAnimation, mainButton: String? = nil, secondaryButton: PagoDelayButton? = nil, footer: PagoStackedInfoModel? = nil) {
        self.dismissable = dismissable
        self.isFullScreen = isFullScreen
        self.title = title
        self.detail = detail
        self.detailImagePlaceholders = detailImagePlaceholders
        self.error = error
        self.extra = extra
        self.hasDetailInteraction = hasDetailInteraction
        self.placeholders = placeholders
        self.imageType = imageType
        self.mainButton = mainButton
        self.secondaryButton = secondaryButton
        self.footer = footer
    }
}

public protocol PagoInfoScreenBasePredicate: PagoPredicate {

    var dismissable: Bool {get set}
    var isFullScreen: Bool {get set}
    var title: String? {get set}
    var detail: String? {get set}
    var detailImagePlaceholders: [PagoImagePlaceholderModel]? {get set}
    var error: String? {get set}
    var extra: PagoStackedInfoModel? {get set}
    var hasDetailInteraction: Bool {get set}
    var placeholders: [PagoPlaceholderModel]? {get set}
    var mainButton: String? {get set}
    var secondaryButton: PagoDelayButton? {get set}
    var footer: PagoStackedInfoModel? {get set}
}

public struct PagoDelayButton {
    let title: String
    var delayedTitle: String?
    var delay: Int = 0
    var defaultDelay: Int = 0
    
    public init(title: String, delayedTitle: String? = nil, delay: Int = 0, defaultDelay: Int = 0) {
        self.title = title
        self.delayedTitle = delayedTitle
        self.delay = delay
        self.defaultDelay = defaultDelay
    }
    
    mutating func resetDelay() {
        delay = defaultDelay
    }
    
    func getDelayedTime(delay: Int) -> String {
        let minutes = Int(delay) / 60 % 60
        let seconds = Int(delay) % 60
        let timeLeft = String(format:"%02i:%02i", minutes, seconds)
        return timeLeft
    }
    
    func getDelayedTitle(delay: Int) -> String {
        let timeLeft = getDelayedTime(delay: delay)
        if let delayString = delayedTitle {
            return String.init(format: delayString, timeLeft)
        } else {
            return timeLeft
        }
    }
}
