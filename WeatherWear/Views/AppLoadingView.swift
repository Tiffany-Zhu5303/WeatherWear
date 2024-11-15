//
//  AppLoadingView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/7/24.
//

import SwiftUI
import SwiftData

struct AppLoadingView: View {
  @State private var showLaunchScreen: Bool = true
  @Environment(\.modelContext) private var modelContext
  @Query private var existingCategories: [ItemCategory]
  
  func addDefaultItemCategories() {
    if(existingCategories.isEmpty){
      let defaultItems = ["Shirt", "Pants", "Skirt", "Dress", "Shoes", "Bag"]
      
      for defaultItem in defaultItems {
        let item = ItemCategory(name: defaultItem)
        modelContext.insert(item)
      }
    }
  }
  
  var body: some View {
    if(showLaunchScreen) {
      LaunchScreenView()
        .ignoresSafeArea()
        .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.linear(duration: 1.5)) {
              showLaunchScreen = false
            }
          }
        }
    } else {
      MultipleCardsView()
        .onAppear{
          addDefaultItemCategories()
        }
    }
  }
}

#Preview {
  AppLoadingView()
}
