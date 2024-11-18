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
  @Query private var existingItems: [Item]
  
  func addDefaultData() {
    if(existingCategories.isEmpty){
      let defaultItems = ["Shirt", "Pants", "Skirt", "Dress", "Shoes", "Bag"]
      
      for defaultItem in defaultItems {
        let item = ItemCategory(name: defaultItem)
        modelContext.insert(item)
        print("Inserted category: \(defaultItem)")
      }
    }
    
    if(existingItems.isEmpty) {
      for defaultItem in initialItems {
        let categoryName = defaultItem.category.name
        let category = modelContext.fetchCategory(named: categoryName) ?? {
          let newCategory = ItemCategory(name: categoryName)
          modelContext.insert(newCategory)
          return newCategory
        }()
        
        let newItem = Item(dateAdded: defaultItem.dateAdded, image: defaultItem.image, category: category)
        
        modelContext.insert(newItem)
        print("Inserted Item: \(newItem.id) and \(defaultItem.category.name)")
      }
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
