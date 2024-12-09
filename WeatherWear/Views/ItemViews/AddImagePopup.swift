//
//  AddImagePopup.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/14/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct AddImagePopup: View {
  @State private var selectedImage: PhotosPickerItem? = nil
  @State private var showPasteAlert: Bool = false
  @Binding var imageData: Data?
  @Binding var showPopup: Bool
  @Query var items: [Item]
  
  var body: some View {
    VStack {
      Text("Add Item")
        .font(.title2)
        .foregroundStyle(Color("Moonstone"))
        .padding(.top, 20)
      Text("Tip: add items from the subject of your images")
        .font(.caption)
        .foregroundStyle(Color("Moonstone"))
        .padding(.bottom, 20)
      Group {
        HStack {
          PhotosPicker(
            selection: $selectedImage,
            matching: .images,
            photoLibrary: .shared()) {
              Text("Add from Camera Roll")
              Spacer()
              Image(systemName: "photo.on.rectangle")
            }
            .onChange(of: selectedImage) {
              guard let selectedImage = selectedImage
              else {
                print("No image selected.")
                return
              }
              Task {
                do {
                  if let data = try await selectedImage.loadTransferable(type: Data.self) {
                    imageData = data
                    print("Image data added in AddImagePopup, size: (\(data.count)) bytes")
                    showPopup = false
                  }else {
                    print("Failed to load image data in AddImagePopup")
                  }
                } catch {
                  print("Error loading image data: \(error.localizedDescription).")
                }
              }
            }
        }
        HStack {
          Button(action: {
            let pasteboard = UIPasteboard.general
              if let image = pasteboard.image {
                print("Image found: \(image.size)")
                if let data = image.jpegData(compressionQuality: 1.0) {
                  imageData = data
                  showPopup = false
                  print("Image pasted successfully.")
                }
              } else {
                showPasteAlert = true
                print("Failed to retrieve image from pasteboard.")
              }
          }){
            HStack {
              Text("Paste")
              Spacer()
              Image(systemName: "document.on.clipboard")
            }
            .frame(
              maxWidth: .infinity
            )
          }
          .alert("Invalid Paste", isPresented: $showPasteAlert) {
            Button("OK", role: .cancel) {
              showPasteAlert = false
            }
          } message: {
            Text("No valid image found in the pasteboard. Please copy an image first.")
          }
        }
      }
      .padding([.vertical, .horizontal])
      .foregroundStyle(Color("Moonstone"))
      .background(Color("AntiFlashWhite"))
    }
    .padding(.bottom, 20)
    .frame(maxWidth: .infinity)
    .background(
      RoundedRectangle(cornerRadius: 15)
        .foregroundStyle(Color.white)
        .shadow(
          color: Color.black.opacity(0.2),
          radius: 5, x: 0.0, y: 0.0)
        .edgesIgnoringSafeArea(.bottom)
    )
  }
}

#Preview {
  AddImagePopup(imageData: .constant(nil), showPopup: .constant(true))
}
