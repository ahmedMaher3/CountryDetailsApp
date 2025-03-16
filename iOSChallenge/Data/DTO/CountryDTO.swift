//
//  ListModel.swift
//  iOS Chanllenge
//
//  Created by ahmed maher on 14/12/2024.
//

import Foundation

struct Country : Codable, Identifiable,Equatable{

    var id: String { alpha3Code }
    let name: String
    let alpha2Code, alpha3Code: String
    let capital: String?
    let currencies: [Currency]?
    let flag: String?

    init(name: String) {
        self.name = name
        self.alpha2Code = ""
        self.alpha3Code = ""
        self.capital = ""
        self.currencies = []
        self.flag = ""
    }


}

// MARK: - Currency
struct Currency: Codable,Equatable {
    let code, name, symbol: String
}

// MARK: - Flags
struct Flags: Codable {
    let svg: String
    let png: String
}

