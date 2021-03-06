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
          Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(20), clockwise: true)
            .padding(5)
            .opacity(0.35)
          Text(content)
        } else {
          RoundedRectangle(cornerRadius: cornerSize)
        }
      }
      .font(Font.system(size: fontSize(for: geometry.size)))
      .foregroundColor(themeColor)
    }
  }
//
//  var body: some View {
//    GeometryReader { geometry in
//      self.body(for: geometry.size)
//    }
//  }
//
//  @ViewBuilder
//  private func body(for size: CGSize) -> some View {
//    if isFaceUp || !isMatched {
//      ZStack {
//        Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(20), clockwise: true)
//          .padding(5)
//          .opacity(0.35)
//        Text(content)
//          .font(Font.system(size: fontSize(for: size)))
//
//      }
//      .cardify(isFaceUp: isFaceUp, cardColor: themeColor)
//    }
//  }
  
  
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
      MemoryGame<String>.Card(content: "👍")
    ]
    Group {
      CardView(isFaceUp: false, themeColor: .red, content: cards[0].content)
      CardView(isFaceUp: true, themeColor: .red, content: cards[1].content)
    }
    .previewLayout(.fixed(width: 150, height: 200))
  }
}
