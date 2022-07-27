//
//  HitTestingContentView.swift
//  Flashzilla
//
//  Created by Takasur Azeem on 27/07/2022.
//

import SwiftUI

struct HitTestingContentView: View {
    var body: some View {
        /*
        ZStack {
            Rectangle()
                .fill(.green)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
                }
            
            Circle()
                .fill(.regularMaterial)
                .frame(width: 300, height: 300)
                .contentShape(Rectangle())
                .onTapGesture {
                    print("Circle tapped!")
                }
//                .allowsHitTesting(false)
        }
         */
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("You")
        }
        .contentShape(Rectangle())
        .onTapGesture {
            print("VStack tapped!")
        }
    }
}

struct HitTestingContentView_Previews: PreviewProvider {
    static var previews: some View {
        HitTestingContentView()
    }
}
