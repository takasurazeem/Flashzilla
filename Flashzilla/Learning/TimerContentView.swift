//
//  TimerContentView.swift
//  Flashzilla
//
//  Created by Takasur Azeem on 27/07/2022.
//

import SwiftUI

struct TimerContentView: View {
    
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    var body: some View {
        Text("Hello, World!")
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }
                
                counter += 1
            }
    }
}

struct TimerContentView_Previews: PreviewProvider {
    static var previews: some View {
        TimerContentView()
    }
}
