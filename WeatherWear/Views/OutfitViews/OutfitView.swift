//
//  OutfitView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/17/24.
//

import SwiftUI
import SwiftData

struct OutfitView: View {
  @Environment(\.dismiss) var dismiss
  @Environment(\.modelContext) var modelContext
  @State private var currentModal: ItemSelection = .tops
  @State private var selectedItems: [ItemCategory: Item] = [:]
  @Binding var outfit: Outfit
  
  private func saveOutfit() {
    do {
      try modelContext.save()
      print("Outfit successfully saved!")
    } catch {
      print("Failed to save outfit: \(error)")
    }
  }
  
  private func deleteOutfit() {
    DispatchQueue.main.async {
      modelContext.delete(outfit)
      saveOutfit()
    }
  }
  
  var body: some View {
    ZStack {
      NavigationStack {
        ZStack(alignment: .bottom) {
          VStack {
            OutfitItemsView(selectedItems: $selectedItems, outfit: $outfit)
              .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                  Button("Delete Outfit") {
                    deleteOutfit()
                    dismiss()
                  }
                  .foregroundStyle(Color(.red))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                  Button("Done") {
                    saveOutfit()
                    dismiss()
                  }
                }
              }
          }
          ItemToolbar(
            outfit: $outfit,
            modal: $currentModal,
            selectedItems: $selectedItems)
          .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{
          selectedItems = Dictionary(uniqueKeysWithValues: outfit.items.compactMap { item in
              (item.category, item)
          })
        }
      }
    }
  }
}

#Preview {
  OutfitView(
    outfit: .constant(Outfit(items: [Item()]))
  )
}
