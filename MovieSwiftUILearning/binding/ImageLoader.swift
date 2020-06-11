// 

import SwiftUI
import Combine
import UIKit

final class ImageLoaderCache {
  static let shared = ImageLoaderCache()
  private init() {}
  var loaders: NSCache<NSString, ImageLoader> = NSCache()
  func loaderFor(path: String?, size: ImageService.Size) -> ImageLoader {
    let key = NSString(string: "\(path ?? "missing")#\(size.rawValue)")
    if let loader = loaders.object(forKey: key) {
      return loader
    } else {
      let loader = ImageLoader(path: path, size: size)
      loaders.setObject(loader, forKey: key)
      return loader
    }
  }
}

final class ImageLoader: ObservableObject {
  let path: String?
  let size: ImageService.Size
  
  var objectWillChange: AnyPublisher<UIImage?, Never> = Publishers.Sequence(sequence: []).eraseToAnyPublisher()
  @Published var image: UIImage?
  var cancellable: AnyCancellable?
  
  init(path: String?, size: ImageService.Size) {
    self.path = path
    self.size = size
    
    self.objectWillChange = $image.handleEvents(
      receiveSubscription: { [weak self] _ in
        self?.loadImage()
      }, receiveCancel: { [weak self] in
        self?.cancellable?.cancel()
      }).eraseToAnyPublisher()
  }
  
  private func loadImage() {
    guard let poster = path, image == nil else {
      return
    }
    cancellable = ImageService.shared.fetchImage(poster: poster, size: size)
      .receive(on: DispatchQueue.main)
      .assign(to: \.image, on: self)
  }
  
  deinit {
    cancellable?.cancel()
  }
}
