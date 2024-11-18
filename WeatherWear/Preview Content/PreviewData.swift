//
//  PreviewData.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/6/24.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
let initialItems: [Item] = [
  Item(image: UIImage(named: "tshirt1")!.pngData()!, category: ItemCategory(name: "Shirt")),
  Item(image: UIImage(named:"skirt1")!.pngData()!, category: ItemCategory(name:"Skirt")),
  Item(image: UIImage(named:"skirt2")!.pngData()!, category: ItemCategory(name:"Skirt"))
]
