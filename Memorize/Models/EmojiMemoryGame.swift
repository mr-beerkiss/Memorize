//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Darren Beukes on 4/1/21.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
  static let themes: [Theme] = [
    Theme(name: "Halloween", emoji: ["👻", "🕷", "🎃", "🧟‍♂️", "🧛🏼‍♂️"], numberOfCards: .random, color: .orange),
    Theme(name: "Travel", emoji: ["🛳", "🚲", "🛩", "🚙", "🚈", "🛹"], numberOfCards: .fixed(12), color: .blue),
    Theme(name: "Music", emoji: ["🎸", "🎹", "🎤", "🎻", "🥁", "🎺"], numberOfCards: .fixed(6), color: .purple)
  ]
  
  // private(set) means only the class is able to modify the member but anything with a reference to class can read it
  @Published private var game: MemoryGame<String> = createGame()

  static func createGame() -> MemoryGame<String> {
//    let selectedTheme = Int.random(in: 0..<themes.count)
    let selectedTheme = 2
    return MemoryGame<String>(theme: themes[selectedTheme]) { pairIndex in themes[selectedTheme].emoji[pairIndex] }
  }
  
  // MARK: - Access to the model

  var cards: [MemoryGame<String>.Card] {
    game.cards
  }
  
  var theme: Theme {
    game.theme
  }
  
  var score: Int {
    game.score
  }
  
  // MARK: - Intent(s)

  func choose(card: MemoryGame<String>.Card) {
    // Adhering to the `ObservableObject` protocol exposes the `objectWillChange` var which allows this class to emit events
    // However, doing this manually is error prone. It's better to use the `@Published` property wrapper
    //        objectWillChange.send()
    game.choose(card: card)
  }
  
  func newGame() {
    game = EmojiMemoryGame.createGame()
  }
}
