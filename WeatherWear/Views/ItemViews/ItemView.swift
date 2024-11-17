//
//  ItemView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/16/24.
//

import SwiftUI

struct ItemView: View {
  @Environment(\.dismiss) var dismiss
  @Binding var item: Item?
  
  var body: some View {
    NavigationStack {
      if let item = item {
        ZStack {
          Color.white
          if let uiImage = UIImage(data: item.image) {
            Image(uiImage: uiImage)
              .resizable()
              .scaledToFit()
              .frame(maxWidth: .infinity, maxHeight: .infinity)
          }
        }
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") { dismiss() }
          }
        }
      } else {
        Text("Error with selected item")
          .foregroundStyle(Color(.red))
      }
    }
  }
}

#Preview {
  ItemView(item: .constant(Item(category: ItemCategory(name: "shirt"))))
}
