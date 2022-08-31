//
//  SessionManager.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 31/08/2022.
//

import UIKit

class SessionManager: NSObject {

  static var currentSession: Session? {
    get {
      if
        let data = UserDefaults.standard.data(forKey: "ios-base-session"),
        let session = try? JSONDecoder().decode(Session.self, from: data)
      {
        return session
      }
      return nil
    }
    
    set {
      let session = try? JSONEncoder().encode(newValue)
      UserDefaults.standard.set(session, forKey: "ios-base-session")
    }
  }
  
  class func deleteSession() {
    UserDefaults.standard.removeObject(forKey: "ios-base-session")
  }
  
  static var validSession: Bool {
    if let session = currentSession, let uid = session.uid,
       let tkn = session.accessToken, let client = session.client {
      return !uid.isEmpty && !tkn.isEmpty && !client.isEmpty
    }
    return false
  }
}
