//
//  CardView.swift
//  Flashzilla
//
//  Created by Takasur Azeem on 27/07/2022.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    let card: Card
    var removal: ((Bool) -> Void)? = nil
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                    ? .white
                    : .white
                        .opacity(1 - Double(abs(offset.width) / 50))
                )
                .background(
                    differentiateWithoutColor
                    ? nil
                    :
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(offset.width == 0 ? .white : offset.width > 0 ? .green : .red)
                )
                .shadow(radius: 10)
            
            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibility(addTraits: .isButton)
        .gesture(
            DragGesture()
                .onChanged{ gesture in
                    offset = gesture.translation
                    feedback.prepare()
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        if offset.width > 0 {
                            // feedback.notificationOccurred(.success)
                            // optional /\ \/
                            // TODO: - Modify it to have a button to enable/disable haptics for success.
                            // SUCCESS Remove the card
                            removal?(true)
                        } else {
                            feedback.notificationOccurred(.error)
                            removal?(false)
                            offset = .zero
                            if isShowingAnswer {
                                isShowingAnswer = false
                            }
                        }
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring(), value: offset)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
            .previewInterfaceOrientation(.landscapeRight)
        //            .preferredColorScheme(.dark)
    }
}
