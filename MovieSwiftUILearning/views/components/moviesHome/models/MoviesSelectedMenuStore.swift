// 

import Foundation
import Combine

final class MoviesSelectedMenuStore: ObservableObject {
  let pageListener: MoviesMenuPageListener
  @Published var menu: MoviesMenu {
    didSet {
      pageListener.menu = menu
    }
  }
  init(selectedMenu: MoviesMenu) {
    self.menu = selectedMenu
    self.pageListener = MoviesMenuPageListener(menu: selectedMenu)
  }
}
