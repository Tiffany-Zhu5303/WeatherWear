//
//  Transform.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/5/24.
//

import Foundation
import SwiftUI

struct Transform {
  var size = CGSize(
    width: Settings.defaultElementSize.width,
    height: Settings.defaultElementSize.height
  )
  var rotation: Angle = .zero
  var offset: CGSize = .zero
}
