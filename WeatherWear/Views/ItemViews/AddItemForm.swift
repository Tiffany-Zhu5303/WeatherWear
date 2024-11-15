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
  @Query var categories: [ItemCategory]
  
  @State private var selectedType: ItemCategory? = nil
  @State private var openImagePopup: Bool = false
  
  var defaultOptions = ["Shirt", "Pants", "Shoes"]
  
  var body: some View {
    ZStack {
      VStack {
        Text("New Item")
          .font(.title2)
          .fontWeight(.bold)
          .foregroundStyle(Color("Moonstone"))
          .padding(.bottom, 30)
        Group {
          HStack {
            Text("Category: ")
              .font(.title3)
              .foregroundStyle(Color("Moonstone"))
            Picker("Category: ", selection: $selectedType) {
              Text("Choose a category")
                .tag(nil as ItemCategory?)
                .foregroundColor(Color("Moonstone"))
              if(categories.isEmpty){
                ForEach(defaultOptions, id:\.self){ category in
                  Text(category)
                    .tag(ItemCategory(name: category) as ItemCategory?)
                }
              } else {
                ForEach(categories) { category in
                  Text(category.name)
                    .tag(Optional(category))
                    .foregroundStyle(Color("Moonstone"))
                }
              }
            }
            .pickerStyle(MenuPickerStyle())
          }
          ZStack {
            Rectangle()
              .stroke(
                style: StrokeStyle(lineWidth: 1, dash: [3, 3]))
              .frame(width: 300, height: 300)
              .foregroundStyle(Color("Moonstone"))
            Image(systemName: "plus.circle.fill")
              .foregroundStyle(Color("Moonstone"))
          }
          .contentShape(Rectangle())
          .onTapGesture {
            openImagePopup = true
          }
        }
        .padding(.top, 20)
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
      if(openImagePopup) {
        Color.gray.opacity(0.1)
          .edgesIgnoringSafeArea(.all)
          .blur(radius: 10)
          .onTapGesture {
            openImagePopup = false
          }
        VStack {
          Spacer()
          AddImagePopup()
            .transition(.move(edge: .bottom))
        }
        .zIndex(1) 
      }
    }
  }
}

struct AddItemForm_Previews: PreviewProvider {
  static var previews: some View {
    AddItemForm()
  }
}
