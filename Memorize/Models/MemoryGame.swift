//
//  MemoryGame.swift
//  Memorize
//
//  Created by Darren Beukes on 4/1/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
  var cards: [Card]
  var theme: Theme
  var score: Int = 0
  
  var indexOfFaceUpCard: Int? {
    get { cards.indices.filter { cards[$0].isFaceUp }.only }
    set {
      for index in cards.indices {
        cards[index].isFaceUp = index == newValue
      }
    }
  }
  
  init(theme: Theme, cardContentFactory: (Int) -> CardContent) {
    self.theme = theme
    cards = []
    for pairIndex in 0..<self.theme.numberOfPairs {
      cards.append(Card(content: cardContentFactory(pairIndex)))
      cards.append(Card(content: cardContentFactory(pairIndex)))
    }
    cards.shuffle()
  }
  
  mutating func choose(card: Card) {
    if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
      if let potentialMatchIndex = indexOfFaceUpCard {
        if cards[chosenIndex].content == cards[potentialMatchIndex].content {
          cards[chosenIndex].isMatched = true
          cards[potentialMatchIndex].isMatched = true
          score += 2
        } else {
          if cards[chosenIndex].wasSeen {
            score -= 1
          } else {
            cards[chosenIndex].wasSeen = true
          }
          if cards[potentialMatchIndex].wasSeen {
            score -= 1
          } else {
            cards[chosenIndex].wasSeen = true
          }
        }
        cards[chosenIndex].isFaceUp = true
      } else {
        indexOfFaceUpCard = chosenIndex
      }
    }
  }
  
  struct Card: Identifiable, Equatable {
    static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
      return lhs.content == rhs.content
    }
    
    init(content: CardContent) {
      id = UUID().uuidString
      self.content = content
    }
    
    var id: String
    var isFaceUp = false
    var isMatched = false
    var wasSeen = false
    var content: CardContent
  }
}
