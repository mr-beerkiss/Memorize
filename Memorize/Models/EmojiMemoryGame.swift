//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Darren Beukes on 4/1/21.
//

import Foundation


class EmojiMemoryGame: ObservableObject {
    
    // private(set) means only the class is able to modify the member but anything with a reference to class can read it
    @Published private var game: MemoryGame<String> = createGame()
    
    static func createGame() -> MemoryGame<String> {
        let cardContent = ["👻", "🕷", "🎃", "🧟‍♂️", "🧛🏼‍♂️"]
        let numberOfPairs = Int.random(in: 3...5)
        return MemoryGame<String>(numberOfPairs: numberOfPairs) { pairIndex in cardContent[pairIndex] }
    }
    
    // MARK: - Access to the model
    var cards: Array<MemoryGame<String>.Card> {
        game.cards
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        // Adhering to the `ObservableObject` protocol exposes the `objectWillChange` var which allows this class to emit events
        // However, doing this manually is error prone. It's better to use the `@Published` property wrapper
//        objectWillChange.send()
        game.choose(card: card)
    }
}

