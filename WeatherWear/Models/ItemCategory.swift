//
//  ItemCategory.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/14/24.
//

import Foundation
import SwiftData

@Model
class ItemCategory: Identifiable {
  @Attribute var id: UUID = UUID()
  @Attribute var name: String
  
  init(name: String = ""){
    self.name = name
  }
}
