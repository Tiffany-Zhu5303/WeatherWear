//
//  ItemToolbar.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/18/24.
//

import SwiftUI

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

struct ItemToolbar: View {
  @State var sectionName: String = "Tops"
  @State var isExpanded: Bool = false
  @Binding var modal: ItemSelection?
  
  var body: some View {
    VStack {
      ZStack(alignment: .topLeading) {
        RoundedRectangle(cornerRadius: 15)
          .fill(Color("MintGreen"))
          .frame(
            width: .infinity,
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
          }
        }
        .padding(.top, 45)
        .padding(.horizontal)
      }
      .ignoresSafeArea()
      .foregroundStyle(Color("Moonstone"))
    }
    .background(Color("MintGreen").ignoresSafeArea(edges: .bottom))
  }
}

#Preview {
  ItemToolbar(modal: .constant(.tops))
    .padding()
}
