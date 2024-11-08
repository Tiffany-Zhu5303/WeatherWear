//
//  AppLoadingView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/7/24.
//

import SwiftUI

struct AppLoadingView: View {
  @State private var showLaunchScreen: Bool = true
  
  var body: some View {
    if(showLaunchScreen) {
      LaunchScreenView()
        .ignoresSafeArea()
        .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.linear(duration: 1.5)) {
              showLaunchScreen = false
            }
          }
        }
    } else {
      MultipleCardsView()
        .environmentObject(CardStore(defaultData: true))
    }
  }
}

#Preview {
  AppLoadingView()
    .environmentObject(CardStore(defaultData: true))
}
