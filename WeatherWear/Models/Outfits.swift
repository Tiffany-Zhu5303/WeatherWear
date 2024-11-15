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
  @Attribute var dateAdded: Date
  @Relationship var items: [Item]
  
  init(dateAdded: Date = .now, items: [Item] = []){
    self.dateAdded = dateAdded
    self.items = items
  }
}
