//
//  MockLocationManager.swift
//  iOSChallenge
//
//  Created by ahmed maher on 11/01/2025.
//

import Foundation
import CoreLocation



class MockLocationManager: LocationManagerProtocol {
    @Published var userCountry: String? = nil
    @Published var errorMessage: String? = nil
    @Published var alertMessage: String? = nil
    @Published var showAlert: Bool = false

    func requestLocationPermission() {
        userCountry = "USA"
    }

}
