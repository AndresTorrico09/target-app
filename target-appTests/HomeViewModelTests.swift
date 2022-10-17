//
//  HomeViewModelTests.swift
//  target-appTests
//
//  Created by Andres Leonel Torrico Cossio on 17/10/2022.
//

import XCTest
import Combine
@testable import target_app

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel(
            targetServices: TargetServicesMock()
        )
        cancellables = []
    }

    func testGetTargetsSuccessfull() {
        let expect = expectation(description: "get targets successfull")
        
        viewModel.$targets
            .dropFirst()
            .sink { targets in
                XCTAssertNotNil(targets)
                XCTAssertEqual(targets.count, 2)
                expect.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.getTargets()
        
        waitForExpectations(timeout: 1)
    }
}
