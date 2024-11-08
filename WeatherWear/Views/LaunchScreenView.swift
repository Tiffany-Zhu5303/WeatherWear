//
//  LaunchScreenView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/7/24.
//

import SwiftUI

private struct LaunchAnimation: ViewModifier {
  @State private var animating = true
  
  let finalYPosition: CGFloat
  let delay: Double
  
  func body(content: Content) -> some View {
    content
      .offset(y: animating ? -500 : finalYPosition)
      .onAppear {
        withAnimation(Animation.easeOut(duration: delay)) {
          animating = false
        }
      }
  }
}

struct LaunchScreenView: View {
    var body: some View {
      VStack {
        ZStack {
          Image(systemName: "sun.max")
            .resizable()
            .frame(
              width: 208,
              height: 211
            )
            .scaledToFit()
            .symbolRenderingMode(.monochrome)
            .foregroundColor(Color("Moonstone"))
          Image(systemName: "jacket.fill")
            .resizable()
            .frame(
              width: 42,
              height: 35
            )
            .scaledToFit()
            .symbolRenderingMode(.monochrome)
            .foregroundColor(Color("MintGreen"))
        }
        .launchAnimation(finalYposition: 0, delay: 0.75)
        
        Text("WEATHER WEAR")
          .foregroundStyle(Color("Moonstone"))
          .fontWeight(.bold)
          .font(.title)
          .padding(.top)
      }
    }
}

private extension View {
  func launchAnimation(
    finalYposition: CGFloat,
    delay: Double
  ) -> some View {
    modifier(LaunchAnimation(
      finalYPosition: finalYposition,
      delay: delay)) }
}

#Preview(traits: .sizeThatFitsLayout) {
    LaunchScreenView()
}
