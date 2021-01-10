//
//  MemoryGame.swift
//  Memorize
//
//  Created by Darren Beukes on 4/1/21.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    init(numberOfPairs: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairs {
            cards.append(Card(content: cardContentFactory(pairIndex)))
            cards.append(Card(content: cardContentFactory(pairIndex)))
        }
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {        
        guard let index = cards.firstIndex(of: card) else {
            return
        }
        cards[index].isFaceUp.toggle()
    }
    
    struct Card: Identifiable, Equatable {
        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            return lhs.id == rhs.id
        }
        
        init(content: CardContent) {
            self.id = UUID().uuidString
            self.content = content
        }
        
        var id: String
        var isFaceUp = true
        var isMatched = false
        var content: CardContent
    }
}
