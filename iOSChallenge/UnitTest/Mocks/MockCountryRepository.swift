//
//  MockCountryRepository.swift
//  iOSChallenge
//
//  Created by ahmed maher on 11/01/2025.
//

import Foundation

class MockCountryRepository: CountryRepositoryProtocol {
    var countriesToReturn: [Country] = []
    var shouldThrowError = false

    func fetchCountries() async throws -> [Country] {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 0, userInfo: nil)
        }
        return countriesToReturn
    }
}
