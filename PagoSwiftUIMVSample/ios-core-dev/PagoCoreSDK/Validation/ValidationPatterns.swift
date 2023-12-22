//
//  ValidationPatterns.swift
//  Pago
//
//  Created by Mihai Arosoaie on 01/09/16.
//  Copyright © 2016 timesafe. All rights reserved.
//

import Foundation

infix operator =~

public func =~ (string:String, pattern:String) -> Bool {
    do {
        let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
        let matches = regex.matches(in: string, options: [], range: NSRange(location: 0, length: string.count))
        return matches.count > 0
    } catch (_) {
        return false
    }
}

public class CommonValidations {
    public static func emailIsValid(_ email: String?) -> Bool {
        guard let email = email else { return false }
        return email =~ ValidationPatterns.email
    }
    
    public static func passwordIsValid(_ password: String) -> Bool {
        return !(password =~ " +") && (password =~ "^.{4,}$")
    }
    
    public static func accountPasswordIsValid(_ password: String) -> Bool {
        return !(password =~ " +") && (password =~ "^.{6,}$")
    }
    
    public static func providerAccountPasswordIsValid(_ password: String) -> Bool {
        return !(password =~ " +") && (password =~ "^.{4,50}$")
    }
    
    public static func usernameIsValid(_ username: String) -> Bool {
        return username =~ "^[\\w@\\-_0-9@. +]{4,}$"
    }
    
    public static func nameIsValid(_ name: String) -> Bool {
        return name =~ ValidationPatterns.nameRegex
    }
    
    public static func cnpIsValid(_ text: String?) -> Bool {
        guard let text = text else { return false }
        let result = text.range(of: ValidationPatterns.cnpRegex, options: .regularExpression)
        return result != nil
    }
    
    public static func phoneNumberIsValid(_ phoneNumber: String?) -> Bool {
        guard let phoneNumber = phoneNumber else { return false }
        return phoneNumber =~ ValidationPatterns.phoneNumber
    }
    
    public static func isNullOrEmpty(_ text: String?) -> Bool {
        guard let text = text else { return true }
        return text.isEmpty
    }
    
