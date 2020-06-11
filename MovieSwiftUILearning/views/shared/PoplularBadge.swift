//

import SwiftUI

struct PoplularBadge: View {
  let score: Int
  @State var isDisplayed = false
  var scoreColor: Color {
    if score < 40 {
      return .red
    } else if score < 60 {
      return .orange
    } else if score < 75 {
      return .yellow
    }
    return .green
  }
  var overlay: some View {
    ZStack {
      Circle()
        .stroke(Color.secondary, lineWidth: 2)
      Circle()
        .trim(
          from: 0,
          to: isDisplayed ? CGFloat(score) / 100 : 0
        )
        .stroke(scoreColor, lineWidth: 2)
        .animation(Animation.interpolatingSpring(stiffness: 60, damping: 10).delay(0.1))
    }
    .rotationEffect(.degrees(-90))
    .onAppear { self.isDisplayed = true }
  }
  var body: some View {
    ZStack {
      Circle()
        .foregroundColor(.clear)
        .frame(width: 40)
        .overlay(overlay)
      Text("\(score)%")
        .font(.system(size: 10))
        .fontWeight(.bold)
        .foregroundColor(.primary)
    }
    .frame(width: 40, height: 40)
  }
}


