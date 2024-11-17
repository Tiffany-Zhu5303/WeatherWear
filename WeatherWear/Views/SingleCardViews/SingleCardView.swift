//
//  SingleCardView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/5/24.
//

import SwiftUI

struct SingleCardView: View {
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var store: CardStore
  @Binding var card: Card
  
  var body: some View {
    NavigationStack {
      CardDetailView(card: $card)
      .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") { dismiss() }
          }
        }
    }
  }
}

struct SingleCardView_Previews: PreviewProvider {
  struct SingleCardViewPreview: View {
    @EnvironmentObject var store: CardStore
    
    var body: some View {
      SingleCardView(card: $store.itemsCards[0])
    }
  }
  static var previews: some View {
    SingleCardViewPreview()
      .environmentObject(CardStore(defaultData: true))
  }
}
