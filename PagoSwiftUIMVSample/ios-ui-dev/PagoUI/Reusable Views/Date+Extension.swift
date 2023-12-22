//
//  Date+Extension.swift
//  Pago
//
//  Created by Gabi Chiosa on 23.02.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation

extension Date {
    
    #warning("Should fix this")
    //TODO: Fix this
//    static var locale: String { return CountryManager.shared.languageCode?.iso ?? "ro_RO"}
    public static var locale: String { return "ro_RO" }
    public static var enLocale: String { return "en_RO" }

    public static var tomorrow: Date {
        Date().add(component: .day, value: 1)
    }

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    public enum PagoDateFormat {
        case shortDate
        case normal
        case shorterDate
        case shortDateWithYear, dateWithYear
        case dateWithMonthLettersYear
        case dayWithMonth
        case hour24Format
        case yearMonthDate
        case dayMonthDateCommaSeparated
        case month
        case monthYear

        var string : String {
            switch self {
            case .dayWithMonth:
                return "d MMMM"
            case .hour24Format:
                return "HH:mm"
            case .dateWithYear:
                return "dd MM YYYY"
            case .dateWithMonthLettersYear:
                return "dd MMMM YYYY"
            case .shortDateWithYear:
                return "dd MMM YYYY"
            case .shortDate:
                return "dd MMM"
            case .normal:
                return "dd MMMM"
            case .shorterDate:
                return "d MMM"
            case .yearMonthDate:
                return "yyyyMMdd"
            case .dayMonthDateCommaSeparated:
                return "d MMM, HH:mm"
            case .month:
                return "MMMM"
            case .monthYear:
                return "MMMM YYYY"
            }
        }
    }
    
    var weekdayName: String {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.pagoUTC

        guard let weekdayNumber = calendar.dateComponents(Set([.weekday]), from: self).weekday else { return "" }
        let dayIndex = ((weekdayNumber - 1) + (calendar.firstWeekday - 1)) % 7
        return calendar.weekdaySymbols[dayIndex]
    }
    
    
    /// Transforms current Date into a pretty formatted string date
    /// - Parameters:
    ///   - format: Predefined style used for date format processing
    ///   - locale: Locale used to localise the date
    ///   - timeZone: Timezone used to transform the date into a readable version
    /// - Returns: Returns a pretty formatted string to display a date. By default we remove all "." (period)
    /// which are inserted by the native methods. If required we add "," (comma) inside the PagoDateFormat
    public func toString(format: PagoDateFormat, locale: String? = Date.locale, timeZone: TimeZone? = nil) -> String {
        let prettyDate = toString(format: format.string, locale: locale, timeZone: timeZone)
        return prettyDate.replacingOccurrences(of:  ".", with: "")
    }
    
    private func toString(format: String, locale: String? = nil, timeZone: TimeZone?) -> String {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone ?? TimeZone(identifier: "UTC")
        if let locale = locale {
            dateFormatter.locale = Locale(identifier: locale)
        }
        return dateFormatter.string(from: self)
    }
    
    public func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        var currentCalendar = calendar
        currentCalendar.timeZone = TimeZone.pagoUTC
        return currentCalendar.dateComponents(Set(components), from: self)
    }

    public func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        var currentCalendar = calendar
        currentCalendar.timeZone = TimeZone.pagoUTC
        return currentCalendar.component(component, from: self)
    }
    
    public var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    public var lastTimestampOfDay: Date? {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.pagoUTC
        let date = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: self)
        return date
    }

    public init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }

    public func add(component: Calendar.Component, value: Int) -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.pagoUTC
        guard let newDate = calendar.date(byAdding: component, value: value, to: self) else { return self }
        return newDate
    }

    public func removeTimeStamp() -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.pagoUTC
        guard let newDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: self)) else { return self }
        return newDate
    }
}

extension TimeZone {
    public static var pagoUTC: TimeZone {
        return TimeZone(identifier: "UTC") ?? TimeZone.current
    }
}
