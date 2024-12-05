//
//  WeatherTopBarView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/25/24.
//

import SwiftUI

struct WeatherTopBarView: View {
  var formattedCurrentDate: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE, MMM d"
    return dateFormatter.string(from: Date())
  }
  
  var body: some View {
    HStack {
      VStack {
        Text("\(formattedCurrentDate)")
          .font(.title3)
        Text("New York")
        WeatherView()
      }
      .fontWeight(.bold)
      Spacer()
      Image(systemName: "sun.max.circle.fill")
        .resizable()
        .scaledToFit()
        .frame(
          width: 60,
          height: 60)
    }
    .foregroundStyle(Color("Moonstone"))
    .padding(
      .horizontal, 30
    )
  }
}

#Preview {
    WeatherTopBarView()
}
