// 

import SwiftUI
import SwiftUIFlux

struct MoviesHomeList<Header: View>: ConnectedView {
  struct Props {
    let movies: [Int]
  }
  
  @Binding var menu: MoviesMenu
  let pageListener: MoviesMenuPageListener
  var headerView: Header?
  
  func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
    Props(movies: state.moviesState.moviesList[menu] ?? [])
  }
  func body(props: Props) -> some View {
    MoviesList(
      movies: props.movies,
      displaySearch: false,
      pageListener: pageListener,
      headerView: headerView
    )
    .navigationBarTitle(menu.title())
  }
}
