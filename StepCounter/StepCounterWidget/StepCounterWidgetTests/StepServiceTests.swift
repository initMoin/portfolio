//
//  StepsServiceTests.swift
//  StepCounter
//
//  Created by Moinuddin Ahmad on 8/21/25.
//

import XCTest
@testable import StepCounterWidget

final class StepServiceTests: XCTestCase {
   func testPercentMapping() async {
      let service = StepsService(goal: 8000, store: SimulatedHealthStore())
      let result = await service.stepsProgress()
      
      XCTAssertEqual(result.steps, 5234)
      XCTAssertEqual(Int(result.percent * 100), Int((5234.0 / 8000.0) * 100))
   }
}

