//
//  WeatherDetailView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 12/7/24.
//

import SwiftUI

struct WeatherDetailView: View {
  @StateObject private var locationManager = LocationManager()
  @State private var weatherData: ForecastWeatherObject?
  @State private var weatherError: String?
  @State private var weatherForecast: [String: [String:Int]] = [:]
  @State private var selectedForecastDays: Int?
  
  func fetchWeather(latitude: Double, longitude: Double, forecastDays: Int) async {
    let weatherServer = WeatherService()
    
    do {
      weatherData = try await weatherServer.getForecastWeather(
        latitude: "\(latitude)",
        longitude: "\(longitude)",
        forecastDays: String(forecastDays)
      )
    } catch {
      weatherError = error.localizedDescription
    }
    
    if let weatherData = weatherData {
      updateWeatherForecast(
        times: weatherData.hourly.time,
        temperatures: weatherData.hourly.temperature_2m,
        temperatureUnit: weatherData.hourly_units.temperature_2m)
    }
  }
  
  func cleanTime(time: String) -> [String] {
    let cleanTime = time.split(separator: "T")
    return [String(cleanTime[0]), String(cleanTime[1])]
  }
  
  func updateWeatherForecast(times: [String], temperatures: [Double], temperatureUnit: String) {
    var updatedForecast: [String: [String: Int]] = [:]
    
    if temperatures.count == times.count {
      for index in times.indices {
        let cleanTime = cleanTime(time: times[index])
        let date = cleanTime[0]
        let time = cleanTime[1]
        let cleanTemperature = Int(temperatures[index])
        
        if updatedForecast[date] == nil {
          updatedForecast[date] = [:]
        }
        updatedForecast[date]?[time] = cleanTemperature
      }
      
      weatherForecast = updatedForecast
    }
  }
  
  // Default simulator location: Apple Headquarter in CA
  var body: some View {
    VStack {
      Text("Weather Forecast")
        .font(.title)
        .fontWeight(.bold)
        .foregroundStyle(Color("Moonstone"))
        .padding(.top)
      Picker("How many days do you want to see?", selection: $selectedForecastDays) {
        Text("Choose a number of days").tag(nil as Int?)
        ForEach(1..<10) { day in
          if day == 1 {
            Text("\(day) day (Tomorrow)").tag(day as Int)
          } else {
            Text("\(day) days").tag(day as Int)
          }
        }
      }
      .pickerStyle(MenuPickerStyle())
      Spacer()
      if locationManager.userLatitude != nil && locationManager.userLongitude != nil {
        
        if !weatherForecast.isEmpty {
          WeatherChartView(weatherData: $weatherForecast)
          Spacer()
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
    .onChange(of: selectedForecastDays) {
      if let latitude = locationManager.userLatitude,
         let longitude = locationManager.userLongitude,
         let forecastDays = selectedForecastDays{
        Task {
          await fetchWeather(
            latitude: latitude,
            longitude: longitude,
            forecastDays: forecastDays
          )
        }
      }
    }
  }
}

#Preview {
    WeatherDetailView()
}
