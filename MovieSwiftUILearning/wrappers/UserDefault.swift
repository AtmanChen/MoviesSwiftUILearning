// 

import Foundation

@propertyWrapper
struct UserDefault<T> {
  let key: String
  let defaultValue: T
  
  init(key: String, defaultValue: T) {
    self.key = key
    self.defaultValue = defaultValue
  }
  
  var wrappedValue: T {
    set {
      UserDefaults.standard.set(newValue, forKey: key)
    }
    get {
      UserDefaults.standard.value(forKey: key) as? T ?? defaultValue
    }
  }
}
