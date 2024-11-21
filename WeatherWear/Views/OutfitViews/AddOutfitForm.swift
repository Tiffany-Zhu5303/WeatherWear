//
//  AddOutfitForm.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/17/24.
//

import SwiftUI
import SwiftData

struct OutfitFormInput: View {
  @Binding var navigateOutfitView: Bool
  @Binding var showForm: Bool
  @Binding var outfit: Outfit
  
  func updateOutfit() {
    
  }
  
  var body: some View {
    VStack {
      HStack {
        TextField("", text: $outfit.name, prompt: Text("Outfit Name"))
          .font(.caption)
          .padding(.leading, 10)
          .padding(.horizontal)
          .frame(width: 275, height: 50)
          .background(
            RoundedRectangle(cornerRadius: 10)
              .fill(Color.clear)
              .frame(width: 300)
          )
        Image(systemName: "pencil")
          .padding(.trailing, 10)
      }
      .background(
        RoundedRectangle(cornerRadius: 10)
          .fill(Color("MintGreen").opacity(0.5))
      )
      .padding(.vertical, 20)
      NavigationStack {
        VStack {
          Button("Create Outfit"){
            showForm = false
            
            DispatchQueue.main.async {
              navigateOutfitView = true
            }
          }
          .padding(5)
          .background(
            RoundedRectangle(cornerRadius: 10)
              .stroke(Color("Moonstone"), lineWidth: 2)
          )
          .navigationDestination(isPresented: $navigateOutfitView) {
            OutfitView(outfit: $outfit)
          }
        }
      }
    }
  }
}

struct AddOutfitForm: View {
  @Environment(\.modelContext) private var modelContext
  @Binding var showForm: Bool
  @Binding var showOutfitForm: Bool
  @Binding var outfit: Outfit
  @Binding var navigateOutfitView: Bool
  
  var body: some View {
    ZStack(alignment: .top) {
      RoundedRectangle(cornerRadius: 15)
        .foregroundStyle(Color.white)
        .shadow(
          color: Color.black.opacity(0.2),
          radius: 5, x: 0.0, y: 0.0)
        .frame(
          width: 350,
          height: 220)
      VStack(alignment: .center) {
        OutfitFormInput(navigateOutfitView: $navigateOutfitView, showForm: $showOutfitForm, outfit: $outfit)
          .font(.title2)
          .fontWeight(.bold)
          .foregroundStyle(Color("Moonstone"))
          .padding(.top, 30)
      }
    }
    .frame(
      width: 350,
      height: 350,
      alignment: .top
    )
  }
}

#Preview {
  AddOutfitForm(
    showForm: .constant(true),
    showOutfitForm: .constant(true),
    outfit: .constant(
      Outfit(name: "\(Date().formatted(date: .abbreviated, time: .shortened)) Outfit")
    ),
    navigateOutfitView: .constant(false)
  )
}
