// 

import Foundation
import SwiftUIFlux

func moviesReducer(state: MoviesState, action: Action) -> MoviesState {
  var state = state
  switch action {
  case let action as MoviesActions.SetMovieMenuList:
    if action.page == 1 {
      state.moviesList[action.list] = action.response.results.map(\.id)
    } else {
      if var list = state.moviesList[action.list] {
        list.append(contentsOf: action.response.results.map(\.id))
        state.moviesList[action.list] = list
      } else {
        state.moviesList[action.list] = action.response.results.map(\.id)
      }
    }
    state.movies += action.response.results
  default: break
  }
  return state
}

private func +=(lhs: inout [Int: Movie], rhs: [Movie]) {
  for movie in rhs {
    lhs[movie.id] = movie
  }
}
