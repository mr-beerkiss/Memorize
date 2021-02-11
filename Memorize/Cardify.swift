//
//  Cardify.swift
//  Memorize
//
//  Created by Darren Beukes on 3/2/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
  var rotation: Double
  var cardColor: Color
  
  var isFaceUp: Bool {
    rotation < 90
  }
  
  var animatableData: Double {
    get { return rotation }
    set { rotation = newValue }
  }
  
  init(isFaceUp: Bool, cardColor: Color) {
    rotation = isFaceUp ? 0 : 180
    self.cardColor = cardColor
  }
  
  func body(content: Content) -> some View {
    ZStack {
      Group {
        RoundedRectangle(cornerRadius: cornerSize)
          .fill(Color.white)
        RoundedRectangle(cornerRadius: cornerSize)
          .stroke(lineWidth: edgeWidth)
        content
      }
        .opacity(isFaceUp ? 1 : 0)
      RoundedRectangle(cornerRadius: cornerSize)
        .opacity(isFaceUp ? 0 : 1)
    }
    .foregroundColor(cardColor)
    .rotation3DEffect(
      .degrees(rotation),
      axis: (0,1,0)
    )
  }
  
  private let cornerSize: CGFloat = 10.0
  private let edgeWidth: CGFloat = 3.0
}

extension View {
  func cardify(isFaceUp: Bool, cardColor: Color) -> some View {
    self.modifier(Cardify(isFaceUp: isFaceUp, cardColor: cardColor))
  }
}
