//
//  EditCards.swift
//  Flashzilla
//
//  Created by Takasur Azeem on 29/07/2022.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    @StateObject private var model: Cards
    
    init(model: Cards) {
        _model = StateObject(wrappedValue: model)
    }
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                }
                
                Section {
                    ForEach(0..<model.cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(model.cards[index].prompt)
                                .font(.headline)
                            Text(model.cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards(at:))
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear(perform: model.loadData)
        }
    }
    
    func done() {
        dismiss()
    }
    
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        model.cards.insert(card, at: 0)
        model.saveData()
        // Clear Text Fields
        newPrompt = ""
        newAnswer = ""
    }
    
    func removeCards(at offsets: IndexSet) {
        model.cards.remove(atOffsets: offsets)
        model.saveData()
    }
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards(model: Cards())
            .previewInterfaceOrientation(.landscapeRight)
    }
}
