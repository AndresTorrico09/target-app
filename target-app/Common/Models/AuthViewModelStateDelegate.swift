//
//  AuthViewModelStateDelegate.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 30/08/2022.
//

import Foundation

protocol NetworkStatusDelegate: AnyObject {
  func networkStatusChanged(to networkStatus: NetworkState)
}

protocol AuthViewModelStateDelegate: NetworkStatusDelegate {
  func didUpdateState(to state: AuthViewModelState)
}
