//
//  AddNewItemCategoryView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 12/8/24.
//

import SwiftUI
import SwiftData

struct ExistingItemCategories: View {
  @Environment(\.modelContext) private var modelContext
  @Query(sort: [SortDescriptor(\ItemCategory.name, order: .forward)]) @MainActor var categories: [ItemCategory]
  @State private var categoryToDelete: ItemCategory?
  
  var defaultOptions = ["Shirt", "Pants", "Shoes", "Skirt", "jacket"]
  
  func deleteItemCategory(itemCategory: ItemCategory) {
    do {
      modelContext.delete(itemCategory)
      try modelContext.save()
      print("ItemCategory deleted!")
    } catch {
      print("Error deleting itemCategory: \(error)")
    }
  }
  
  var body: some View {
    VStack {
      Text("Item Categories")
      if categories.isEmpty {
        List(defaultOptions, id:\.self) { category in
          Text(category)
            .font(.caption)
        }
      } else {
        List {
          ForEach(categories, id:\.id) { category in
            Text(category.name)
              .font(.caption)
          }
          // Need handling of items with item categories
          
          //          .onDelete { offsets in
          //            for index in offsets {
          //              categoryToDelete = categories[index]
          //              deleteItemCategory(itemCategory: categoryToDelete!)
          //            }
          //          }
        }
      }
    }
    .frame(
      width: 350,
      height: 250)
  }
}

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
      Text("Add Category")
      HStack {
        TextField("", text: $category.name, prompt: Text("New Category"))
          .font(.caption)
          .padding(.leading, 10)
          .padding(.vertical)
          .frame(width: 275)
          .foregroundStyle(Color("Moonstone"))
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
          .stroke(Color("Moonstone"), lineWidth: 2)
      )
      .padding(.vertical, 10)
      
      Button("Create Category"){
        addOutfit()
      }
      .font(.subheadline)
      .padding(5)
      .background(
        RoundedRectangle(cornerRadius: 10)
          .stroke(Color("Moonstone"), lineWidth: 2)
      )
    }
    .frame(
      height: 200)
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
          width: 350)
      VStack(alignment: .center) {
        Group {
          ExistingItemCategories()
          ItemCategoryFormInput(
            category: $itemCategory,
            showForm: $showForm
          )
        }
        .padding(.top, 20)
        .font(.title2)
        .fontWeight(.bold)
        .foregroundStyle(Color("Moonstone"))
      }
    }
    .frame(
      width: 350,
      height: 450,
      alignment: .top
    )
  }
}

#Preview {
  AddNewItemCategoryView(
    showForm: .constant(true)
  )
}
