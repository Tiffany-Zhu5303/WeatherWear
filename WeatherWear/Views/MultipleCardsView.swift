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
  @Environment(\.modelContext) var modelContext
  @Query var items: [Item]
  
  var columns: [GridItem] {
    [
      GridItem(.adaptive(
        minimum: Settings.thumbnailSize.width))
    ]
  }
  
  var itemList: some View {
    ScrollView(showsIndicators: false) {
      LazyVGrid(columns: columns, spacing: 20) {
        ForEach(items) { item in
          VStack(alignment: .leading) {
            CardThumbnailView()
              .frame(
                width: Settings.thumbnailSize.width,
                height: Settings.thumbnailSize.height
              )
          }
        }
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
      if(openAddNewItemForm) {
        Color.gray.opacity(0.1)
          .edgesIgnoringSafeArea(.all)
          .blur(radius: 10)
          .onTapGesture {
            openAddNewItemForm = false
          }
        AddItemForm()
      }
    }
  }
}

#Preview {
  MultipleCardsView()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.white)
}
