//
//  ItemView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/16/24.
//

import SwiftUI

struct ItemView: View {
  @Environment(\.dismiss) var dismiss
  @Environment(\.modelContext) var modelContext
  @Binding var item: Item?
  
  private func deleteItem() {
    guard let itemToDelete = item
    else {
      print("Deleting item failed")
      return
    }
    
    modelContext.delete(itemToDelete)
    
    do {
      try modelContext.save()
      print("Successfully deleted item!")
      dismiss()
    } catch {
      print("Failed to delete item: \(error.localizedDescription)")
    }
  }

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
          ToolbarItem(placement: .navigationBarLeading) {
            Button("Delete Item") {
              deleteItem()
            }
            .foregroundStyle(Color(.red))
          }
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
