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

struct Item_Previews: PreviewProvider {
  struct ItemPreview: View {
    @EnvironmentObject var store: CardStore
    
    var body: some View {
      CardElementView(element: initialElements[0])
        .resizableView(transform: $store.itemsCards[0].elements[0].transform)
    }
  }
  static var previews: some View {
    ItemPreview()
      .environmentObject(CardStore(defaultData: true))
  }
}
