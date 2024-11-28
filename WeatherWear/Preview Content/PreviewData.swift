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
  Item(
    image: UIImage(named: "tshirt1")!.pngData()!,
    itemType: "Tops",
    category: ItemCategory(name: "Shirt")),
  Item(
    image: UIImage(named:"skirt1")!.pngData()!,
    itemType: "Bottoms",
    category: ItemCategory(name:"Skirt")),
  Item(
    image: UIImage(named:"skirt2")!.pngData()!,
    itemType: "Bottoms",
    category: ItemCategory(name:"Skirt"))
]
