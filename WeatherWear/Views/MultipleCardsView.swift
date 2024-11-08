//
//  MultipleCardsView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 10/31/24.
//

import SwiftUI

struct MultipleCardsView: View {
  @State private var categoryState = CategoryState.outfits
  @State private var isPresented: Bool = false
  @State private var selectedCard: Card?
  @EnvironmentObject var store: CardStore
  
  var columns: [GridItem] {
    [
      GridItem(.adaptive(
        minimum: Settings.thumbnailSize.width))
    ]
  }
  
  private var selectedCategoryCards: [Card] {
    switch categoryState {
    case .outfits:
      return store.outfitCards
    case .items:
      return store.itemsCards
    case .favorites:
      return store.favoriteCards
    }
  }
  
  var cardList: some View {
    ScrollView(showsIndicators: false){
      LazyVGrid(columns: columns, spacing: 20) {
          ForEach(selectedCategoryCards) {card in
            CardThumbnailView(card: card)
              .frame(
                width: Settings.thumbnailSize.width,
                height: Settings.thumbnailSize.height
              )
              .onTapGesture {
                selectedCard = card
              }
          }
      }
      .padding(.top, 20)
    }
    .padding(.top, 20)
  }
  
  var body: some View {
    VStack{
      CategorySelector(categoryState: $categoryState)
        .padding(.top)
      Spacer()
      Group {
        cardList
      }
      .fullScreenCover(item: $selectedCard) { card in
        if let index = store.index(for: card, type: categoryState) {
          
          if(categoryState == .outfits){
            SingleCardView(card: $store.outfitCards[index])
          } else if (categoryState == .items) {
            SingleCardView(card: $store.itemsCards[index])
          } else if (categoryState == .favorites) {
            SingleCardView(card: $store.favoriteCards[index])
          }
          
        } else {
          fatalError("Unable to locate selected item")
        }
      }
    }
  }
}

#Preview {
  MultipleCardsView()
    .environmentObject(CardStore(defaultData: true))
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.white)
}
