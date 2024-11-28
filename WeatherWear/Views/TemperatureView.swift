//
//  TemperatureView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/25/24.
//

import SwiftUI

struct TemperatureView: View {
  @StateObject private var locationManager = LocationManager()
  
  
  var body: some View {
    VStack {
        if let latitude = locationManager.userLatitude,
           let longitude = locationManager.userLongitude {
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
  TemperatureView()
}
