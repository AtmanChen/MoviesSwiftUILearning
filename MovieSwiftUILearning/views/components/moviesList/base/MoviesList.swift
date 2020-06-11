// 

import SwiftUIFlux
import SwiftUI

struct MoviesList<HeaderView: View>: ConnectedView {
  struct Props {
    let searchedMovies: [Int]?
    let searchedKeywords: [Keyword]?
    let searcherdPeoples: [Int]?
    let recentSearches: [String]
  }
  enum SearchFilter: Int {
    case movies
  }
  @State private var searchFilter: Int = SearchFilter.movies.rawValue
  @State private var isSearching: Bool = false
  
  let movies: [Int]
  let displaySearch: Bool
  var pageListener: MoviesMenuPageListener?
  var headerView: HeaderView?
  
  func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
    if isSearching {
      return Props(searchedMovies: state.moviesState.search[""],
                   searchedKeywords: state.moviesState.searchKeywords[""]?.prefix(5).map{ $0 },
                   searcherdPeoples: nil,
                   recentSearches: state.moviesState.recentSearches.map{ $0 })
    }
    return Props(searchedMovies: nil, searchedKeywords: nil, searcherdPeoples: nil, recentSearches: [])
  }
  
  private func moviesRow(props: Props) -> some View {
    ForEach(isSearching ? props.searchedMovies ?? [] : movies, id: \.self) { id in
      MovieRow(movieId: id)
    }
  }
  
  private func moviesSection(props: Props) -> some View {
    Section {
      moviesRow(props: props)
    }
  }
  
  func body(props: Props) -> some View {
    List {
      if headerView != nil {
        Section {
          headerView!
        }
      }
      moviesSection(props: props)
    }
  }
}
