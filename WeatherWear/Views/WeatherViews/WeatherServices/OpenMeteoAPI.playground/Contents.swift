import UIKit
import SwiftUI

struct CurrentWeatherObject: Codable, Hashable {
  let latitude: Double
  let longitude: Double
  let current_units: Units
  let current: currentData
}

struct currentData: Codable, Hashable {
  let time: String
  let interval: Int
  let temperature_2m: Double
}

struct ForecastWeatherObject: Codable, Hashable {
  let latitude: Double
  let longitude: Double
  let hourly_units: Units
  let hourly: hourlyData
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

let baseURLString = "https://api.open-meteo.com/v1/"
var urlComponents = URLComponents(
  string: baseURLString + "forecast")!

var baseParams = [
  "latitude": "52.52",
  "longitude": "13.41",
  "current": "temperature_2m",
  "temperature_unit": "fahrenheit",
  "forecast_days": "1"
]

urlComponents.setQueryItems(with: baseParams)
urlComponents.url

var queryURL = urlComponents.url
var request = URLRequest(url: queryURL!)
let session = URLSession.shared
let decoder = JSONDecoder()
var currentObject: CurrentWeatherObject?

Task {
  let (data, response) = try await session.data(for: request)
  guard
    let response = response as? HTTPURLResponse,
    (200..<300).contains(response.statusCode)
  else {
    print(">>> response outside bounds")
    return
  }
  let dataObject = try decoder.decode(CurrentWeatherObject.self, from: data)
  currentObject = dataObject
  currentObject
}

baseParams = [
  "latitude": "52.52",
  "longitude": "13.41",
  "hourly": "temperature_2m",
  "temperature_unit": "fahrenheit",
  "forecast_days": "3"
]

urlComponents.setQueryItems(with: baseParams)
urlComponents.url

queryURL = urlComponents.url
request = URLRequest(url: queryURL!)
var forecastObject: ForecastWeatherObject?

Task {
  let (data, response) = try await session.data(for: request)
  guard
    let response = response as? HTTPURLResponse,
    (200..<300).contains(response.statusCode)
  else {
    print(">>> response outside bounds")
    return
  }
  let dataObject = try decoder.decode(ForecastWeatherObject.self, from: data)
  forecastObject = dataObject
  forecastObject
}
