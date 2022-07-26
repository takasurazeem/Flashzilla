//
//  ContentView.swift
//  Flashzilla
//
//  Created by Takasur Azeem on 27/07/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled

    @State private var showingEditScreen = false
    @State private var isActive = true
    
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @StateObject var model = Cards()
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    
                ZStack {
                    ForEach(Array(model.cards.enumerated()), id: \.element) { item in
                        CardView(card: item.element) { shouldRemove in
                            withAnimation {
                                removeCard(at: item.offset, shouldRemove: shouldRemove)
                            }
                        }
                        .stacked(at: item.offset, in: model.cards.count)
                        .allowsHitTesting(item.offset == model.cards.count - 1)
                        .accessibilityHidden(item.offset < model.cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                if model.cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: model.cards.count - 1, shouldRemove: true)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: model.cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding().background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { scenePhase in
            if scenePhase == .active, !model.cards.isEmpty {
                isActive = true
            } else {
                isActive = false
            }
        }
        .onAppear(perform: resetCards)
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCards(model: model)
        }
    }
    
    func removeCard(at index: Int, shouldRemove: Bool = false) {
        guard index >= 0 else { return }
        if shouldRemove {
            model.cards.remove(at: index)
        } else {
//            cards = cards.shuffled()
            model.cards.move(fromOffsets: IndexSet(integer: index), toOffset: 0)
        }
        if model.cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        model.loadData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offfset = Double(total - position)
        return self.offset(x: 0, y: offfset * 10)
    }
}
