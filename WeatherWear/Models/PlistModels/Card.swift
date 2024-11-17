//
//  Card.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/1/24.
//

import Foundation
import SwiftUI

struct Card: Identifiable {
  var id = UUID()
  var backgroundColor: Color = .white
  var elements: [CardElement] = []
//  var uiImage: UIImage?
}
