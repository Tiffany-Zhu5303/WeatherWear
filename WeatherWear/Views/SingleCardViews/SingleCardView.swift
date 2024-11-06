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
  
  var content: some View {
    ZStack {
      Group {
        Capsule()
          .foregroundStyle(Color("MintGreen"))
        Text("Resize Me!")
          .fontWeight(.bold)
          .font(.system(size: 500))
          .minimumScaleFactor(0.01)
          .lineLimit(1)
      }
      .resizableView()
    }
  }
  
  var body: some View {
    NavigationStack {
      card.backgroundColor
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") { dismiss() }
          }
        }
    }
  }
}

#Preview {
  SingleCardView(card: .constant(initialCards[0]))
}
