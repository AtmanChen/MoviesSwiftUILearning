// 

import SwiftUI
import SwiftUIFlux
import Combine

struct MoviesHome: View {
  
  private enum MoviesHomeDisplayMode {
    case list, grid
    
    func iconName() -> String {
      switch self {
      case .list: return "rectangle.3.offgrid.fill"
      case .grid: return "rectangle.grid.1x2"
      }
    }
    
    mutating func toggle() {
      if self == .list {
        self = .grid
      } else {
        self = .list
      }
    }
  }
  
  @EnvironmentObject private var store: Store<AppState>
  @ObservedObject private var selectedMenu = MoviesSelectedMenuStore(selectedMenu: MoviesMenu.allCases.first!)
  @State private var isSettingPresented = false
  @State private var homeDisplayMode: MoviesHomeDisplayMode = .list
  private var segmentedView: some View {
    ScrollableSelector(
      items: MoviesMenu.allCases.map { $0.title() },
      selectIndex: Binding<Int>(
        get: { self.selectedMenu.menu.rawValue },
        set: { self.selectedMenu.menu = MoviesMenu(rawValue: $0)! }
      )
    )
  }
  private var settingButton: some View {
    Button(action: { self.isSettingPresented = true }) {
      HStack {
        Image(systemName: "wrench").imageScale(.medium)
      }
      .frame(width: 30, height: 30)
    }
  }
  private var swapHomeButton: some View {
    Button(action: { self.homeDisplayMode.toggle() }) {
      HStack {
        Image(systemName: self.homeDisplayMode.iconName())
      }
      .frame(width: 30, height: 30)
    }
  }
  
  private var homeAsList: some View {
    MoviesHomeList(
      menu: $selectedMenu.menu,
      pageListener: selectedMenu.pageListener,
      headerView: segmentedView)
  }
  
  var body: some View {
    NavigationView {
      homeAsList
    }
    .navigationBarItems(
      trailing: HStack {
        swapHomeButton
        settingButton
      }
    )
    .sheet(isPresented: $isSettingPresented) {
      EmptyView()
    }
  }
  
}

struct MoviesHome_Previews: PreviewProvider {
  static var previews: some View {
    MoviesHome()
  }
}
