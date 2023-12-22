//
//  
//  PagoBannerModel.swift
//  PagoRCASDK
//
//  Created by Gabi on 13.10.2022.
//
//

import UIKit

public struct PagoBannerModel: Model {
    
    public var actionModel: PagoButtonModel? {
        guard let text = action else { return nil }
        let inactiveStyle = ActionStyle.transparent.style
        let model = PagoButtonModel(title: text, isEnabled: true, isSelfSized: true, style: actionStyle, inactiveStyle: inactiveStyle)
        return model
    }
    
    public var actionTopSpaceModel: PagoSpaceModel {
        return PagoSpaceModel(size: CGSize(width: 0, height: 8))
    }
    
    public var titleModel: PagoLabelModel? {
        guard let text = title else { return nil }
        let model = PagoLabelModel(text: text, style: titleStyle)
        return model
    }
    
    public var detailModel: PagoLabelModel? {
        guard let text = detail else { return nil }
        let model = PagoLabelModel(text: text, style: detailStyle)
        return model
    }
    
    public var containerModel: PagoStackedInfoModel {
        return PagoStackedInfoModel(models: [], style: containerStyle)
    }
    
    public enum ContainerStyle {
        case pagoDefault, alert
        
        var style: PagoStackedInfoStyle {
            switch self {
            case .pagoDefault:
                let inset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
                let cornerRadius = Int(PagoThemeStyle.custom.generalViewCornerRadius)
                let style = PagoStackedInfoStyle(backgroundColor: PagoThemeStyle.custom.tertiaryBackgroundColor, distribution: .fill, alignment: .leading, axis: .vertical, spacing: 8, cornerRadius: cornerRadius, inset: inset)
                return style
            case .alert:
                let inset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
                let cornerRadius = Int(PagoThemeStyle.custom.generalViewCornerRadius)
                let style = PagoStackedInfoStyle(backgroundColor: .sdkBgRed, distribution: .fill, alignment: .leading, axis: .vertical, spacing: 8, cornerRadius: cornerRadius, inset: inset)
                return style
            }
        }
    }
    
    public enum TitleStyle {
        case pagoDefault
        
        var style: PagoLabelStyle {
            switch self {
            case .pagoDefault:
                return PagoLabelStyle(customStyle: .blackBold14, alignment: .left, numberOfLines: 0)
            }
        }
    }
    
    public enum DetailStyle {
        case pagoDefault, alert
        
        var style: PagoLabelStyle {
            switch self {
            case .pagoDefault:
                return PagoLabelStyle(customStyle: .greyRegular14, alignment: .left, numberOfLines: 0)
            case .alert:
                return PagoLabelStyle(customStyle: .redRegular14, alignment: .left, numberOfLines: 0)
            }
        }
    }
    
    public enum ActionStyle {
        case pagoDefault, transparent
        
        var style: PagoButtonStyle {
            switch self {
            case .pagoDefault:
                return PagoButtonStyle.style(for: .primarySmall)
            case .transparent:
                return PagoButtonStyle(font: .bold14, textColor: .sdkLightGray, backgroundColor: .sdkMainButtonInactiveColor, cornerRadius: 8)
            }
        }
    }

    
    private let action: String?
    private let title: String?
    private let detail: String?
    private let actionStyle: PagoButtonStyle
    private let titleStyle: PagoLabelStyle
    private let detailStyle: PagoLabelStyle
    private let containerStyle: PagoStackedInfoStyle
    private(set) var blockActionForSeconds: Int?

    public init(blockActionForSeconds: Int? = nil, title: String? = nil, titleStyle: TitleStyle = .pagoDefault, detail: String? = nil, detailStyle: DetailStyle = .pagoDefault, action: String? = nil, actionStyle: ActionStyle = .pagoDefault, containerStyle: ContainerStyle = .pagoDefault) {
        
        self.blockActionForSeconds = blockActionForSeconds
        self.action = action
        self.title = title
        self.detail = detail
        self.titleStyle = titleStyle.style
        self.detailStyle = detailStyle.style
        self.actionStyle = actionStyle.style
        self.containerStyle = containerStyle.style
    }
}
