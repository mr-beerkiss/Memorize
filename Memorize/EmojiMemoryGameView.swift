//
//  EmojieMemoryGameView.swift
//  Memorize
//
//  Created by Darren Beukes on 4/1/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
  @ObservedObject var viewModel: EmojiMemoryGame
  
  var body: some View {
    GeometryReader { geometry in
      VStack {
        HStack {
          Text("Theme: \(viewModel.theme.name)")
            .frame(width: geometry.size.width / 2 - 20, height: nil, alignment: .leading)
            .padding(.leading, 10)
          Text("Score: \(viewModel.score)")
            .frame(width: geometry.size.width / 2 - 20, height: nil, alignment: .trailing)
            .padding(.trailing, 10)
        }

        Grid(viewModel.cards) { card in
          CardView(isFaceUp: card.isFaceUp, isMatched: card.isMatched, themeColor: viewModel.theme.color, content: card.content)
            .aspectRatio(2 / 3, contentMode: .fit)
            .onTapGesture {
              viewModel.choose(card: card)
            }
            .padding(5)
        }
        Button("New Game") {
          viewModel.newGame()
        }
        .padding()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
  }
}
