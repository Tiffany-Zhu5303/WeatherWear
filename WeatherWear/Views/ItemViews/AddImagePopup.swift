//
//  AddImagePopup.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/14/24.
//

import SwiftUI
import PhotosUI

struct AddImagePopup: View {
  @State private var selectedImages: [PhotosPickerItem] = []
  
  var body: some View {
    VStack {
      Text("Add Item(s)")
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
            selection: $selectedImages,
            matching: .images,
            photoLibrary: .shared()) {
              Text("Add from Camera Roll")
            }
        //        .onChange(of: selectedImages) { _, _ in
        //
        //        }
          Spacer()
          Image(systemName: "photo.on.rectangle")
        }
        HStack {
          Button("Paste") {
          }
          Spacer()
          Image(systemName: "document.on.clipboard")
        }
      }
      .frame(width: 350)
      .padding([.vertical, .horizontal])
      .foregroundStyle(Color("Moonstone"))
      .background(Color("AntiFlashWhite"))
    }
    .frame(maxWidth: .infinity)
    .edgesIgnoringSafeArea(.bottom)
    .padding(.bottom, 20)
  }
}

#Preview {
  AddImagePopup()
}
