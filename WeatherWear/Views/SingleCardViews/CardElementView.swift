//
//  CardElementView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/7/24.
//

import SwiftUI

struct ImageElementView: View {
  let element: ImageElement
  var body: some View {
    element.image
      .resizable()
      .aspectRatio(contentMode: .fit)
  }
}

struct CardElementView: View {
  let element: CardElement
  var body: some View {
    if let element = element as? ImageElement {
      ImageElementView(element: element)
    }
  }
}

#Preview {
  CardElementView(element: initialElements[1])
}
