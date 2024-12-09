//
//  AddItemForm.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/13/24.
//

import SwiftUI
import SwiftData

struct AddItemForm: View {
  @Environment(\.modelContext) private var modelContext
  @Query(sort: [SortDescriptor(\ItemCategory.name, order: .forward)]) @MainActor var categories: [ItemCategory]
  @State private var showAlert: Bool = false
  @State private var selectedSubType: ItemCategory? = nil
  @State private var selectedType: String? = nil
  @State private var imageData: Data? = nil
  @State private var openImagePopup: Bool = false
  @State private var addNewType: Bool = false
  @Binding var showForm: Bool
  
  let itemCategories = ["Tops", "Bottoms", "Shoes", "Accessories"]
//  var defaultOptions = ["Shirt", "Pants", "Shoes"]
  
  func addItem() {
    guard let selectedSubType = selectedSubType,
          let selectedType = selectedType,
          let selectedImage = imageData
    else {
      showAlert = true
      return
    }
    
    let newItem = Item(image: selectedImage, itemType: selectedType, category: selectedSubType)
    modelContext.insert(newItem)
    print("Inserted new item: \(newItem.id) with category: \(newItem.category.name)")
    
    do {
      try modelContext.save()
      showForm = false
      print("new item successfully added!")
    } catch {
      print("Failed to add new item: \(error)")
    }
  }
  
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
    ZStack {
      VStack {
        Text("New Item")
          .font(.title2)
          .fontWeight(.bold)
          .foregroundStyle(Color("Moonstone"))
          .padding(.bottom, 10)
        Group {
          HStack {
            Text("Category: ")
              .font(.title3)
              .foregroundStyle(Color("Moonstone"))
            Picker("Category: ", selection: $selectedType) {
              Text("Choose a category")
                .tag(nil as String?)
              ForEach(itemCategories, id:\.self) { type in
                Text(type)
                  .tag(Optional(type))
              }
            }
          }
          .frame(
            maxWidth: .infinity,
            alignment: .leading
          )
          .padding(.horizontal, 30)
          HStack {
            Text("Item Type: ")
              .font(.title3)
              .foregroundStyle(Color("Moonstone"))
            Picker("Sub-categories: ", selection: $selectedSubType) {
              Text("Choose a type")
                .tag(nil as ItemCategory?)
                .disabled(true)
//              if(categories.isEmpty){
//                // for testing in preview
//                ForEach(defaultOptions, id:\.self){ categoryName in
//                  Text(categoryName)
//                    .tag(ItemCategory(name: categoryName) as ItemCategory?)
//                }
//              } else {
                ForEach(categories) { category in
                  Text(category.name)
                    .tag(Optional(category))
                }
              }
            }
            .pickerStyle(MenuPickerStyle())
//          }
          .frame(
            maxWidth: .infinity,
            alignment: .leading
          )
          .padding(.horizontal, 30)
          HStack {
            Button(action: {
              addNewType = true
            }) {
              Image(systemName: "plus.circle.fill")
                .frame(
                  width: 5,
                  height: 5
                )
              Text("New Item Type")
                .font(.caption)
            }
            .padding(9)
            .overlay(
              RoundedRectangle(cornerRadius: 10)
                .stroke(Color("Moonstone"), lineWidth: 2)
            )
            .cornerRadius(10)
          }
          .foregroundStyle(Color("Moonstone"))
          .frame(
            maxWidth: .infinity,
            alignment: .leading
          )
          .padding(.horizontal, 30)
          .padding(.bottom, 10)
          ZStack {
            Rectangle()
              .stroke(
                style: StrokeStyle(lineWidth: 1, dash: [3, 3]))
              .frame(width: 300, height: 300)
              .foregroundStyle(Color("Moonstone"))
            if let imageData = imageData,
               let uiImage = UIImage.from(data: imageData) {
              Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
            }else {
              Image(systemName: "plus.circle.fill")
                .foregroundStyle(Color("Moonstone"))
            }
          }
          .contentShape(Rectangle())
          .onChange(of: imageData) { newValue, _ in
            if let newValue = newValue {
              print("Image data updated in AddItemForm, size: \(newValue.count) bytes")
            } else {
              print("Image data is nil in AddItemForm")
            }
          }
          .onTapGesture {
            openImagePopup = true
          }
        }
        Button(action: {
          addItem()
        }) {
          Text("Add Item")
            .padding(10)
        }
        .background(Color("Moonstone"))
        .foregroundStyle(Color("MintGreen"))
        .cornerRadius(10)
        .padding(.top, 20)
      }
      .padding()
      .background(
        RoundedRectangle(cornerRadius: 15)
          .foregroundStyle(Color.white)
          .shadow(
            color: Color.black.opacity(0.2),
            radius: 5, x: 0.0, y: 0.0)
      )
      if(openImagePopup) {
        Color.gray.opacity(0.1)
          .edgesIgnoringSafeArea(.all)
          .blur(radius: 10)
          .onTapGesture {
            openImagePopup = false
          }
        VStack {
          Spacer()
          AddImagePopup(imageData: $imageData, showPopup: $openImagePopup)
            .transition(.move(edge: .bottom))
        }
        .zIndex(1)
      }
      if(addNewType) {
        Color.gray.opacity(0.1)
          .blur(radius: 10)
          .onTapGesture {
            addNewType = false
          }
        VStack {
          Spacer()
          AddNewItemCategoryView(showForm: $addNewType)
            .transition(.move(edge: .bottom))
          Spacer()
        }
        .zIndex(1)
      }
    }
    .alert("Incomplete Form", isPresented: $showAlert) {
      Button("Ok", role: .cancel) {}
    } message: {
      Text("Please select a category and image before adding the item.")
    }
    .frame(
      width: 350,
      height: 600)
  }
}

struct AddItemForm_Previews: PreviewProvider {
  static var previews: some View {
    AddItemForm(showForm: .constant(true))
  }
}
