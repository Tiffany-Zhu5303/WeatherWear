//
//  ResizableView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/5/24.
//

import SwiftUI

struct ResizableView: ViewModifier {
  @State private var transform = Transform()
  @State private var previousOffset: CGSize = .zero
  @State private var previousRotation: Angle = .zero
  @State private var scale: CGFloat = 1.0
  
  var dragGesture: some Gesture {
    DragGesture()
      .onChanged { value in
        transform.offset = previousOffset + value.translation
      }
      .onEnded { _ in
        previousOffset = transform.offset
      }
  }
  
  var rotationGesture: some Gesture {
    RotationGesture()
      .onChanged { rotation in
        transform.rotation += rotation - previousRotation
        previousRotation = rotation
      }
      .onEnded { _ in
        previousRotation = .zero
      }
  }
  
  var scaleGesture: some Gesture {
    MagnificationGesture()
      .onChanged { scale in
        self.scale = scale
      }
      .onEnded { scale in
        transform.size.width *= scale
        transform.size.height *= scale
        self.scale = 1.0
      }
  }
  
  func body(content: Content) -> some View {
    content
      .frame(
        width: transform.size.width,
        height: transform.size.height
      )
      .rotationEffect(transform.rotation)
      .scaleEffect(scale)
      .offset(transform.offset)
      .gesture(dragGesture)
      .gesture(SimultaneousGesture(rotationGesture, scaleGesture))
//      .foregroundStyle(Color(color))
  }
}

extension View {
  func resizableView() -> some View {
    modifier(ResizableView())
  }
}

#Preview {
  RoundedRectangle(cornerRadius: 30.0)
    .foregroundStyle(Color("MintGreen"))
    .resizableView()
}