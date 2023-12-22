//
//  Counties.swift
//  Pago
//
//  Created by Mihai Arosoaie on 01/09/16.
//  Copyright © 2016 timesafe. All rights reserved.
//

import Foundation


class Counties {
    static let prefixes: [String] = ["AB", "AR", "AG", "BC", "BH", "BN", "BT", "BV", "BR", "B", "BZ", "CS", "CL", "CJ", "CT", "CV", "DB", "DJ", "GL", "GR", "GJ", "HR", "HD", "IL", "IS", "IF", "MM", "MH", "MS", "NT", "OT", "PH", "SM", "SJ", "SB", "SV", "TR", "TM", "TL", "VS", "VL", "VN"]
    static let names: [String] = ["Alba", "Arad", "Argeș", "Bacău", "Bihor", "Bistrița-Năsăud", "Botoșani", "Brașov", "Brăila", "București", "Buzău", "Caraș-Severin", "Călărași", "Cluj", "Constanța", "Covasna", "Dâmbovița", "Dolj", "Galați", "Giurgiu", "Gorj", "Harghita", "Hunedoara", "Ialomița", "Iași", "Ilfov", "Maramureș", "Mehedinți", "Mureș", "Neamț", "Olt", "Prahova", "Satu", "Sălaj", "Sibiu", "Suceava", "Teleorman", "Timiș", "Tulcea", "Vaslui", "Vâlcea", "Vrancea"]
    
    static var allCounties = zip(prefixes, names)
    static let countyRule = "(\(prefixes.filter {$0 != "B"}.joined(separator: "|")))"

}
