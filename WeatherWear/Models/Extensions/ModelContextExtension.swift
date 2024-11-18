//
//  ModelContextExtension.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/17/24.
//

import Foundation
import SwiftData

extension ModelContext {
  /// to check if there is an existing category in ItemCategory
  /// - Parameter name: name of ItemCategory
  /// - Returns : ItemCategory if it exists or null
  func fetchCategory(named name: String) -> ItemCategory? {
    // Define a fetch descriptor with a predicate
    let fetchDescriptor = FetchDescriptor<ItemCategory>(
        predicate: #Predicate<ItemCategory> { $0.name == name }
    )
    return try? fetch(fetchDescriptor).first
  }
}
