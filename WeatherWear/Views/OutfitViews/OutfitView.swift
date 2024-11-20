//
//  OutfitView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/17/24.
//

import SwiftUI

struct OutfitView: View {
  @Environment(\.dismiss) var dismiss
  @Environment(\.modelContext) var modelContext
  @State private var currentModal: ItemSelection?
  @Binding var outfit: Outfit?
  
  private func deleteOutfit() {
    guard let outfitToDelete = outfit
    else {
      print("Deleting outfit failed")
      return
    }
    
    modelContext.delete(outfitToDelete)
    
    do {
      try modelContext.save()
      print("Successfully deleted outfit!")
      dismiss()
    } catch {
      print("Failed to delete outfit: \(error.localizedDescription)")
    }
  }
  
  var body: some View {
    ZStack {
      NavigationStack {
        if let outfit = outfit {
          ZStack(alignment: .bottom) {
            VStack {
              ZStack {
                Color.white
                ForEach(outfit.items, id: \.id) { item in
                  if let uiImage = UIImage(data: item.image) {
                    Image(uiImage: uiImage)
                      .resizableView(
                        transform:
                          Binding(
                            get: {outfit.transforms[item.id] ?? Transform()},
                            set: {newTransform in
                            outfit.updateTransform(for: item.id, newTransform: newTransform)})
                      )
                      .scaledToFit()
                      .frame(maxWidth: .infinity, maxHeight: .infinity)
                  }
                }
              }
              .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                  Button("Delete Outfit") {
                    deleteOutfit()
                  }
                  .foregroundStyle(Color(.red))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                  Button("Done") { dismiss() }
                }
              }
            }
            ItemToolbar(modal: $currentModal)
              .ignoresSafeArea()
          }
        } else {
          Text("Error with selected item")
            .foregroundStyle(Color(.red))
        }
      }
    }
  }
}

#Preview {
  OutfitView(outfit: .constant(
    Outfit(
      name: Date().description,
      items:
        [Item(category: ItemCategory(name: "shirt")), Item(category: ItemCategory(name: "pants"))])))
}
