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
                    saveOutfitThumbnail(outfitId: outfitView.outfit.id)
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

extension OutfitView {
  /// captures outfit thumbnail in OutfitView
  /// - Returns: UIImage of the thumbnail
  func captureOutfitThumbnail() -> UIImage? {
    // Create a UIHostingController with OutfitItemsView
    let hostingController = UIHostingController(rootView: OutfitItemsView(outfitView: outfitView, selectedItems: $selectedItems))
    
    // Set the size of the view you want to capture
    hostingController.view.bounds = CGRect(x: 0, y: 0, width: 300, height: 200) // Adjust size as needed
    
    // Begin capturing the view as an image
    UIGraphicsBeginImageContextWithOptions(hostingController.view.bounds.size, false, 0)
    hostingController.view.layer.render(in: UIGraphicsGetCurrentContext()!)
    let capturedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return capturedImage
  }
  
  /// saves outfit thumbnail from item arrangement
  /// - Parameter outfitId: the id of the outfit the thumbnail is saved for
  func saveOutfitThumbnail(outfitId: UUID) {
    if let image = captureOutfitThumbnail() {
      let imagePath = image.save(to: "outfit\(outfitId)-thumbnail.png")
      print("Thumbnail saved at path: \(imagePath)")
    }
  }
}


#Preview {
  OutfitView(outfitView: OutfitViewModel(outfit: Outfit(items:[Item(), Item(), Item()]))
  )
}
