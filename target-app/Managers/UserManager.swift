//
//  UserManager.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 19/09/2022.
//

import Foundation

class UserDataManager: NSObject {
  
  static var currentUser: User? {
    get {
      let defaults = UserDefaults.standard
      if
        let data = defaults.data(forKey: "target-user"),
        let user = try? JSONDecoder().decode(User.self, from: data)
      {
        return user
      }
      return nil
    }
    
    set {
      let user = try? JSONEncoder().encode(newValue)
      UserDefaults.standard.set(user, forKey: "target-user")
    }
  }
  
  class func deleteUser() {
    UserDefaults.standard.removeObject(forKey: "target-user")
  }
  
  static var isUserLogged: Bool {
    currentUser != nil
  }
}
