//
//  Outfits.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/13/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Outfit: Identifiable {
  @Attribute var id: UUID = UUID()
  @Attribute var name: String
  @Attribute var dateAdded: Date
  @Attribute var transforms: [UUID: Transform] = [:]
  @Relationship var items: [Item]
  
  init(name: String = "", dateAdded: Date = .now, items: [Item] = []){
    self.name = name
    self.dateAdded = dateAdded
    self.items = items
    self.transforms = items.reduce(into: [:]) { result, item in
      result[item.id] = Transform()
    }
  }
  
  // Helper method to update the transform for an item in the outfit
  func updateTransform(for itemID: UUID, newTransform: Transform) {
    transforms[itemID] = newTransform
  }
}
