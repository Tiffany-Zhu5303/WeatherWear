//
//  WeatherTopBarView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/25/24.
//

import SwiftUI

struct WeatherTopBarView: View {
  @Binding var navigateToWeatherDetails: Bool
  
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
        CurrentWeatherView()
      }
      .fontWeight(.bold)
      Spacer()
      Image(systemName: "sun.max.circle.fill")
        .resizable()
        .scaledToFit()
        .frame(
          width: 60,
          height: 60)
        .onTapGesture {
          navigateToWeatherDetails = true
        }
    }
    .foregroundStyle(Color("Moonstone"))
    .padding(
      .horizontal, 30
    )
  }
}

#Preview {
  WeatherTopBarView(navigateToWeatherDetails: .constant(false))
}
