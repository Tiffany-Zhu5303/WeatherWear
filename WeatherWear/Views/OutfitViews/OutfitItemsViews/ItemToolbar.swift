//
//  ItemToolbar.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/18/24.
//

import SwiftUI
import SwiftData

struct ToolbarButton: View {
  let modal: ItemSelection
  
  private let modalButton: [
    ItemSelection: (String) ] = [
      .tops: "Tops",
      .bottoms: "Bottoms",
      .shoes: "Shoes",
      .accessories: "Accessories",
    ]
  
  var body: some View {
    VStack {
      if let text = modalButton[modal] {
        VStack {
          Text(text)
            .font(.system(size: 16))
        }
        .padding(10)
      }
    }
    .frame(alignment: .top)
  }
}

struct ToolbarItems: View {
  @Query var items: [Item]
  @Environment(\.modelContext) var modelContext
  @Binding var outfit: Outfit
  @Binding var currentItems: ItemSelection
  @Binding var selectedItems: [ItemCategory:Item]
  
  var columns: [GridItem] {
    [
      GridItem(.adaptive(
        minimum: Settings.thumbnailSize.width*0.5))
    ]
  }
  
  var sectionItems: [Item] {
    switch currentItems {
    case .tops:
      return items.filter{$0.itemType == "Tops"}
    case .bottoms:
      return items.filter{$0.itemType == "Bottoms"}
    case .shoes:
      return items.filter{$0.itemType == "Shoes"}
    case .accessories:
      return items.filter{$0.itemType == "Accessories"}
    }
  }
  
  private func saveOutfit() {
    do {
      try modelContext.save()
      print("Items saved in this outfit from items toolbar")
      for item in outfit.items {
        print("\(item.itemType)")
      }
      print("Outfit successfully saved!")
    } catch {
      print("Failed to save outfit: \(error)")
    }
  }
  
  private func addItemToOutfit(_ item: Item) {
    selectedItems[item.category] = item
    outfit.addItemToOutfit(item)
    print("Saving from add Item to outfit...")
    saveOutfit()
  }
  
  private func removeItemFromOutfit(_ item: Item) {
    selectedItems[item.category] = nil
    outfit.removeItemFromOutfit(item)
    print("Saving from removeItemFromOutfit...")
    saveOutfit()
  }
  
  private func handleItemSelection(_ item: Item) {
    if selectedItems[item.category] == item {
      removeItemFromOutfit(item)
    } else {
      if let oldItem = selectedItems[item.category]{
        removeItemFromOutfit(oldItem)
      }
      addItemToOutfit(item)
    }
  }
  
  var body: some View {
    if(!sectionItems.isEmpty) {
      ScrollView(showsIndicators: false) {
        LazyVGrid(columns: columns, spacing: 20) {
          Group {
            ForEach(sectionItems.indices, id: \.self) { index in
              if let uiImage = UIImage(data: sectionItems[index].image) {
                let item = sectionItems[index]
                Image(uiImage: uiImage)
                  .resizable()
                  .scaledToFit()
                  .clipped()
                  .frame(
                    width: 70,
                    height: 70
                  )
                  .padding(5)
                  .overlay(
                    RoundedRectangle(cornerRadius: 10)
                      .stroke(Color("Moonstone"), lineWidth: 1)
                      .opacity(selectedItems[item.category] == item ? 1 : 0)
                  )
                  .onTapGesture {
                    handleItemSelection(item)
                  }
              }
            }
          }
        }
      }
      .frame(
        height: 400
      )
      .padding(.horizontal)
    }else {
      Text("No items.")
        .fontWeight(.bold)
        .frame(
          width: 400,
          alignment: .center
        )
        .padding(.vertical)
    }
  }
}

struct ItemToolbar: View {
  @State var isExpanded: Bool = false
  @Binding var outfit: Outfit
  @Binding var modal: ItemSelection
  @Binding var selectedItems: [ItemCategory:Item]
  
  var body: some View {
    VStack {
      ZStack(alignment: .topLeading) {
        RoundedRectangle(cornerRadius: 15)
          .fill(Color("MintGreen"))
          .frame(
            height: isExpanded ? 500 : 150
          )
          .animation(.easeInOut, value: isExpanded)
        Image(systemName: isExpanded ? "chevron.down.2" : "chevron.up.2")
          .resizable()
          .frame(width: 15, height: 15)
          .padding()
          .onTapGesture {
            withAnimation(.easeInOut) {
              isExpanded.toggle()
            }
          }
        HStack {
          ForEach(ItemSelection.allCases, id: \.self) { selection in
            Button {
              modal = selection
            } label: {
              ToolbarButton(modal: selection)
            }
            .background(
              RoundedRectangle(cornerRadius: 10)
                .fill(modal == selection ? Color.white : Color.clear)
            )
            .foregroundStyle(Color("Moonstone"))
            .overlay(
              RoundedRectangle(cornerRadius: 10)
                .stroke(Color("Moonstone"), lineWidth: 1)
            )
          }
        }
        .padding(.top, 45)
        .padding(.horizontal)
        if isExpanded {
          ToolbarItems(
            outfit: $outfit,
            currentItems: $modal,
            selectedItems: $selectedItems)
          .padding(.top, 100)
          .padding(.horizontal, 10)
        }
      }
      .ignoresSafeArea()
      .foregroundStyle(Color("Moonstone"))
    }
    .background(Color("MintGreen").ignoresSafeArea(edges: .bottom))
  }
}

#Preview {
  ItemToolbar(
    outfit: .constant(Outfit(items: [Item()])),
    modal: .constant(.tops),
    selectedItems: .constant([:])
  )
  .padding()
}
