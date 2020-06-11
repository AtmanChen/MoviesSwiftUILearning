// 

import SwiftUI

struct MoviePosterImage: View {
  @ObservedObject var imageLoader: ImageLoader
  @State var isImageLoaded = false
  let posterSize: PosterStyle.Size
  var body: some View {
    Group {
      if imageLoader.image != nil {
        Image(uiImage: self.imageLoader.image!)
          .resizable()
          .renderingMode(.original)
          .posterStyle(loaded: isImageLoaded, size: posterSize)
          .animation(.easeInOut)
          .onAppear {
            self.isImageLoaded = true
          }
      } else {
        Rectangle()
          .foregroundColor(.gray)
          .posterStyle(loaded: false, size: posterSize)
      }
    }
  }
}

