//
//  PhotoPicker.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/14/24.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: View {
  @State private var selectedImages: [PhotosPickerItem] = []
    var body: some View {
      PhotosPicker(
        selection: $selectedImages,
        matching: .images) {
          
        }
    }
}

#Preview {
    PhotoPicker()
}
