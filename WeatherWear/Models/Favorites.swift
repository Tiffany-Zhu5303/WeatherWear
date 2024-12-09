//
//  Favorites.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/16/24.
//

import Foundation
import SwiftData

@Model
class Favorite: Identifiable {
  @Attribute(.unique) var id: UUID = UUID()
  @Relationship(deleteRule: .nullify) var item: Item?
  @Relationship(deleteRule: .nullify) var outfit: Outfit?
  
  init(item: Item? = nil, outfit: Outfit? = nil) {
    self.item = item
    self.outfit = outfit
  }
  
  func deleteFavorite(modelContext: ModelContext) {
    modelContext.delete(self)
    do {
      try modelContext.save()
      print("favorite deleted successfully")
    } catch {
      print("favorite deletion unsuccessful: \(error.localizedDescription)")
    }
  }
}
