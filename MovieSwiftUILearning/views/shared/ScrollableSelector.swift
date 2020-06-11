// 

import SwiftUI

struct ScrollableSelector: View {
  let items: [String]
  @Binding var selectIndex: Int
  
  func text(for index: Int) -> some View {
    Group {
      if index == selectIndex {
        Text(items[index])
          .foregroundColor(.white)
          .font(.headline)
          .fontWeight(.heavy)
          .padding(4)
          .background(Color.steamGold)
          .cornerRadius(8)
      } else {
        Text(items[index])
          .foregroundColor(.primary)
          .font(.headline)
          .onTapGesture {
            self.selectIndex = index
          }
      }
    }
  }
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(alignment: .center, spacing: 12) {
        ForEach(0..<self.items.count) {
          self.text(for: $0)
        }
      }
      .padding([.trailing, .leading], 8)
    }
    .frame(height: 36)
    .background(Color.steamBackground)
    .cornerRadius(8)
  }
}

struct ScrollableSelector_Previews: PreviewProvider {
  static var previews: some View {
    ScrollableSelector(items: ["Menu 1", "Menu 2", "Menu 3",
    "Menu 4", "Menu 5", "Menu 6",
    "Menu 7", "Menu 8"], selectIndex: .constant(1))
  }
}
