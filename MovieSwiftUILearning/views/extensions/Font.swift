// 

import SwiftUI

extension Font {
  public static func FHACondFrenchNC(size: CGFloat) -> Font {
    Font.custom("FHA Condensed French NC", size: size)
  }
  
  public static func AmericanCaptain(size: CGFloat) -> Font {
    Font.custom("American Captain", size: size)
  }
  
  public static func FjallaOne(size: CGFloat) -> Font {
    Font.custom("FjallaOne-Regular", size: size)
  }
}

struct TitleFont: ViewModifier {
  let size: CGFloat
  func body(content: Content) -> some View {
    content
      .font(Font.FjallaOne(size: size))
  }
}

extension View {
  func titleFont(size: CGFloat) -> some View {
    ModifiedContent(content: self, modifier: TitleFont(size: size))
  }
  func titleStyle() -> some View {
    ModifiedContent(content: self, modifier: TitleFont(size: 16))
  }
}
