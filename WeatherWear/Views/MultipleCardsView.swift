//
//  MultipleCardsView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 10/31/24.
//

import SwiftUI
import SwiftData

struct MultipleCardsView: View {
  @Environment(\.modelContext) var modelContext
  @AppStorage("categoryState") private var categoryStateRawValue: Int = CategoryState.outfits.rawValue
  @State private var openAddNewItemForm: Bool = false
  @State private var openAddNewOutfitForm: Bool = false
  @State private var openItemFullscreen: Bool = false
  @State private var newOutfit: Outfit = Outfit()
  @State private var selectedOutfitCard: Outfit? = nil
  @State private var selectedItem: Item? = nil
  @State private var selectedOutfit: Outfit? = nil
  @State private var selectedFavorite: Favorite? = nil
  @State private var navigateOutfitView: Bool = false
  @State private var navigateWeatherDetailsView: Bool = false
  @Query var items: [Item]
  @Query var outfits: [Outfit]
  @Query var favorites: [Favorite]
  
  var columns: [GridItem] {
    [
      GridItem(.adaptive(
        minimum: Settings.thumbnailSize.width))
    ]
  }
  
  var categoryState: CategoryState {
    get {
      return CategoryState(rawValue: categoryStateRawValue) ?? .outfits
    }
    set {
      categoryStateRawValue = newValue.rawValue
    }
  }
  
  var categoryStateBinding: Binding<CategoryState> {
    Binding(
      get: { self.categoryState },
      set: { newValue in
        self.categoryStateRawValue = newValue.rawValue
      }
    )
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
  
  var addOutfitCard: some View {
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
      openAddNewOutfitForm = true
    }
  }
  
  var displayItems: some View {
    ForEach(items) { item in
      VStack(alignment: .leading) {
        CardThumbnailView()
          .frame(
            width: Settings.thumbnailSize.width,
            height: Settings.thumbnailSize.height
          )
          .overlay(
            Group {
              if let uiImage = UIImage(data: item.image) {
                Image(uiImage: uiImage)
                  .resizable()
                  .scaledToFit()
                  .frame(
                    width: Settings.thumbnailSize.width * 0.8,
                    height: Settings.thumbnailSize.height * 0.8)
                  .clipped()
              } else {
                Text("No Image")
                  .foregroundColor(.gray)
              }
            }
          )
          .onTapGesture {
            DispatchQueue.main.async {
              selectedItem = item
            }
          }
      }
    }
  }
  
  var displayOutfits: some View {
    ForEach(outfits) { outfit in
      VStack(alignment: .leading) {
        CardThumbnailView()
          .frame(
            width: Settings.thumbnailSize.width,
            height: Settings.thumbnailSize.height
          )
          .overlay(
            Group {
              if let uiImage = UIImage(data: outfit.thumbnail) {
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
            selectedOutfit = outfit
            navigateOutfitView = true
          }
          .contextMenu{
            Button(role: .destructive, action: {
              outfit.deleteOutfit(modelContext: modelContext)
            }) {
                Text("Delete")
                Image(systemName: "trash")
            }
          }
      }
    }
  }
  
  var displayFavorites: some View {
    ForEach(favorites) { favorite in
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
            selectedFavorite = favorite
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
            addOutfitCard
          case .items:
            displayItems
            addItemCard
          case .favorites:
            displayFavorites
            addItemCard
          }
        }
      }
      .padding(.top)
      .onChange(of: categoryState) {
        print("Current Category: \(categoryState)")
        print("Items: \(items.count), Outfits: \(outfits.count), Favorites: \(favorites.count)")
      }
    }
  }
  
  var body: some View {
    NavigationStack {
      ZStack {
        VStack{
          WeatherTopBarView(navigateToWeatherDetails: $navigateWeatherDetailsView)
          CategorySelector(categoryState: categoryStateBinding)
            .padding(.vertical)
          Spacer()
          Group {
            itemList
          }
        }
        .fullScreenCover(isPresented: Binding(
          get: { selectedItem != nil },
          set: { if !$0 { selectedItem = nil } }
        )) {
          if selectedItem != nil {
            ItemView(item: $selectedItem)
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
        if(openAddNewOutfitForm) {
          Color.gray.opacity(0.1)
            .edgesIgnoringSafeArea(.all)
            .blur(radius: 10)
            .onTapGesture {
              openAddNewOutfitForm = false
            }
          AddOutfitForm(
            outfit: Binding(get: {newOutfit}, set: {self.selectedOutfit = $0}),
            showForm: $openAddNewOutfitForm,
            showOutfitForm: $openAddNewOutfitForm,
            navigateOutfitView: $navigateOutfitView
          )
          .onDisappear {
            selectedOutfit = newOutfit
          }
        }
      }
      .navigationDestination(isPresented: $navigateOutfitView) {
        if let selectedOutfit = selectedOutfit {
          OutfitView(
            outfit: Binding(get: { selectedOutfit }, set: { _ in self.selectedOutfit = nil }))
          .onDisappear{
            navigateOutfitView = false
          }
        } else {
          Text("No outfit selected")
        }
      }
      .navigationDestination(isPresented: $navigateWeatherDetailsView) {
        WeatherDetailView()
          .onDisappear{
            navigateWeatherDetailsView = false
          }
      }
    }
  }
}

#Preview {
  MultipleCardsView()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.white)
}
