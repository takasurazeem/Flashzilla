//
//  VibrationsAndHapticsContentView.swift
//  Flashzilla
//
//  Created by Takasur Azeem on 27/07/2022.
//

import SwiftUI
import CoreHaptics

struct VibrationsAndHapticsContentView: View {
    
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Text("Hello, World!")
            .onAppear(perform: prepareHaptics)
            .onTapGesture(perform: complexSuccess)
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            print(#function, "Error, HapticsEngine not supported")
            return
        }
        var events = [CHHapticEvent]()
        
        // create one intense, sharp tap
        let intesity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intesity, sharpness], relativeTime: 0)
        events.append(event)
        
        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            print(#function, "Error, HapticsEngine not supported")
            return
        }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
}

struct VibrationsAndHapticsContentView_Previews: PreviewProvider {
    static var previews: some View {
        VibrationsAndHapticsContentView()
    }
}
