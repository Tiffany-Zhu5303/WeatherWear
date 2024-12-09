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
  @Attribute(.unique) var id: UUID = UUID()
  @Attribute var dateAdded: Date
  @Attribute var image: Data
  @Attribute var itemType: String
  @Relationship var category: ItemCategory

  init(dateAdded: Date = .now, image: Data? = nil, itemType: String = "", category: ItemCategory = ItemCategory(name: "Default")) {
    self.dateAdded = dateAdded
    self.image = image ?? UIImage(systemName: "hanger")?.pngData() ?? UIImage(named:"error-image")!.pngData()!
    self.itemType = itemType
    self.category = category
  }
  
  func deleteItem(modelContext: ModelContext) {
    modelContext.delete(self)
    do {
      try modelContext.save()
      print("item deleted successfully")
    } catch {
      print("item deletion unsuccessful: \(error.localizedDescription)")
    }
  }
}
