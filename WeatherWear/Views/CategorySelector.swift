//
//  CategorySelector.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/1/24.
//

import SwiftUI

enum CategoryState: Int, CaseIterable {
  case outfits
  case items
  case favorites
}

struct CategorySelector: View {
  @Binding var categoryState: CategoryState
  
  func iconName(for category: CategoryState) -> String {
    switch category {
    case .items: return "hanger"
    case .outfits: return "door.sliding.left.hand.closed"
    case .favorites: return "heart.fill"
    }
  }
  
  var body: some View {
    HStack {
      ForEach(CategoryState.allCases, id: \.self) { category in
        Button(action: {
          categoryState = category
        }) {
          Image(systemName: iconName(for: category))
            .resizable()
            .scaledToFit()
            .frame(width: 15, height: 30)
            .foregroundColor(Color("Moonstone"))
            .padding(EdgeInsets(top: 5, leading: 38, bottom: 5, trailing: 38))
            .background(categoryState == category ? Color("MintGreen") : Color.clear)
            .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
      }
    }
    .background(Color.gray.opacity(0.1))
    .cornerRadius(10)
  }
  
}

#Preview {
  CategorySelector(categoryState: .constant(.items))
}
