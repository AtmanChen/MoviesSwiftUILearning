// 

import SwiftUI

struct HomeView: View {
  var body: some View {
    TabBarView()
  }
}

struct TabBarView: View {
  
  enum Tab: Int {
    case movies, discover, fanClub, mine
  }
  
  @State var selectTab: Tab = .movies
  
  var body: some View {
    TabView(selection: $selectTab) {
      MoviesHome()
        .tabItem {
          self.tabBarItem(text: "Movies", image: "film")
        }
        .tag(Tab.movies)
      DiscoverView()
        .tabItem {
          self.tabBarItem(text: "Discover", image: "square.stack")
        }
        .tag(Tab.discover)
    }
  }
  
  private func tabBarItem(text: String, image: String) -> some View {
    VStack {
      Image(systemName: image)
        .imageScale(.large)
      Text(text)
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
