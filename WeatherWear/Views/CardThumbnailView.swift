//
//  CardThumbnailView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/5/24.
//
import SwiftUI

struct CardThumbnailView: View {
  let card: Card
  
  var body: some View {
    RoundedRectangle(cornerRadius: 15)
      .foregroundStyle(Color(card.backgroundColor))
      .frame(
        width: Settings.thumbnailSize.width,
        height:  Settings.thumbnailSize.height)
      .shadow(
        color: Color("MintGreen"),
        radius: 5, x: 0.0, y: 0.0)
      .overlay(
        RoundedRectangle(cornerRadius: 15)
          .stroke(Color("Moonstone"), lineWidth: 1)
      )
  }
}

#Preview {
  CardThumbnailView(card: initialItemCards[0])
}
