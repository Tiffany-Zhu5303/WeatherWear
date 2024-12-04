//
//  CardThumbnail.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 12/2/24.
//

import Foundation
import SwiftUI

struct ScreenshotView: UIViewRepresentable {
    var view: UIView
    
    func makeUIView(context: Context) -> UIView {
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // No update needed in this case
    }
    
    static func captureScreenshot(of view: UIView) -> UIImage? {
        // Start a graphics context to capture the screenshot
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        
        // Render the view into the context
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        
        // Get the screenshot as an image
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the graphics context
        UIGraphicsEndImageContext()
        
        return screenshot
    }
}
