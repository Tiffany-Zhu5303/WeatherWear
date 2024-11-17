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

let initialOutfitCards: [Card] = [
  Card(backgroundColor: Color("MintGreen")),
]

let initialItemCards: [Card] = [
  Card(backgroundColor: Color("Moonstone"), elements: initialElements),
  Card(backgroundColor: Color("Moonstone")),
  Card(backgroundColor: Color("Moonstone")),
]

let initialFavoriteCards: [Card] = [
  Card(backgroundColor: Color("PaynesGray")),
  Card(backgroundColor: Color("PaynesGray")),
]

let initialElements: [CardElement] = [
  ImageElement(
    transform: Transform(
      size: CGSize(width: 255, height: 185),
      rotation: .init(degrees: 10),
      offset: CGSize(width: 40, height: -220)),
    image: Image("tshirt1")),
  ImageElement(
    transform: Transform(offset: CGSize(width: -62, height: 0)),
    image: Image("skirt1")),
  ImageElement(
    transform: Transform(
      size: CGSize(width: 295, height: 210),
      rotation: .init(degrees: -15),
      offset: CGSize(width: -5, height: 178)),
    image: Image("skirt2")),
]
