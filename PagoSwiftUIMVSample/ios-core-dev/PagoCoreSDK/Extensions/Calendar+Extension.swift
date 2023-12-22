//
//  Calendar+Extension.swift
//  PagoCoreSDK
//
//  Created by Bogdan on 14.03.2023.
//

import Foundation

public extension Calendar {
    static let pagoUTCCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC") ?? TimeZone.current
        return calendar
    }()
    //NOTE: make use of Eastern European Standard Time Calendar because the policies are on EET time zone
    static let pagoEETCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "EET") ?? TimeZone.current
        return calendar
    }()
}
