//
//  AppGoesBackgroundContentView.swift
//  Flashzilla
//
//  Created by Takasur Azeem on 27/07/2022.
//

import SwiftUI

struct AppGoesBackgroundContentView: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .padding()
            .onChange(of: scenePhase) { newValue in
                switch newValue {
                case .active:
                    print("Active")
                case .inactive:
                    print("Inactive")
                case .background:
                    print("Background")
                @unknown default:
                    print("@unknown default:")
                }
            }
    }
}

struct AppGoesBackgroundContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppGoesBackgroundContentView()
    }
}
