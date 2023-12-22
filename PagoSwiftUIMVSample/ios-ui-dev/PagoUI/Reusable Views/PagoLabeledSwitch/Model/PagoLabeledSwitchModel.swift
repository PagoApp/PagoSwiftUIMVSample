//
//  
//  PagoLabeledSwitchModel.swift
//  PagoUISDK
//
//  Created by Gabi on 10.08.2022.
//
//
import PagoUISDK
import UIKit

public struct PagoLabeledSwitchModel: Model {

    var isOn: Bool = true
    var text: String
    var style: PagoLabeledSwitchStyle = PagoLabeledSwitchStyle()
    
    
    var labelModel: PagoLabelModel {
        let style = PagoLabelStyle(textColorType: .sdkDarkGray, fontType: .regular16, alignment: .left, numberOfLines: 0, contentHuggingPriority: ContentPriorityBase(priority: .init(rawValue: 251), axis: .horizontal))
        let model = PagoLabelModel(text: text, style: style)
        return model
    }

    var containerModel: PagoStackedInfoModel {
        let style = PagoStackedInfoStyle(distribution: .fill, alignment: .center, axis: .horizontal, spacing: 16)
        return PagoStackedInfoModel(models: [], style: style)
    }
    
    var switchModel: PagoSwitchModel {
        
        let model = PagoSwitchModel(isOn: isOn, style: style.switchStyle)
        return model
    }
    
    public init(isOn: Bool = true, text: String, style: PagoLabeledSwitchStyle? = nil) {
        
        self.isOn = isOn
        self.text = text
        self.style = style ?? PagoLabeledSwitchStyle.customLabelStyle(switchConfig: PagoUIConfigurator.customConfig.pagoSwitch)
    }
}
