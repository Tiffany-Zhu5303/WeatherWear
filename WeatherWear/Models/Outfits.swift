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
  @Attribute(.unique) var id: UUID = UUID()
  @Attribute var name: String
  @Attribute var dateAdded: Date
  @Attribute var transforms: [UUID: Transform] = [:]
  @Attribute var thumbnail: Data
  @Relationship(deleteRule: .nullify) var items: [Item]
  
  init(
    name: String = "\(Date().formatted(date: .abbreviated, time: .shortened)) outfit",
    dateAdded: Date = .now,
    thumbnail: Data? = nil,
    items: [Item] = []
  ){
    self.name = name
    self.dateAdded = dateAdded
    self.items = items
    self.thumbnail = thumbnail ?? UIImage.generateColorBlock(color: .white).pngData()!
    self.transforms = items.reduce(into: [:]) { result, item in
      result[item.id] = Transform()
    }
  }
  
  // Helper method to update the transform for an item in the outfit
  func updateTransform(for itemID: UUID, newTransform: Transform) {
    self.transforms[itemID] = newTransform
  }
  
  func addItemToOutfit(_ item: Item) {
    print("Before: \(self.items)")
    self.items.append(item)
    print("After: \(self.items)")
    self.transforms[item.id] = Transform()
  }
  
  func removeItemFromOutfit(_ item: Item) {
    self.items.removeAll(where: { $0.id == item.id })
  }
  
  func deleteOutfit(modelContext: ModelContext) {
    modelContext.delete(self)
    do {
      try modelContext.save()
      print("outfit deleted successfully")
    } catch {
      print("outfit deletion unsuccessful: \(error.localizedDescription)")
    }
  }
}
