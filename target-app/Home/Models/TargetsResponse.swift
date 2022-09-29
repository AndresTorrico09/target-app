//
//  TargetsResponse.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 26/09/2022.
//

import Foundation

struct TargetsResponse: Codable {
    let targets: [TargetElement]
    
    func toDomain() -> [Target] {
        return targets.map { $0.target }
    }
}

struct TargetElement: Codable {
    let target: Target
}
