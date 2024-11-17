//
//  ImageExtension.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/16/24.
//

import Foundation
import SwiftUI

extension UIImage {
  /// Creates a UIImage from Data
  /// - Parameter data: The Data representing the image.
  /// - Returns: A UIImage, or nil if the data cannot be converted.
  static func from(data: Data) -> UIImage? {
      return UIImage(data: data)
  }
}
