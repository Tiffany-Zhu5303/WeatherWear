//
//  WeatherView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 12/2/24.
//

import SwiftUI

struct WeatherView: View {
  @StateObject private var locationManager = LocationManager()
  @State private var weatherData: WeatherObject?
  @State private var weatherError: String?
  
  func fetchWeather(latitude: Double, longitude: Double) async {
    let weatherServer = WeatherService()
    
    do {
      weatherData = try await weatherServer.getCurrentWeather(
        latitude: "\(latitude)",
        longitude: "\(longitude)"
      )
    } catch {
      weatherError = error.localizedDescription
    }
  }
  
  // Default simulator location: Apple Headquarter in CA
  var body: some View {
    VStack {
      if locationManager.userLatitude != nil && locationManager.userLongitude != nil {
        
        if let weatherData = weatherData{
          let temperature = Int(weatherData.current.temperature_2m)
          let temperatureUnit = weatherData.current_units.temperature_2m
          
          Text("\(temperature) \(temperatureUnit)")
        } else if let weatherError = weatherError {
          Text("Error: \(weatherError)")
        } else {
          Text("--")
        }
        
      } else if locationManager.locationError != nil {
        Text("No location received")
      } else {
        Text("Fetching location...")
      }
    }
    .onAppear {
      locationManager.startFetchingLocation()
    }
    .onDisappear {
      locationManager.stopFetchingLocation()
    }
    .onChange(of: locationManager.userLatitude) {
      if let latitude = locationManager.userLatitude,
         let longitude = locationManager.userLongitude {
        Task {
          await fetchWeather(latitude: latitude, longitude: longitude)
        }
      }
    }
    .onChange(of: locationManager.userLongitude) {
      if let latitude = locationManager.userLatitude,
         let longitude = locationManager.userLongitude {
        Task {
          await fetchWeather(latitude: latitude, longitude: longitude)
        }
      }
    }
  }
}

#Preview {
  WeatherView()
}
