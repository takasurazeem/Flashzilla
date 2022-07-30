//
//  Card.swift
//  Flashzilla
//
//  Created by Takasur Azeem on 27/07/2022.
//

import Foundation

struct Card: Codable, Identifiable, Hashable {
    var id = UUID()
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "What is 2 + 2?", answer: "4")
}
