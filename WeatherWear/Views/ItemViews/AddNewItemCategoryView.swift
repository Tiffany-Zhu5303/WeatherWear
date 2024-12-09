//
//  AddNewItemCategoryView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 12/8/24.
//

import SwiftUI

struct ItemCategoryFormInput: View {
  @Environment(\.modelContext) private var modelContext
  @State private var showAlert: Bool = false
  @Binding var category: ItemCategory
  @Binding var showForm: Bool
  
  private func addOutfit() {
    guard !category.name.isEmpty
    else {
      showAlert = true
      return
    }
    
    modelContext.insert(category)
    print("inserted \(category.name)")
    showForm = false
  }
  
  var body: some View {
    VStack {
      HStack {
        TextField("", text: $category.name, prompt: Text("New Category"))
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
      VStack {
        Button("Create Category"){
          addOutfit()
        }
        .padding(5)
        .background(
          RoundedRectangle(cornerRadius: 10)
            .stroke(Color("Moonstone"), lineWidth: 2)
        )
      }
    }
    .alert("Incomplete Form", isPresented: $showAlert) {
      Button("Ok", role: .cancel) {}
    } message: {
      Text("Please set a non empty name for your category")
    }
  }
}

struct AddNewItemCategoryView: View {
  @State var itemCategory: ItemCategory = ItemCategory()
  @Binding var showForm: Bool
  
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
        ItemCategoryFormInput(
          category: $itemCategory,
          showForm: $showForm
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
  AddNewItemCategoryView(
    showForm: .constant(true)
  )
}
