//
//  ResizableView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 11/5/24.
//

import SwiftUI

struct ResizableView: ViewModifier {
  @Binding var transform: Transform
  @State private var previousOffset: CGSize = .zero
  @State private var previousRotation: Angle = .zero
  @State private var scale: CGFloat = 1.0
  
  let minSize: CGSize = CGSize(width: 50, height: 50)
  
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
        if transform.rotation.degrees.isNaN {
          transform.rotation = .zero
        }
        previousRotation = .zero
      }
  }
  
  var scaleGesture: some Gesture {
    MagnificationGesture()
      .onChanged { scale in
        self.scale = scale
      }
      .onEnded { scale in
        let newWidth = max(transform.size.width*scale, minSize.width)
        let newHeight = max(transform.size.height*scale, minSize.height)
        transform.size = CGSize(width: newWidth, height: newHeight)
        self.scale = 1.0
      }
  }
  
  func body(content: Content) -> some View {
    content
      .frame(
        width: transform.size.width,
        height: transform.size.height
      )
      .onAppear {
        previousOffset = transform.offset
      }
      .rotationEffect(transform.rotation)
      .scaleEffect(scale)
      .offset(transform.offset)
      .gesture(dragGesture)
      .gesture(SimultaneousGesture(rotationGesture, scaleGesture))
  }
}

extension View {
  func resizableView(transform: Binding<Transform>) -> some View {
    modifier(ResizableView(transform: transform))
    }
  }

  struct ResizableView_Previews: PreviewProvider {
    static var previews: some View {
      RoundedRectangle(cornerRadius: 30.0)
        .foregroundColor(Color.blue)
        .resizableView()
    }
  }

  extension View {
    func resizableView() -> some View {
      modifier(ResizableView(transform: .constant(Transform())))
    }
}
