//
//  MainRepo.swift
// iOS Chanllenge
//
//  Created by ahmed maher on 15/12/2024.
//

import Foundation

protocol CountryRepositoryProtocol {
    func fetchCountries() async throws -> [Country]
}


