//
//  SwiftUIView.swift
//  Memorize
//
//  Created by Darren Beukes on 4/1/21.
//

import SwiftUI

struct CardView: View {
  var card: MemoryGame<String>.Card
//  var isFaceUp: Bool
//  var isMatched = false
  var themeColor: Color
//  var bonusTimeRemaining: Double
//  var content: String
  
  @State private var animatedBonusRemaining: Double = 0
  
//  var body: some View {
//    GeometryReader { geometry in
//      ZStack {
//        if isFaceUp || isMatched {
//          RoundedRectangle(cornerRadius: cornerSize)
//            .fill(Color.white)
//          RoundedRectangle(cornerRadius: cornerSize)
//            .stroke(lineWidth: edgeWidth)
//          Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(20), clockwise: true)
//            .padding(5)
//            .opacity(0.35)
//          Text(content)
//            .transition(.scale)
//        } else {
//          RoundedRectangle(cornerRadius: cornerSize)
//            .transition(.slide)
//        }
//      }
//      .font(Font.system(size: fontSize(for: geometry.size)))
//      .foregroundColor(themeColor)
//    }
//  }
//
  var body: some View {
    GeometryReader { geometry in
      self.body(for: geometry.size)
    }
  }				

  @ViewBuilder
  private func body(for size: CGSize) -> some View {
    if card.isFaceUp || !card.isMatched {
      ZStack {
//        Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(20), clockwise: true)br
        Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
          .padding(5)
          .opacity(0.35)
        Text(card.content)
          .font(Font.system(size: fontSize(for: size)))
          .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
          .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)

      }
      .cardify(isFaceUp: card.isFaceUp, cardColor: themeColor)
      .transition(.scale)
      
    }
  }
  
  
  // MARK: - Drawing Constants

  private let cornerSize: CGFloat = 10.0
  private let edgeWidth: CGFloat = 3.0
  
  private func fontSize(for size: CGSize) -> CGFloat {
    return min(size.width, size.height) * 0.7
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    let cards = [
      MemoryGame<String>.Card(content: "👎"),
      MemoryGame<String>.Card(content: "👍", isFaceUp: true)
    ]
    Group {
      CardView(card: cards[0], themeColor: .red)
      CardView(card: cards[1], themeColor: .red)
    }
    .previewLayout(.fixed(width: 150, height: 200))
  }
}
