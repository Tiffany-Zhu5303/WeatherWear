//
//  Item.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/13/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Item: Identifiable {
  @Attribute var id: UUID = UUID()
  @Attribute var type: String
  @Attribute var dateAdded: Date

  init(type: String, dateAdded: Date = .now) {
    self.type = type
    self.dateAdded = dateAdded
  }
}
