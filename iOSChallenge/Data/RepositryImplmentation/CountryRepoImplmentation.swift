//
//  MainRepoImplmentation.swift
//  iOS Chanllenge
//
//  Created by ahmed maher on 15/12/2024.
//


import Foundation

class CountryRepository: CountryRepositoryProtocol {
    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    func fetchCountries() async throws -> [Country] {
        return try await apiService.request(endPoint: CountryEndPoint())
    }
}
