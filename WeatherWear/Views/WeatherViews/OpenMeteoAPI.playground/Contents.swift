import UIKit
import SwiftUI

let baseURLString = "https://api.open-meteo.com/v1/"
var urlComponents = URLComponents(
  string: baseURLString + "forecast")!
var baseParams = [
  "latitude": "52.52",
  "longitude": "13.41",
  "hourly": "temperature_2m",
  "temperature_unit": "fahrenheit"
]
urlComponents.setQueryItems(with: baseParams)
urlComponents.url
urlComponents.url?.absoluteString
