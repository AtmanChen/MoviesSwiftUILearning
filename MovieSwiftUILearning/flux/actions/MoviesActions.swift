// 

import Foundation
import SwiftUIFlux

struct MoviesActions {
  struct FetchMoviesMenuList: AsyncAction {
    let list: MoviesMenu
    let page: Int
    
    func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
      APIService.shared.GET(
        endpoint: list.endpoint(),
        params: [
          "page": "\(page)",
          "region": AppUserDefaults.region
        ]) { (result: Result<PaginatedResponse<Movie>, APIService.APIError>) in
          switch result {
          case let .success(response):
            dispatch(
              SetMovieMenuList(
                page: self.page,
                list: self.list,
                response: response))
          case let .failure(error):
            print(error)
          }
      }
    }
  }
  
  struct SetMovieMenuList: Action {
    let page: Int
    let list: MoviesMenu
    let response: PaginatedResponse<Movie>
  }
}
