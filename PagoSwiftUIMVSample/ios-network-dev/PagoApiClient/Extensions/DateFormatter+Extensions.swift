//
//  DateFormatter+Extensions.swift
//  PagoApiClient
//
//  Created by Andrei Chirita on 26.05.2022.
//

import Foundation

extension DateFormatter {
    
    @nonobjc static let romcardFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        return dateFormatter
    }()
    
    @nonobjc static let vignetteFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        //"2017-12-21 00:00:00+03:00"
        //2017-12-21 19:16:58+02:00
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ssZ"
        //dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        return dateFormatter
    }()
    
    @nonobjc static let vignetteResponseFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }()
    
    @nonobjc static let vignetteResponseFormat2: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZ"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }()
    
    @nonobjc static let dayMonthAndYear: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    @nonobjc static let dayMonthHourAndSecond: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.HHmmss"
        return dateFormatter
    }()
    
    @nonobjc static let dayAndMonth: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        return dateFormatter
    }()
    
    @nonobjc static let dashedDayMonthAndYear: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter
    }()
    
    @nonobjc static let dashedDayMonthAndYearInclTimezone: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy Z"
        return dateFormatter
    }()
    
    @nonobjc static let dashedYearMonthAndDay: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    @nonobjc static let yearMonthAndDay: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter
    }()

    @nonobjc static let dashedYearMonthAndDayInclTimezone: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd Z"
        return dateFormatter
    }()
    
    @nonobjc static let datePickerControlFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = " dd   MM   yyyy "
        return dateFormatter
    }()
    
    @nonobjc static let createdAtFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ssZZZZZ"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }()
}
