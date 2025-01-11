//
//  DepencyManager.swift
//  iOSChallenge
//
//  Created by ahmed maher on 11/01/2025.
//

import Foundation

class DependencyManager {
    static let shared = DependencyManager()

    private init() {}

    // Register dependencies here
    func resolveCountryRepository() -> CountryRepositoryProtocol {
        return CountryRepository()
    }

    func resolveMainViewModel() -> MainViewModel {
        let countryRepository = resolveCountryRepository()
        return MainViewModel(countryRepository: countryRepository)
    }
}
