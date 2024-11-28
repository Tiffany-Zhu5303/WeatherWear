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
  @ObservedObject var outfitViewModel: OutfitViewModel
  @Binding var newOutfitId: UUID?
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
    guard !outfitViewModel.outfit.name.isEmpty
    else {
        showAlert = true
        return
    }
    
    let outfitName = outfitViewModel.outfit.name.isEmpty ? "\(Date().formatted(date: .abbreviated, time: .shortened)) Outfit": outfitViewModel.outfit.name
    let newOutfit = Outfit(name: outfitName)
    
    modelContext.insert(newOutfit)
    
    outfitViewModel.outfit = newOutfit
    newOutfitId = newOutfit.id
    
    print("inserted \(newOutfit.id) == \(outfitViewModel.outfit.id)")
    saveOutfit()
    
    DispatchQueue.main.async {
        self.outfitViewModel.objectWillChange.send() // Notify SwiftUI to refresh
    }
  }
  
  var body: some View {
    VStack {
      HStack {
        TextField("", text: $outfitViewModel.outfit.name, prompt: Text("Outfit Name"))
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
            addOutfit()
            
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
            OutfitView(outfitView: outfitViewModel)
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
  @ObservedObject var outfitViewModel: OutfitViewModel
  @Binding var showForm: Bool
  @Binding var showOutfitForm: Bool
  @Binding var newOutfitId: UUID?
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
          outfitViewModel: outfitViewModel,
          newOutfitId: $newOutfitId,
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
    outfitViewModel: OutfitViewModel(outfit: Outfit()),
    showForm: .constant(true),
    showOutfitForm: .constant(true),
    newOutfitId: .constant(nil),
    navigateOutfitView: .constant(false)
  )
}
