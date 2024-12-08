//
//  WeatherService.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 12/4/24.
//

import Foundation

struct CurrentWeatherObject: Codable, Hashable {
  let latitude: Double
  let longitude: Double
  let current_units: Units
  let current: currentData
}

struct ForecastWeatherObject: Codable, Hashable {
  let latitude: Double
  let longitude: Double
  let hourly_units: Units
  let hourly: hourlyData
}

struct currentData: Codable, Hashable {
  let time: String
  let interval: Int
  let temperature_2m: Double
}

struct hourlyData: Codable, Hashable {
  let time: [String]
  let temperature_2m: [Double]
}

struct Units: Codable, Hashable {
  let temperature_2m: String
  
  enum CodingKeys: String, CodingKey {
    case temperature_2m
  }
}

struct WeatherService {
  let baseURLString = "https://api.open-meteo.com/v1/"
  let session = URLSession.shared
  let decoder = JSONDecoder()
  
  func getCurrentWeather(
    latitude: String,
    longitude: String,
    temperatureUnit: String = "fahrenheit",
    forecastDays: String = "1"
  ) async throws -> CurrentWeatherObject {
    var urlComponents = URLComponents(string: baseURLString + "forecast")!
    let params = [
      "latitude": latitude,
      "longitude": longitude,
      "current": "temperature_2m",
      "temperature_unit": temperatureUnit,
      "forecast_days": forecastDays
    ]
    urlComponents.setQueryItems(with: params)
    
    guard let queryURL = urlComponents.url
    else {
      throw URLError(.badURL)
    }
    
    let request = URLRequest(url: queryURL)
    let (data, response) = try await session.data(for: request)
    
    guard
      let httpResponse = response as? HTTPURLResponse,
      (200..<300).contains(httpResponse.statusCode)
    else {
      throw URLError(.badServerResponse)
    }
    
    return try decoder.decode(CurrentWeatherObject.self, from: data)
  }
  
  func getForecastWeather(
    latitude: String,
    longitude: String,
    temperatureUnit: String = "fahrenheit",
    forecastDays: String
  ) async throws -> ForecastWeatherObject {
    print("Received parameters in getForecastWeather: \(latitude), \(longitude), \(temperatureUnit), \(forecastDays)")
    var urlComponents = URLComponents(string: baseURLString + "forecast")!
    let params = [
      "latitude": latitude,
      "longitude": longitude,
      "hourly": "temperature_2m",
      "temperature_unit": temperatureUnit,
      "forecast_days": forecastDays
    ]
    urlComponents.setQueryItems(with: params)
    
    guard let queryURL = urlComponents.url
    else {
      throw URLError(.badURL)
    }
    
    let request = URLRequest(url: queryURL)
    let (data, response) = try await session.data(for: request)
    
    guard
      let httpResponse = response as? HTTPURLResponse,
      (200..<300).contains(httpResponse.statusCode)
    else {
      throw URLError(.badServerResponse)
    }
    
    return try decoder.decode(ForecastWeatherObject.self, from: data)
  }
}
