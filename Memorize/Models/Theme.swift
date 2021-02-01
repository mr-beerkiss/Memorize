//
//  Theme.swift
//  Memorize
//
//  Created by Darren Beukes on 27/1/21.
//

import SwiftUI

struct Theme {
  enum GameSize {
    case random
    case fixed(Int)
  }
  
  var name: String
  var emoji: [String]
  // TODO: Fix awkward naming
  var numberOfCards: GameSize
  var color: Color
  
  var numberOfPairs: Int {
    switch numberOfCards {
    case .fixed(let totalCards):
      return totalCards / 2
    case .random:
      let minimum = min(3, emoji.count)
      return Int.random(in: minimum...emoji.count)
    }
  }
}
