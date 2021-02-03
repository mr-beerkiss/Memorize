//
//  Cardify.swift
//  Memorize
//
//  Created by Darren Beukes on 3/2/21.
//

import SwiftUI

struct Cardify: ViewModifier {
  var isFaceUp: Bool
  var cardColor: Color
  
  func body(content: Content) -> some View {
    ZStack {
      if isFaceUp {
        RoundedRectangle(cornerRadius: cornerSize)
          .fill(Color.white)
        RoundedRectangle(cornerRadius: cornerSize)
          .stroke(lineWidth: edgeWidth)
        content
      } else {
        RoundedRectangle(cornerRadius: cornerSize)
      }
    }
    .foregroundColor(cardColor)
  }
  
  private let cornerSize: CGFloat = 10.0
  private let edgeWidth: CGFloat = 3.0
}

extension View {
  func cardify(isFaceUp: Bool, cardColor: Color) -> some View {
    self.modifier(Cardify(isFaceUp: isFaceUp, cardColor: cardColor))
  }
}
