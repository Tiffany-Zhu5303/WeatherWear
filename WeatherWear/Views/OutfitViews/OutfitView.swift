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
  @ObservedObject var outfitView: OutfitViewModel
  @State private var currentModal: ItemSelection = .tops
  @State private var selectedItems: [ItemCategory: Item] = [:]
  
  private func saveOutfit() {
    do {
      try modelContext.save()
      print("Outfit successfully saved!")
    } catch {
      print("Failed to save outfit: \(error)")
    }
  }
  
  private func deleteOutfit() {
    modelContext.delete(outfitView.outfit)
    saveOutfit()
  }
  
  var body: some View {
    ZStack {
      NavigationStack {
        ZStack(alignment: .bottom) {
          VStack {
            OutfitItemsView(outfitView: outfitView, selectedItems: $selectedItems)
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
            outfitView: outfitView,
            modal: $currentModal,
            selectedItems: $selectedItems)
          .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
      }
    }
  }
}

#Preview {
  OutfitView(outfitView: OutfitViewModel(outfit: Outfit(items:[Item(), Item(), Item()]))
  )
}
