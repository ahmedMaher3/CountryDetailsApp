//
//  MainViewModelTests.swift
//  iOSChallengeTests
//
//  Created by ahmed maher on 11/01/2025.
//

import XCTest
import Combine
@testable import iOSChallenge


// Unit Test for MainViewModel
final class MainViewModelTests: XCTestCase {

    private var viewModel: MainViewModel!
    private var mockRepository: MockCountryRepository!
    private var mockLocationManager: MockLocationManager!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepository = MockCountryRepository()
        mockLocationManager = MockLocationManager()
        viewModel = MainViewModel(countryRepository: mockRepository, locationManager: mockLocationManager)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        mockLocationManager = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchCountries_Success() async {
        // Arrange
        let expectedCountries = [Country(name: "USA"), Country(name: "Germany")]
        mockRepository.countriesToReturn = expectedCountries

        // Act
        await viewModel.fetchCountries()

        // Assert
        XCTAssertEqual(viewModel.countries, expectedCountries)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchCountries_Failure() async {
        // Arrange
        mockRepository.shouldThrowError = true

        // Act
        await viewModel.fetchCountries()

        // Assert
        XCTAssertTrue(viewModel.countries.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
    }

    func testAddCountry() {
        // Arrange
        let country = Country(name: "USA")

        // Act
        viewModel.addCountry(country)

        // Assert
        XCTAssertTrue(viewModel.selectedCountries.contains(country))
    }

    func testAddCountry_AlreadyExists() {
        // Arrange
        let country = Country(name: "USA")
        viewModel.addCountry(country)

        // Act
        viewModel.addCountry(country)

        // Assert
        XCTAssertEqual(viewModel.selectedCountries.count, 1)
    }

    func testRemoveCountry() {
        // Arrange
        let country1 = Country(name: "USA")
        let country2 = Country(name: "Germany")
        viewModel.selectedCountries = [country1, country2]

        // Act
        viewModel.removeCountry(at: IndexSet(integer: 0))

        // Assert
        XCTAssertFalse(viewModel.selectedCountries.contains(country1))
        XCTAssertTrue(viewModel.selectedCountries.contains(country2))
    }



}

