//
//  SpecificAccessibilitySettingsContentVIew.swift
//  Flashzilla
//
//  Created by Takasur Azeem on 27/07/2022.
//

import SwiftUI

struct SpecificAccessibilitySettingsContentVIew: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0
    
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var body: some View {
        VStack {
            HStack {
                if differentiateWithoutColor {
                    Image(systemName: "checkmark.circle")
                }
                Text("Success")
            }
            .padding()
            .background(differentiateWithoutColor ? .black : .green)
            .foregroundColor(.white)
            .clipShape(Capsule())
            
            Text("Salam!")
                .scaleEffect(scale)
                .onTapGesture {
                    withOptionalAnimation {
                        scale *= 1.5
                    }
                }
            
            Text("Peace!")
                .padding()
                .background(reduceTransparency ? .green : .green.opacity(0.5))
                .clipShape(Capsule())
        }
    }
    
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
}

struct SpecificAccessibilitySettingsContentVIew_Previews: PreviewProvider {
    static var previews: some View {
        SpecificAccessibilitySettingsContentVIew()
    }
}
