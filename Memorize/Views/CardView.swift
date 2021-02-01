//
//  SwiftUIView.swift
//  Memorize
//
//  Created by Darren Beukes on 4/1/21.
//

import SwiftUI

struct CardView: View {
  var isFaceUp: Bool
  var isMatched = false
  var themeColor: Color
  var content: String
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        if isFaceUp || isMatched {
          RoundedRectangle(cornerRadius: cornerSize)
            .fill(Color.white)
          RoundedRectangle(cornerRadius: cornerSize)
            .stroke(lineWidth: edgeWidth)
          Text(content)
        } else {
          RoundedRectangle(cornerRadius: cornerSize)
        }
      }
      .font(Font.system(size: fontSize(for: geometry.size)))
      .foregroundColor(themeColor)
    }
  }
  
  // MARK: - Drawing Constants

  let cornerSize: CGFloat = 10.0
  let edgeWidth: CGFloat = 3.0
  
  func fontSize(for size: CGSize) -> CGFloat {
    return min(size.width, size.height) * 0.75
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    let cards = [
      MemoryGame<String>.Card(content: "👎"),
      MemoryGame<String>.Card(content: "👍")
    ]
    Group {
      CardView(isFaceUp: false, themeColor: .red, content: cards[0].content)
      CardView(isFaceUp: true, themeColor: .red, content: cards[1].content)
    }
    .previewLayout(.fixed(width: 150, height: 200))
  }
}
