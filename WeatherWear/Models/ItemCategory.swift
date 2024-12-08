//
//  ItemCategory.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/14/24.
//

import Foundation
import SwiftData

@Model
// Equatable to compare objects
class ItemCategory: Identifiable, Equatable {
  @Attribute(.unique) var id: UUID = UUID()
  @Attribute var name: String
  @Relationship var items: [Item] = []
  
  init(name: String = ""){
    self.name = name
  }
}
