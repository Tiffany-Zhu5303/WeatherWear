//
//  CardElement.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/1/24.
//

import Foundation
import SwiftUI

protocol CardElement {
  var id: UUID { get }
  var transform: Transform { get set }
}

extension CardElement {
  func index(in array: [CardElement]) -> Int? {
    array.firstIndex { $0.id == id }
  }
}

struct ImageElement: CardElement {
  let id = UUID()
  var transform = Transform()
  var image: Image
}
