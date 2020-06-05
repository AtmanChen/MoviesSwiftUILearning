// 

import Foundation

struct AppUserDefaults {
  @UserDefault(key: "user_region", defaultValue: Locale.current.regionCode ?? "US")
  static var region: String
  
  @UserDefault(key: "original_title", defaultValue: false)
  static var alwaysOriginalTitle: Bool
}
