//
//  AddOutfitForm.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/17/24.
//

import SwiftUI
import SwiftData

struct AddOutfitForm: View {
  @Environment(\.modelContext) private var modelContext
  @Binding var showForm: Bool
  
  var body: some View {
    ZStack {
      VStack {
        Text("New Outfit")
          .font(.title2)
          .fontWeight(.bold)
          .foregroundStyle(Color("Moonstone"))
          .padding(.bottom, 30)
      }
    }
    .background(
      RoundedRectangle(cornerRadius: 15)
        .foregroundStyle(Color.white)
        .shadow(
          color: Color.black.opacity(0.2),
          radius: 5, x: 0.0, y: 0.0)
        .frame(
          width: 350,
          height: 550)
    )
  }
}

#Preview {
  AddOutfitForm(showForm: .constant(true))
}
