//
//  CountryRepositryTests.swift
//  iOSChallengeTests
//
//  Created by ahmed maher on 11/01/2025.
//

import XCTest
@testable import iOSChallenge

class CountryRepositoryTests: XCTestCase {

    var countryRepository: CountryRepository!
    var mockAPIService: MockAPIService!

    override func setUp() {
        super.setUp()

        mockAPIService = MockAPIService()
        countryRepository = CountryRepository(apiService: mockAPIService)
    }

    override func tearDown() {
        countryRepository = nil
        mockAPIService = nil
        super.tearDown()
    }

    func testFetchCountries_Success() async {
        // Arrange
        let expectedCountries = [Country(name: "USA"), Country(name: "Germany")]
        mockAPIService.countriesToReturn = expectedCountries

        // Act
        do {
            let countries = try await countryRepository.fetchCountries()

            // Assert
            XCTAssertEqual(countries, expectedCountries)
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }

    func testFetchCountries_Failure() async {
        // Arrange
        mockAPIService.errorToThrow = NSError(domain: "Test", code: 1, userInfo: nil)

        // Act
        do {
            _ = try await countryRepository.fetchCountries()
            XCTFail("Expected failure but got success")
        } catch {
            // Assert
            XCTAssertNotNil(error)
            XCTAssertEqual((error as NSError).domain, "Test")
        }
    }
}
