// 

import UIKit
import Combine
import SwiftUI

final class ImageService {
  static let shared = ImageService()
  private init() {}
  
  enum Size: String {
      case small = "https://image.tmdb.org/t/p/w154/"
      case medium = "https://image.tmdb.org/t/p/w500/"
      case cast = "https://image.tmdb.org/t/p/w185/"
      case original = "https://image.tmdb.org/t/p/original/"
      
      func path(poster: String) -> URL {
          return URL(string: rawValue)!.appendingPathComponent(poster)
      }
  }
  
  enum ImageError: Error {
      case decodingError
  }
  
  func fetchImage(poster: String, size: Size) -> AnyPublisher<UIImage?, Never> {
    URLSession.shared
      .dataTaskPublisher(for: size.path(poster: poster))
      .tryMap { data, resp in UIImage(data: data) }
      .catch { _ in Just(nil) }
      .eraseToAnyPublisher()
  }
}
