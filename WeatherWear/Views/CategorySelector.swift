//
//  CategorySelector.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/1/24.
//

import SwiftUI

enum CategoryState {
  case items, outfits, favorites
}

struct CategorySelector: View {
  @Binding var categoryState: CategoryState
  
  var body: some View {
    Picker(selection: $categoryState, label: Text("")) {
      Image(systemName: "door.sliding.left.hand.closed")
        .symbolRenderingMode(.monochrome)
        .tint(Color(.red))
        .tag(CategoryState.outfits)
      Image(systemName: "hanger")
        .symbolRenderingMode(.monochrome)
        .foregroundStyle(Color("PaynesGray"))
        .tag(CategoryState.items)
      Image(systemName: "heart.fill")
        .symbolRenderingMode(.monochrome)
        .foregroundColor(Color("PaynesGray"))
        .tag(CategoryState.favorites)
    }
    .pickerStyle(.segmented)
    .frame(width: 300)
  }
}

#Preview {
  CategorySelector(categoryState: .constant(.items))
//    .background(Color("PaynesGray"))
}
