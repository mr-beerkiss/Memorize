//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Darren Beukes on 4/1/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
  var body: some Scene {
    WindowGroup {
      EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
  }
}
