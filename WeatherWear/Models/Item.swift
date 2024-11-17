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
  @Attribute var dateAdded: Date
  @Attribute var image: Data
  @Relationship var category: ItemCategory

  init(dateAdded: Date = .now, image: Data? = nil, category: ItemCategory = ItemCategory(name: "Default")) {
    self.dateAdded = dateAdded
    self.image = image ?? UIImage(systemName: "hanger")?.pngData() ?? UIImage(named:"error-image")!.pngData()!
    self.category = category
  }
}
