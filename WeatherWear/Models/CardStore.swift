//
//  CardStore.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/1/24.
//

import Foundation
import SwiftUI

class CardStore: ObservableObject {
  @Published var outfitCards: [Card] = []
  @Published var itemsCards: [Card] = []
  @Published var favoriteCards: [Card] = []
  @Published var selectedCard: Card?
  
  init(defaultData: Bool = false) {
    if defaultData {
      outfitCards = initialOutfitCards
      itemsCards = initialItemCards
      favoriteCards = initialFavoriteCards
    }
  }
  
  func addCard(type: CategoryState) -> Card {
    let card = Card()
    
    if type == CategoryState.outfits {
      outfitCards.append(card)
    } else if type == CategoryState.items {
      itemsCards.append(card)
    } else if type == CategoryState.favorites {
      favoriteCards.append(card)
    }
    
    return card
  }
  
  func index(for card: Card, type: CategoryState) -> Int? {
    var index: Int?
    
    if type == CategoryState.outfits {
      index = outfitCards.firstIndex { $0.id == card.id }
    } else if type == CategoryState.items {
      index = itemsCards.firstIndex { $0.id == card.id }
    } else if type == CategoryState.favorites {
      index = favoriteCards.firstIndex {$0.id == card.id}
    }
    
    return index
  }
}
