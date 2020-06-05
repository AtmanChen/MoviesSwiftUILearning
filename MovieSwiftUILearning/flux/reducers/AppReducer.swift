// 

import Foundation
import SwiftUIFlux

func appStateReducer(state: AppState, action: Action) -> AppState {
  var state = state
  state.moviesState = moviesReducer(state: state.moviesState, action: action)
  return state
}
