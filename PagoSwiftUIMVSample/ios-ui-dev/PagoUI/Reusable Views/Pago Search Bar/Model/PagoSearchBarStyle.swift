//
// Created by LoredanaBenedic on 10.04.2023.
//

import Foundation
import UIKit

public struct PagoSearchBarStyle {

    public let cornerRadius = 8
    public let borderColor = UIColor.Pago.dividers
    public let borderWidth = 2
    public let backgroundColor = UIColor.Pago.white
    public let placeholderFont = UIFont.Pago.regular15
    public var placeholderTextColor = UIColor.Pago.sdkLightGray
    public let searchFont = UIFont.Pago.regular15
    public var searchTextColor = UIColor.Pago.blackBodyText
    public let searchIndicatorColor = UIColor.Pago.lightGrayInactive
    public var searchBarTextStyleKey = ""
    public var imageColor = UIColor.Pago.sdkLightGray
    public let searchIcon = UIImage.Pago.search

    public init(iconColor: UIColor.Pago = UIColor.Pago.sdkLightGray, hintColor: UIColor.Pago = UIColor.Pago.sdkLightGray) {

        self.imageColor = iconColor
        self.placeholderTextColor = hintColor
    }
}