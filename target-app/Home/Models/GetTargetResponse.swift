//
//  GetTargetResponse.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 26/09/2022.
//

import Foundation

struct GetTargetResponse: Codable {
    let targets: [TargetElement]
}

struct TargetElement: Codable {
    let target: Target
}
