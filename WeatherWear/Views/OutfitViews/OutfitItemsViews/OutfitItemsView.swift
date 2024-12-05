//
//  OutfitItemsView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/27/24.
//

import SwiftUI

struct OutfitItemsView: View {
  @Environment(\.modelContext) var modelContext
  @ObservedObject var outfitView: OutfitViewModel
  @State private var capturedThumbnail: Bool = false
  @State private var selectedItem: Item?
  @Binding var selectedItems: [ItemCategory: Item]
  
  var body: some View {
    ZStack {
      Color.white
      ForEach(outfitView.outfit.items, id: \.id) { item in
        if let uiImage = UIImage(data: item.image) {
          Image(uiImage: uiImage)
            .resizable()
            .scaledToFit()
            .resizableView(
              transform:
                Binding(
                  get: {outfitView.outfit.transforms[item.id] ?? Transform()},
                  set: {newTransform in
                    outfitView.outfit.updateTransform(for: item.id, newTransform: newTransform)})
            )
            .zIndex(selectedItem?.id == item.id ? 10 : 1)
            .onTapGesture {
              selectedItem = item
            }
            .onAppear{
              selectedItems[item.category] = item
              print("selectedItems: \(String(describing: outfitView.outfit.transforms[item.id]?.size))")
            }
            .onDisappear{
              if !capturedThumbnail {
                captureOutfitThumbnail()
                capturedThumbnail = true
              }
            }
        }
      }
    }
  }
}

#Preview {
  OutfitItemsView(outfitView: OutfitViewModel(outfit: Outfit(items: initialItems)), selectedItems: .constant([:]))
}

extension OutfitItemsView {
  /// Captures the thumbnail of the outfit items view
  /// - Returns: Optional UIImage of the entire OutfitItemsView
  private func captureOutfitThumbnail() {
    // Create a UIHostingController to render the OutfitItemsView in isolation
    let hostingController = UIHostingController(rootView: self)

    // You can get the size of the view from its parent container (or dynamically set it)
    let size = CGSize(width: UIScreen.main.bounds.width, height: 800)
    
    hostingController.view.frame = CGRect(origin: .zero, size: size)
    
    // Ensure the view is laid out before capturing the screenshot
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      // Ensure the layout is complete before capturing
      let renderer = UIGraphicsImageRenderer(size: hostingController.view.bounds.size)
      let capturedImage = renderer.image { _ in
        hostingController.view.drawHierarchy(in: hostingController.view.bounds, afterScreenUpdates: true)
      }
      
      // Save the captured thumbnail image
      self.saveOutfitThumbnail(capturedImage)
    }
  }
  
  /// Saves the captured thumbnail image to a file or model
  /// - Parameter image: Captured UIImage of the outfit
  func saveOutfitThumbnail(_ image: UIImage) {
    let imagePath = image.save(to: "outfit-\(outfitView.outfit.id)-thumbnail.png")
    let imageData = image.jpegData(compressionQuality: 1.0)
    
    DispatchQueue.main.async {
      outfitView.outfit.thumbnail = imageData!
      print("Thumbnail saved at path: \(imagePath)")
    }
  }
}
