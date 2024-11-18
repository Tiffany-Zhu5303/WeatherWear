//
//  MultipleCardsView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 10/31/24.
//

import SwiftUI
import SwiftData

struct MultipleCardsView: View {
  @State private var categoryState = CategoryState.outfits
  @State private var openAddNewItemForm: Bool = false
  @State private var openItemFullscreen: Bool = false
  @State private var selectedItem: Item? = nil
  @Environment(\.modelContext) var modelContext
  @Query var items: [Item]
  @Query var outfits: [Outfit]
  @Query var favorites: [Favorite]

  enum ModelType {
    case outfits
    case items
    case favorites
  }
  
  var columns: [GridItem] {
    [
      GridItem(.adaptive(
        minimum: Settings.thumbnailSize.width))
    ]
  }
  
  var addItemCard: some View {
    ZStack {
      CardThumbnailView()
        .frame(
          width: Settings.thumbnailSize.width,
          height: Settings.thumbnailSize.height
        )
      Image(systemName: "plus.circle.fill")
        .foregroundStyle(Color("Moonstone"))
    }
    .onTapGesture {
      openAddNewItemForm = true
    }
  }
  
  var displayItems: some View {
    ForEach(items.indices, id: \.self) { index in
      VStack(alignment: .leading) {
        CardThumbnailView()
          .frame(
            width: Settings.thumbnailSize.width,
            height: Settings.thumbnailSize.height
          )
          .overlay(
            Group {
              if let uiImage = UIImage(data: items[index].image) {
                Image(uiImage: uiImage)
                  .resizable()
                  .scaledToFill()
                  .frame(
                    width: Settings.thumbnailImageSize.width,
                    height: Settings.thumbnailImageSize.height)
              } else {
                Text("No Image")
                  .foregroundColor(.gray)
              }
            }
          )
          .onTapGesture {
            selectedItem = items[index]
          }
      }
    }
  }
  
  var displayOutfits: some View {
    ForEach(outfits.indices, id: \.self) { index in
      VStack(alignment: .leading) {
        CardThumbnailView()
          .frame(
            width: Settings.thumbnailSize.width,
            height: Settings.thumbnailSize.height
          )
          .overlay(
            Group {
//              if let uiImage = UIImage(data: outfits[index].image) {
//                Image(uiImage: uiImage)
//                  .resizable()
//                  .scaledToFill()
//                  .frame(
//                    width: Settings.thumbnailImageSize.width,
//                    height: Settings.thumbnailImageSize.height)
//              } else {
                Text("No Image")
                  .foregroundColor(.gray)
//              }
            }
          )
          .onTapGesture {
            selectedItem = items[index]
          }
      }
    }
  }
  
  var displayFavorites: some View {
    ForEach(favorites.indices, id: \.self) { index in
      VStack(alignment: .leading) {
        CardThumbnailView()
          .frame(
            width: Settings.thumbnailSize.width,
            height: Settings.thumbnailSize.height
          )
          .overlay(
            Group {
//              if let uiImage = UIImage(data: favorites[index].image) {
//                Image(uiImage: uiImage)
//                  .resizable()
//                  .scaledToFill()
//                  .frame(
//                    width: Settings.thumbnailImageSize.width,
//                    height: Settings.thumbnailImageSize.height)
//              } else {
                Text("No Image")
                  .foregroundColor(.gray)
//              }
            }
          )
          .onTapGesture {
            selectedItem = items[index]
          }
      }
    }
  }
  
  var itemList: some View {
    ScrollView(showsIndicators: false) {
      LazyVGrid(columns: columns, spacing: 20) {
        Group {
          switch categoryState {
          case .outfits:
            displayOutfits
          case .items:
            displayItems
          case .favorites:
            displayFavorites
          }
        }
        addItemCard
      }
      .padding(.top)
    }
  }
  
  var body: some View {
    ZStack {
      VStack{
        CategorySelector(categoryState: $categoryState)
          .padding(.top)
        Spacer()
        Group {
          itemList
        }
      }
      .onChange(of: selectedItem) { item, _ in
        if item != nil {
          openItemFullscreen = true
        }
      }
      .fullScreenCover(isPresented: $openItemFullscreen) {
        if selectedItem != nil {
          ItemView(item: $selectedItem)
            .zIndex(1)
        }
      }
      if(openAddNewItemForm) {
        Color.gray.opacity(0.1)
          .edgesIgnoringSafeArea(.all)
          .blur(radius: 10)
          .onTapGesture {
            openAddNewItemForm = false
          }
        AddItemForm(showForm: $openAddNewItemForm)
      }
    }
  }
}

#Preview {
  MultipleCardsView()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.white)
}
