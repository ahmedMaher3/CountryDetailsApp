//
//  MainViewModel.swift
//  iOS Chanllenge
//
//  Created by ahmed maher on 14/12/2024.


import SwiftUI
import CoreLocation
import Combine


class MainViewModel: ObservableObject {

    private let countryRepository: CountryRepositoryProtocol
    var locationManager: LocationManagerProtocol
    private var cancellables: Set<AnyCancellable> = []

    @Published var countries: [Country] = []
    @Published var selectedCountries: [Country] = []
    @Published var errorMessage: String?
    @Published var userCountry: String? = nil


    init(countryRepository: CountryRepositoryProtocol,locationManager: LocationManagerProtocol = LocationManager()) {
        self.countryRepository = countryRepository
        self.locationManager = locationManager
        initializeLocationAndData()

    }

    private func initializeLocationAndData() {
        Task {
            await fetchCountries()
            observeForLocation()
            requestLocationPermission()
        }
    }

    private func observeForLocation(){
        (locationManager as? LocationManager)?.$userCountry
            .sink { [weak self] country in
                guard let self = self else { return }
                self.userCountry = country
                self.addCountryByName()

            }
            .store(in: &cancellables)

        (locationManager as? LocationManager)?.$errorMessage
            .sink { [weak self] errorMessage in
                self?.errorMessage = errorMessage
            }
            .store(in: &cancellables)
    }

    func requestLocationPermission() {
          locationManager.requestLocationPermission()
      }


    func removeCountry(at offsets: IndexSet) {
        selectedCountries.remove(atOffsets: offsets)
    }

    func addCountry(_ country: Country) {
        guard selectedCountries.count < 5 else { return }
        if !selectedCountries.contains(where: { $0.name == country.name }) {
            selectedCountries.append(country)
        }
    }

    private func addCountryByName() {
        if  let country = countries.first(where: { $0.name.lowercased().contains(userCountry?.lowercased() ?? "") }) {
            self.selectedCountries.append(country)
        }

    }

    func filteredCountries(searchText: String) -> [Country] {
        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }


    @MainActor
    func fetchCountries() async {
        do {
            let fetchedCountries = try await countryRepository.fetchCountries()
            self.countries = fetchedCountries
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}



