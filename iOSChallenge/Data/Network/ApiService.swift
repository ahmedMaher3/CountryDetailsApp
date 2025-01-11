//
//  CountryService.swift
//  iOSChallenge
//
//  Created by ahmed maher on 10/01/2025.
//


import Foundation

protocol APIServiceProtocol {
    func request<T: Decodable>(endPoint: Endpoint)async throws -> T

}

class APIService: APIServiceProtocol {

    func request<T: Decodable>(endPoint: Endpoint) async throws -> T {
        var request = URLRequest(url: endPoint.service.url )
        request.httpMethod = endPoint.method.rawValue

        endPoint.headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse((response as? HTTPURLResponse)?.statusCode ?? 0)
            }
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}


enum APIError: Error, LocalizedError {
    case invalidResponse(Int)
    case decodingError(String)
    case unknownError(String)

    var errorDescription: String? {
        switch self {
        case .invalidResponse(let statusCode):
            return "Invalid response: \(statusCode)"
        case .decodingError(let message):
            return "Decoding error: \(message)"
        case .unknownError(let message):
            return "Unknown error: \(message)"
        }
    }
}
