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
  private let geocoder = CLGeocoder()
  
  @Published var userLatitude: Double? = nil
  @Published var userLongitude: Double? = nil
  @Published var userCity: String? = nil
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
    guard let location = locations.first else { return }
    self.userLatitude = location.coordinate.latitude
    self.userLongitude = location.coordinate.longitude
    self.locationError = nil
    
    geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
      if let error = error {
        self?.locationError = error.localizedDescription
        return
      }
      
      if let placemark = placemarks?.first {
        self?.userCity = placemark.locality
      }
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    locationError = error.localizedDescription
  }
}
