// 

import Foundation
import SwiftUIFlux

private var savePath: URL!
private let encoder = JSONEncoder()
private let decoder = JSONDecoder()

struct AppState: FluxState, Codable {
  var moviesState: MoviesState
  
  #if DEBUG
  init(moviesState: MoviesState) {
    self.moviesState = moviesState
  }
  #endif
  
  init() {
    do {
      let documentDir = try FileManager.default.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: false)
      savePath = documentDir.appendingPathComponent("userdata")
    } catch let error {
      fatalError("Couldn't create save state data with error: \(error)")
    }
    
    if let data = try? Data(contentsOf: savePath),
      let savedState = try? decoder.decode(AppState.self, from: data) {
      self.moviesState = savedState.moviesState
    } else {
      self.moviesState = MoviesState()
    }
  }
}

