//
//  ReusableView.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 24/10/2022.
//

import Foundation
import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
