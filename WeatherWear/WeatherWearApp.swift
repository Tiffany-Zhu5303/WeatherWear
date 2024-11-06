//
//  WeatherWearApp.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 10/31/24.
//

import SwiftUI

@main
struct WeatherWearApp: App {
  @StateObject var store = CardStore(defaultData: true)
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(store)
    }
  }
}
