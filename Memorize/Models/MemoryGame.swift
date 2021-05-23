//
//  MemoryGame.swift
//  Memorize
//
//  Created by Darren Beukes on 4/1/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
  private(set) var cards: [Card]
  private(set) var theme: Theme
  private(set) var score: Int = 0
  
  private var indexOfFaceUpCard: Int? {
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
            score = max(0, score - 1)
          } else {
            cards[chosenIndex].wasSeen = true
          }
          
          if cards[potentialMatchIndex].wasSeen {
            score = max(0, score - 1)
          } else {
            cards[potentialMatchIndex].wasSeen = true
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
    
    init(content: CardContent, isFaceUp: Bool) {
      self.init(content: content)
      self.isFaceUp = isFaceUp
    }
    
    var id: String
    var isFaceUp = false {
      didSet {
        if isFaceUp {
          // TODO: Much cleaner to set `wasSeen` here, but doing so subtracts 2 points from a match where only 1 card was seen before
          // My hypothesis is that `wasSeen` is set as soon a single card is turned face up, rather than when a two cards have been
          // turned up for a match
//          if !wasSeen {
//            wasSeen = true
//          }
          startUsingBonusTime()
        } else {
          stopUsingBonusTime()
        }
      }
    }
    var isMatched = false {
      didSet {
        stopUsingBonusTime()
      }
    }
    var wasSeen = false
    var content: CardContent
    
    // MARK: - Bonus Time
    
    // This could give matching bonus points
    // if the user matches the card
    // before a certain amount of time passes
    // during which the card is face up
    
    // can be zero which means "no bonus available" for this card
    var bonusTimeLimit: TimeInterval = 6
    
    // how long this card has ever been face up
    private var faceUpTime: TimeInterval {
      if let lastFaceUpDate = self.lastFaceUpDate {
        return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
      } else {
        return pastFaceUpTime
      }
    }
    
    // the last time this card was turned face up ( and is still face up)
    var lastFaceUpDate: Date?
    
    // the accumulated time this card has been face up in the past
    // (i.e. not including the current time it's been face up if it is currently so
    var pastFaceUpTime: TimeInterval = 0
    
    // how much bonus tome left before the bonus opportunity runs out
    var bonusTimeRemaining: TimeInterval {
      max(0, bonusTimeLimit - faceUpTime)
    }
    
    // percentage of bonus time remaining
    var bonusRemaining: Double {
      (bonusTimeLimit > 0 && bonusTimeRemaining > 0 ) ? bonusTimeRemaining : 0
    }
    
    // whether the card was matched during the bonus time period
    var hasEarnedBonus: Bool {
      isMatched && bonusTimeRemaining > 0
    }
    
    // whether we are currently face up, umatched and have not yet used up the bonus window
    var isConsumingBonusTime: Bool {
      isFaceUp && !isMatched && bonusTimeRemaining > 0
    }
    
    // called when the card transitions to face up state
    private mutating func startUsingBonusTime() {
      if isConsumingBonusTime, lastFaceUpDate == nil {
        lastFaceUpDate = Date()
      }
    }
    
    // called when the card goes back face down (or gets matched)
    private mutating func stopUsingBonusTime() {
      pastFaceUpTime = faceUpTime
      self.lastFaceUpDate = nil
    }
  }
}
  
  
