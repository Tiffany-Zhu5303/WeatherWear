//
//  OutfitItemsView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/27/24.
//

import SwiftUI

struct OutfitItemsView: View {
  @Environment(\.modelContext) var modelContext
  @ObservedObject var outfitView: OutfitViewModel
  @Binding var selectedItems: [ItemCategory: Item]
  
  var body: some View {
    ZStack {
      Color.white
      ForEach(outfitView.outfit.items, id: \.id) { item in
        if let uiImage = UIImage(data: item.image) {
          Image(uiImage: uiImage)
            .resizable()
            .scaledToFit()
            .resizableView(
              transform:
                Binding(
                  get: {outfitView.outfit.transforms[item.id] ?? Transform()},
                  set: {newTransform in
                    outfitView.outfit.updateTransform(for: item.id, newTransform: newTransform)})
            )
            .onAppear{
              selectedItems[item.category] = item
              print("selectedItems: \(String(describing: outfitView.outfit.transforms[item.id]?.size))")
            }
        }
      }
    }
  }
}

#Preview {
  OutfitItemsView(outfitView: OutfitViewModel(outfit: Outfit(items: initialItems)), selectedItems: .constant([:]))
}
