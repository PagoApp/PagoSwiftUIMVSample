//
//  
//  PagoAlertRepository.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit

public class PagoAlertRepository: PagoBaseAlertRepository {

    //TODO: migrate parameters to struct
    public func getPickerAlertModel(startDate startTimestamp: Int64?, minDate: Date? = nil, maxDate: Date? = nil, title: String? = nil, mainButtonTitle: String, secondaryButtonTitle: String, locale: Locale = Locale.current, datePickerMode: UIDatePicker.Mode = .date, showLocalTime: Bool = false) -> PagoAlertModel {

        var header: PagoStackedInfoModel? = nil
        if let title = title {
            let headerTitleStyle = PagoLabelStyle(textColorType: .blackBodyText, fontType: .semiBold17, alignment: .center, numberOfLines: 0)
            let headerTitleModel = PagoLabelModel(text: title, style: headerTitleStyle)
            let headerStackStyle = PagoStackedInfoStyle(distribution: .fill, alignment: .center, axis: .vertical, spacing: 8)
            let spacingModel = PagoSimpleViewModel(style: PagoSimpleViewStyle(height: 8))

            header = PagoStackedInfoModel(models: [spacingModel, headerTitleModel, spacingModel], style: headerStackStyle)
        }

        let startDate: Date
        if let startTimestamp = startTimestamp {
            startDate = Date(milliseconds: startTimestamp)
        } else {
            startDate = Date()
        }

        let datePickerStyle = PagoDatePickerStyle(currentDate: startDate, minDate: minDate, maxDate: maxDate, datePickerMode: datePickerMode, textColor: .blackBodyText, inset: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0), locale: locale, showLocalTime: showLocalTime)
        let datePickerModel = PagoDatePickerModel(style: datePickerStyle)

        let okButton = PagoButtonModel(title: mainButtonTitle, type: .main, height: 48)
        let cancelButton = PagoButtonModel(title: secondaryButtonTitle, type: .tertiary, height: 48)
        let style = PagoAlertStyle(optionsSpace: 16)

        return PagoAlertModel(header: header, options: [datePickerModel, okButton, cancelButton], style: style)
    }
    
}
