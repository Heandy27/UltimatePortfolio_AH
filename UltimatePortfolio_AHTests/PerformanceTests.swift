//
//  PerformanceTests.swift
//  UltimatePortfolio_AHTests
//
//  Created by Andy Heredia on 9/9/25.
//

import XCTest
@testable import UltimatePortfolio_AH

final class PerformanceTests: BaseTestCase {

    func testAwardCalculationPerformance() {
        for _ in 1...100 {
            dataController.createSampleData()
        }

        let awards = Array(repeating: Award.allAwards, count: 25).joined()
        XCTAssertEqual(awards.count, 500, "This checks the awards count is constant. Change this if you add awards.")

        measure {
            _ = awards.filter(dataController.hasEarned).count
        }
    }
}
