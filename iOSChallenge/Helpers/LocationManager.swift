//
//  LocationManager.swift
//  iOS Chanllenge
//
//  Created by ahmed maher on 15/12/2024.
//

import SwiftUI
import Foundation
import CoreLocation
import Combine


protocol LocationManagerProtocol {
    var userCountry: String? { get set }
    var errorMessage: String? { get set}
    var alertMessage: String? { get set }
    var showAlert: Bool { get set}

    func requestLocationPermission()
}

class LocationManager: NSObject, ObservableObject, LocationManagerProtocol {

    private var locationManager: CLLocationManager

    @Published var userCountry: String? = nil
    @Published var errorMessage: String? = nil
    @Published var alertMessage: String? = nil
    @Published var showAlert: Bool = false

    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }


    func requestLocationPermission(){
        locationManager.requestWhenInUseAuthorization()
    }

    private func fetchUserLocation() {
        locationManager.requestLocation()
    }

    private func showLocationAccessDeniedAlert() {
        alertMessage = "Please enable location access in Settings to use this feature."
        showAlert = true
    }

}

// MARK: - CLLocationManagerDelegate Methods

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            fetchUserLocation()
        case .denied, .restricted:
            userCountry = "Egypt" // Default country until user allow location permission
            showLocationAccessDeniedAlert()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorMessage = "Failed to fetch location: \(error.localizedDescription)"
        userCountry = "Fallback Country"
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            errorMessage = "Failed to get valid location."
            userCountry = "Fallback Country"
            return
        }

        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                self.errorMessage = "Failed to reverse geocode: \(error.localizedDescription)"
                self.userCountry = "Egypt"
            } else if let placemark = placemarks?.first, let country = placemark.country {
                self.userCountry = country
            }
        }
    }
}
