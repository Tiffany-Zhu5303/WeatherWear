//
//  CardThumbnailView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/5/24.
//
import SwiftUI

struct CardThumbnailView: View {
  var body: some View {
    RoundedRectangle(cornerRadius: 15)
      .foregroundStyle(Color(.white))
      .frame(
        width: Settings.thumbnailSize.width,
        height:  Settings.thumbnailSize.height)
      .shadow(
        color: Color.black.opacity(0.2),
        radius: 5, x: 0.0, y: 0.0)
  }
}

#Preview {
  CardThumbnailView()
}
