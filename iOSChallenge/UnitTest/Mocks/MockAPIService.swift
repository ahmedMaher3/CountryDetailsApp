//
//  MockAPIService.swift
//  iOSChallenge
//
//  Created by ahmed maher on 11/01/2025.
//

import Foundation
class MockAPIService: APIServiceProtocol {
    var countriesToReturn: [Country] = []
    var errorToThrow: Error?

    func request<T: Decodable>(endPoint: Endpoint) async throws -> T {
        if let error = errorToThrow {
            throw error
        }
        guard let countries = countriesToReturn as? T else {
            throw NSError(domain: "Invalid type", code: 0, userInfo: nil)
        }
        return countries
    }
}
