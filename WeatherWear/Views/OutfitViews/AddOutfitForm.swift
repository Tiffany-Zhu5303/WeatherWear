//
//  AddOutfitForm.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/17/24.
//

import SwiftUI
import SwiftData

struct OutfitFormInput: View {
  @Environment(\.modelContext) private var modelContext
  @State private var showAlert: Bool = false
  @Binding var outfit: Outfit
  @Binding var navigateOutfitView: Bool
  @Binding var showForm: Bool
  
  private func saveOutfit() {
      do {
          try modelContext.save()
          print("Outfit successfully saved!")
      } catch {
          print("Failed to save outfit: \(error)")
      }
  }
  
  private func addOutfit() {
    guard !outfit.name.isEmpty
    else {
        showAlert = true
        return
    }
    
    let outfitName = outfit.name.isEmpty ? "\(Date().formatted(date: .abbreviated, time: .shortened)) Outfit": outfit.name
    outfit.name = outfitName
    
    modelContext.insert(outfit)

    print("inserted\(outfit.id)")
    saveOutfit()
    
    DispatchQueue.main.async {
        showForm = false
        navigateOutfitView = true
    }
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
            addOutfit()
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
    .alert("Incomplete Form", isPresented: $showAlert) {
      Button("Ok", role: .cancel) {}
    } message: {
      Text("Please set a non empty name for your outfit")
    }
  }
}

struct AddOutfitForm: View {
  @Binding var outfit: Outfit
  @Binding var showForm: Bool
  @Binding var showOutfitForm: Bool
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
        OutfitFormInput(
          outfit: $outfit,
          navigateOutfitView: $navigateOutfitView,
          showForm: $showOutfitForm
        )
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
    outfit: .constant(Outfit(items: [Item()])),
    showForm: .constant(true),
    showOutfitForm: .constant(true),
    navigateOutfitView: .constant(false)
  )
}
