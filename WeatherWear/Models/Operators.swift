//
//  Operators.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/6/24.
//

import Foundation
import SwiftUI

func + (left: CGSize, right: CGSize) -> CGSize {
  CGSize(
    width: left.width + right.width,
    height: left.height + right.height)
}
