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
  @Attribute var thumbnail: Data
  @Relationship var items: [Item]
  
  init(
    name: String = "\(Date().formatted(date: .abbreviated, time: .shortened)) outfit",
    dateAdded: Date = .now,
    thumbnail: Data? = nil,
    items: [Item] = []
  ){
    self.name = name
    self.dateAdded = dateAdded
    self.items = items
    self.thumbnail = thumbnail ?? UIImage(named:"error-image")!.pngData()!
    self.transforms = items.reduce(into: [:]) { result, item in
      result[item.id] = Transform()
    }
  }
  
  // Helper method to update the transform for an item in the outfit
  func updateTransform(for itemID: UUID, newTransform: Transform) {
    self.transforms[itemID] = newTransform
  }
  
  func addItemToOutfit(_ item: Item) {
    self.items.append(item)
    self.transforms[item.id] = Transform()
  }
  
  func removeItemFromOutfit(_ item: Item) {
    self.items.removeAll(where: { $0.id == item.id })
  }
}

class ExistingOutfits: ObservableObject {
  @Published var outfits: [Outfit] = []
  
  func addItemToOutfit(_ item: Item, outfitId: UUID) {
    let outfit = self.outfits.firstIndex(where: {$0.id == outfitId})
    if let outfit {
      self.outfits[outfit].items.append(item)
      self.outfits[outfit].transforms[item.id] = Transform()
    } else {
      print("Outfit not found")
    }
  }
  
  func removeItemFromOutfit(_ item: Item, outfitId: UUID) {
    let outfit = self.outfits.firstIndex(where: {$0.id == outfitId})
    if let outfit {
      self.outfits[outfit].items.removeAll(where: { $0.id == item.id })
    }
  }
}
