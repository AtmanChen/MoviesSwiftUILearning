// 

import SwiftUI
import SwiftUIFlux

fileprivate let formatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .medium
  return formatter
}()

struct MovieRow: ConnectedView {
  struct Props {
    let movie: Movie
  }
  let movieId: Int
  var displayListImage = true
  func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
    Props(movie: state.moviesState.movies[movieId]!)
  }
  func body(props: Props) -> some View {
    HStack {
      ZStack(alignment: .topLeading) {
        MoviePosterImage(
          imageLoader: ImageLoaderCache.shared.loaderFor(
            path: props.movie.poster_path,
            size: .medium),
          posterSize: .medium)
      }
      .fixedSize()
      VStack(alignment: .leading, spacing: 8) {
        Text(props.movie.userTitle)
          .titleStyle()
          .foregroundColor(.steamGold)
          .lineLimit(2)
        HStack {
          PoplularBadge(score: Int(props.movie.vote_average * 10))
          Text(formatter.string(from: props.movie.releaseDate ?? Date()))
            .font(.subheadline)
            .foregroundColor(.primary)
            .lineLimit(1)
        }
        Text(props.movie.overview)
          .foregroundColor(.secondary)
          .lineLimit(3)
          .truncationMode(.tail)
      }
      .padding([.leading], 8)
    }
    .padding([.top, .bottom], 8)
  }
}
