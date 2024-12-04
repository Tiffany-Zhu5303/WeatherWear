//
//  UserLocation.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/25/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var userLatitude: Double? = nil
    @Published var userLongitude: Double? = nil
    @Published var locationError: String? = nil

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        requestLocationPermission()
    }

    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization() 
    }

    func startFetchingLocation() {
        locationManager.startUpdatingLocation()
    }

    func stopFetchingLocation() {
        locationManager.stopUpdatingLocation()
    }

    // CLLocationManagerDelegate method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLatitude = location.coordinate.latitude
        userLongitude = location.coordinate.longitude
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationError = error.localizedDescription
    }
}
