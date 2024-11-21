//
//  AddOutfitForm.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/17/24.
//

import SwiftUI
import SwiftData

struct OutfitFormInput: View {
  @State private var switchView: Bool = false
  @Binding var outfit: Outfit
//  @Binding var itemCategories: [ItemCategory:[Item]]
  
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
      NavigationView {
        VStack {
          NavigationLink(destination: OutfitView(outfit: $outfit)) {
            Button("Create Outfit"){}
              .padding(5)
              .background(
                RoundedRectangle(cornerRadius: 10)
                  .stroke(Color("Moonstone"), lineWidth: 2)
              )
          }
        }
        .navigationBarHidden(true)
      }
//      Form {
//        ForEach(Array(itemCategories.keys), id: \.self){ category in
//          Section(header: Text(category.name)) {
//            Menu {
//              ForEach(itemCategories[category] ?? [], id: \.id) { item in
//                Button(action: {
//                  print("Selected item: \(item.id)")
//                }) {
//                  Text("\(item.id)")
//                }
//              }
//            } label: {
//              Text("Choose an item")
//              Image(systemName: "heart")
//            }
//          }
//        }
//      }
//      .padding(.top, 30)
//      .foregroundStyle(Color("Moonstone"))
    }
  }
}

struct AddOutfitForm: View {
  @Environment(\.modelContext) private var modelContext
//  @State var itemCategories: [ItemCategory: [Item]] =
//  [
//    ItemCategory(name: "shirt") : [Item(image: UIImage(named: "tshirt1")!.pngData()!), Item()],
//    ItemCategory(name: "pants") : [Item(image: UIImage(named: "tshirt1")!.pngData()!)],
//    ItemCategory(name: "shoes") : [Item(image: UIImage(named: "tshirt1")!.pngData()!)]
//  ]
  @Binding var showForm: Bool
  @Binding var outfit: Outfit
  
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
        OutfitFormInput(outfit: $outfit)
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
    outfit: .constant(
      Outfit(name: "\(Date().formatted(date: .abbreviated, time: .shortened)) Outfit")
    )
  )
}
