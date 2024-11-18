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
  @Attribute var id: UUID = UUID()
  @Relationship var item: Item?
  @Relationship var outfit: Outfit?
  
  init(item: Item? = nil, outfit: Outfit? = nil) {
    self.item = item
    self.outfit = outfit
  }
}
