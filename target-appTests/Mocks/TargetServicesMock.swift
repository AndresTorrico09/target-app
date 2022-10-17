//
//  TargetServicesMock.swift
//  target-appTests
//
//  Created by Andres Leonel Torrico Cossio on 17/10/2022.
//

import Foundation
@testable import target_app

final class TargetServicesMock: TargetServicesProtocol {
    
    func getAll(completion: @escaping (Result<[target_app.Target], Error>) -> Void) {
        let targetsResponse = [
            Target(
                id: 1,
                title: "TEST title",
                latitude: 0.0,
                longitude: 0.0,
                radius: 0.0,
                topic: Topic(
                    id: 1,
                    icon: "test_icon.jpg",
                    label: "TEST label")
            ),
            Target(
                id: 2,
                title: "TEST title 2",
                latitude: 0.0,
                longitude: 0.0,
                radius: 0.0,
                topic: Topic(
                    id: 1,
                    icon: "test_icon_2.jpg",
                    label: "TEST label 2")
            )
        ]
        completion(.success(targetsResponse))
    }
    
    func save(title: String, latitude: Double, longitude: Double, radius: Double, topicId: Int, completion: @escaping (Result<target_app.Target, Error>) -> Void) {
        
    }
}
