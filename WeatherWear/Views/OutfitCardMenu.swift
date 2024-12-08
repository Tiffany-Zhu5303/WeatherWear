//
//  OutfitCardMenu.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 12/6/24.
//

import SwiftUI

struct OutfitCardMenu: View {
  @Environment(\.modelContext) var modelContext
  @Binding var showDropdown: Bool
  @Binding var outfit: Outfit
  
  var body: some View {
    Button("Delete") {
      
      showDropdown = false
    }
  }
}

#Preview {
  OutfitCardMenu(
    showDropdown: .constant(true), outfit: .constant(Outfit())
  )
}
