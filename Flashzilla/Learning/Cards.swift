//
//  Cards.swift
//  Flashzilla
//
//  Created by Takasur Azeem on 30/07/2022.
//

import Foundation

class Cards: ObservableObject {
    
    @Published var cards: [Card] = []
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData")
        
    init() {
        loadData()
    }
    
    func loadData() {
        do {
            let data = try Data(contentsOf: savePath)
            cards = try JSONDecoder().decode([Card].self, from: data)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func saveData() {
        do {
            let data = try JSONEncoder().encode(cards)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data: \(error.localizedDescription)")
        }
    }
}
