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
  @Query @MainActor private var existingCategories: [ItemCategory]
  
  func addDefaultData() {
    guard existingCategories.isEmpty else { return }
    let defaultItems = ["Shirt", "Pants", "Skirt", "Sneakers", "Bag"]
    
    for defaultItem in defaultItems {
      let item = ItemCategory(name: defaultItem)
      modelContext.insert(item)
      print("Inserted category: \(defaultItem)")
    }
    
    do {
      try modelContext.save()
      print("Model context saved.")
    } catch {
      print("Failed to save model context: \(error)")
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
          addDefaultData()
        }
    }
  }
}

#Preview {
  AppLoadingView()
}
