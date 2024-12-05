import UIKit
import SwiftUI

struct Object: Codable, Hashable {
  let latitude: Double
  let longitude: Double
  let current_units: currentUnits
  let current: currentData
}

struct currentUnits: Codable, Hashable {
  let interval: String
  let temperature_2m: String
}

struct currentData: Codable, Hashable {
  let time: String
  let interval: Int
  let temperature_2m: Double
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

let queryURL = urlComponents.url
let request = URLRequest(url: queryURL!)
let session = URLSession.shared
let decoder = JSONDecoder()
var object: Object?

Task {
  let (data, response) = try await session.data(for: request)
  guard
    let response = response as? HTTPURLResponse,
    (200..<300).contains(response.statusCode)
  else {
    print(">>> response outside bounds")
    return
  }
  let dataObject = try decoder.decode(Object.self, from: data)
  object = dataObject
  object
}
