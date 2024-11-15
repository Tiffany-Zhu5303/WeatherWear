//
//  WeatherWearApp.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 10/31/24.
//

import SwiftUI
import SwiftData

@main
struct WeatherWearApp: App {
  var body: some Scene {
    WindowGroup {
      AppLoadingView()
        .modelContainer(for: [Item.self, ItemCategory.self], inMemory: false)
    }
  }
}