    public static func isNotNullNorEmpty(_ text: String?) -> Bool {
        return !isNullOrEmpty(text?.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    public static func idCardIsValid(_ text: String?) -> Bool {
        guard let text = text else { return false }
        return text =~ ValidationPatterns.idCard
    }
    
    public static func idCardIsPartialValid(_ text: String?) -> Bool {
        guard let text = text else { return false }
        return text =~ ValidationPatterns.partialIdCard
    }
    
    public static func hasXMinLength(_ text: String?, minLength: Int) -> Bool {
        guard let text = text else { return false }
        return text.count >= minLength
    }
    
    public static func hasXMaxLength(_ text: String?, maxLength: Int) -> Bool {
        guard let text = text else { return false }
        return text.count <= maxLength
    }
    
    public static func hasXLength(_ text: String?, length: Int) -> Bool {
        guard let text = text else { return false }
        return text.count == length
    }

    public static func isAlphanumeric(_ text: String?) -> Bool {

        guard let text = text else { return false }
        return text =~ ValidationPatterns.alphanumericRegex
    }

    public static func isNumeric(_ text: String?) -> Bool {

        guard let text = text else { return false }
        return text =~ ValidationPatterns.numericRegex
    }

    public static func registrationNumberValid(_ text: String?) -> Bool {
        
        guard let text = text else { return false }
        return text =~ ValidationPatterns.plateNumber
    }
    
    public static func chassisValid(_ text: String?) -> Bool {
        
        guard let text = text else { return false }
        return text =~ ValidationPatterns.chassisId
    }
    
    public static func yearValid(_ text: String?) -> Bool {

        guard let text = text else { return false }
        return text =~ ValidationPatterns.year
    }
    
    public static func yearValidAndLessThanCurrent(_ text: String?) -> Bool {
        
        guard let text = text else { return false }
        guard text =~ ValidationPatterns.year  else { return false }
        guard let currentYear = Calendar.pagoUTCCalendar.dateComponents(in: .current, from: Date()).year else { return false }
        guard let year = text.toInt32 else { return false }
        return year <= currentYear
    }
    
    public static func carWeightValid(_ text: String?) -> Bool {
        
        guard let text = text else { return false }
        return text =~ ValidationPatterns.carWeight
    }
    
    public static func carCCValid(_ text: String?) -> Bool {
        
        guard let text = text else { return false }
        return text =~ ValidationPatterns.carCC
    }
    
    public static func carPowerValid(_ text: String?) -> Bool {
        
        guard let text = text else { return false }
        return text =~ ValidationPatterns.carPower
    }
    
    public static func carSeatsValid(_ text: String?) -> Bool {
        
        guard let text = text else { return false }
        return text =~ ValidationPatterns.carSeats
    }
    
    public static func bookIdValid(_ text: String?) -> Bool {
        
        guard let text = text else { return false }
        return text =~ ValidationPatterns.bookId
    }
    
    public static func carColorValid(_ text: String?) -> Bool {
        
        guard let text = text else { return false }
        return text =~ ValidationPatterns.color
    }
    
    public static func addressFieldValid(_ text: String?) -> Bool {
        
        guard let text = text else { return true }
        return text =~ ValidationPatterns.addressField
    }
    
    public static func personNameFieldValid(_ text: String?) -> Bool {
        
        guard let text = text else { return false }
        return text =~ ValidationPatterns.personNameField
    }
    
}

public class ValidationPatterns {

//    static let initialCardTypeRegex: [CardType: String] =
//        [.Visa: "^4",
//         .Mastercard: "^5[1-5]"]
//
//    static let validCardTypeRegexes: [CardType: String] =
//        [.Visa: "^4[0-9]{15}",
//         .Mastercard: "^5[1-5][0-9]{14}"]
//
//    static let phoneNumber: String = {
//        return "^(0040|\\+40|0|40)7(?:[0-9]\\d{2}|99\\d)\\d{5}$"
//    }()
    
    public  static let plateNumber: String = {
        let cPrefixes = Counties.prefixes.filter {$0 != "B"}.joined(separator: "|")
        let last3letters = "[A-Z]{3}"
        
        let dashedCountiesRule = "^(\(cPrefixes))-\\d{2}-\(last3letters)$"
        let dashedBucharestRule = "^B-\\d{2,3}-\(last3letters)$"
        
        let countiesRule = "^(\(cPrefixes))\\d{2}\(last3letters)$"
        let bucharestRule = "^B\\d{2,3}\(last3letters)$"

        
        let finalRule = "(\(countiesRule))|(\(bucharestRule))|(\(dashedCountiesRule))|(\(dashedBucharestRule))"

       return finalRule
    }()
    
    public static let idCard: String = {
        return "^([a-zA-Z]{2}[\\d]{6,7})$"
    }()
    
    public static let partialIdCard: String = {
       return "^[a-zA-Z]{1,2}[\\d]{0,7}$"
    }()
    
    static let chassisId: String = {
        return "^[a-hj-np-zA-HJ-NP-Z0-9/]{3,20}$"
    }()
    
    public static let carPower: String = {
        return "^[0-9]{0,4}$"
        
    }()
    
    public static let carWeight: String = {
        return "^[0-9]{0,5}$"
    }()
    
    public static let carCC: String = {
        return "^[0-9]{0,6}$"
    }()
    
    public static let year: String = {
        return "^[0-9]{4}$"
    }()
    
    public static let carSeats: String = {
        return "^[0-9]{0,2}$"
    }()
    
    public static let bookId: String = {
        return "^([a-zA-Z][0-9]{6,7})$"
    }()
    
    public static let color: String = {
        return "(^[[a-zA-Z]\\u0100-\\u017F\\u00c0-\\u00ff]{1,}$)"
    }()
    
    public static let addressField: String = {
        return "(^[\\w\\d\\u0100-\\u017F\\u00c0-\\u00ff][\\w\\d\\u00c0-\\u00ff\\u0100-\\u017F\\s\\-./]{0,}$)|(^$)"
    }()
    
    public static let personNameField: String = {
        return "(^[[a-zA-Z]\\u0100-\\u017F\\u00c0-\\u00ff][[a-zA-Z]\\u00c0-\\u00ff\\u0100-\\u017F\\s\\-./]{1,}$)|(^$)"
    }()
    
    public static let phoneNumber: String = {
        return "^(0040|\\+40|0|40)7(?:[0-9]\\d{2}|99\\d)\\d{5}$"
    }()
    
    /*
     C este cifră de control (un cod autodetector) aflată în relație cu toate celelate 12 cifre ale C.N.P.-ului. Cifra de control este calculată după cum urmează: fiecare cifră din C.N.P. este înmulțită cu cifra de pe aceeași poziție din numărul 279146358279; rezultatele sunt însumate, iar rezultatul final este împărțit cu rest la 11. Dacă restul este 10, atunci cifra de control este 1, altfel cifra de control este egală cu restul.
     */
    static let controlArray = "279146358279".map {String($0)}.failingFlatMap {Int($0)}!
    
    static func controlNumberIsValid(forCnp cnp: String) -> Bool {
        guard let numbers = (cnp.map {String($0)}.failingFlatMap {Int($0)}) else {
            return false
        }
        
        let sum = numbers[0..<numbers.count-1].enumerated().reduce(0, {acc, tup in
            return acc + tup.element * controlArray[tup.offset]
        })
        let lastNumber = numbers[(numbers.endIndex - 1)]
        let result = (sum % 11 == 10 ? 1 : sum % 11)
        return lastNumber == result
    }
    
    public static let cnp: String = {
        //format: SAALLZZJJNNNC
        let genderString = "123456789"
        let validCountyCodes = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "51", "52"]
        let rxvcc = validCountyCodes.joined(separator: "|")
        //           S                AALLZZ    JJ       NNN         C
        let regex = "[\(genderString)]\\d{6}(\(rxvcc))([1-9]\\d\\d)\\d"
        return regex
    }()
    
    static let cnpRegex = "^[1-9]\\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\\d|3[01])(0[1-9]|[1-4]\\d|5[0-2]|99)(00[1-9]|0[1-9]\\d|[1-9]\\d\\d)\\d$"
    
    public static let email = "^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,})$"
    
    static let nameRegex = "^[\\w-']{2,}"
    
    static let addressRegex = "[\\w-]{3,}"

    static let alphanumericRegex = "^[a-zA-Z0-9]*$"

    static let numericRegex = "^[0-9]*$"

}

public class CommonFormatting {

    public static func toUppercase(_ string: String?) -> String? {

        guard let string = string else { return nil }
        return string.uppercased()
    }
}
