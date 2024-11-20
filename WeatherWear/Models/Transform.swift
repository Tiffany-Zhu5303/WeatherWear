//
//  Transform.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/5/24.
//

import Foundation
import SwiftUI
import SwiftData

struct Transform: Codable {
  var size: CGSize
  var rotation: Angle
  var offset: CGSize
  
  // Define custom CodingKeys to map to the JSON keys
  enum CodingKeys: String, CodingKey {
    case size
    case rotation
    case offset
  }
  
  // Default initializer
  init(size: CGSize = CGSize(width: Settings.defaultElementSize.width, height: Settings.defaultElementSize.height), rotation: Angle = .zero, offset: CGSize = .zero) {
    self.size = size
    self.rotation = rotation
    self.offset = offset
  }
  
  // Custom initializer for decoding
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.size = try container.decode(CGSize.self, forKey: .size)
    // Custom decoding for Angle (convert from Double)
    let rotationDegrees = try container.decode(Double.self, forKey: .rotation)
    self.rotation = Angle(degrees: rotationDegrees)
    self.offset = try container.decode(CGSize.self, forKey: .offset)
  }
  
  // Custom encoding method
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(size, forKey: .size)
    // Custom encoding for Angle (convert to Double)
    try container.encode(rotation.degrees, forKey: .rotation)
    try container.encode(offset, forKey: .offset)
  }
}
