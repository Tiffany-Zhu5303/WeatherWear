//
//  WeatherView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 12/2/24.
//

import SwiftUI

struct WeatherView: View {
  @StateObject private var locationManager = LocationManager()
  
  
  var body: some View {
    VStack {
      if let latitude = locationManager.userLatitude,
         let longitude = locationManager.userLongitude {
//        let weatherAPIURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=YOUR_API_KEY"
        Text("Your Coordinates:")
        Text("Latitude: \(latitude)")
        Text("Longitude: \(longitude)")
        
        // Use these coordinates for your Weather API
      } else if let error = locationManager.locationError {
        Text("Error: \(error)")
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
  }
}

#Preview {
  WeatherView()
}
