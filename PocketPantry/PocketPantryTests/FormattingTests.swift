//
//  FormattingTests.swift
//  Pocket Pantry
//
//  Created by Moinuddin Ahmad on 8/20/25.
//

import XCTest
@testable import PocketPantry

final class FormattingTests: XCTestCase {
   func testDDay() {
      let cal = Calendar.current
      let today = cal.startOfDay(for: .now)
      let in3 = cal.date(byAdding: .day, value: 3, to: today)
      let past2 = cal.date(byAdding: .day, value: -2, to: today)
      
      XCTAssertEqual(Formatting.dDay(from: in3), "D-3")
      XCTAssertEqual(Formatting.dDay(from: past2), "D+2")
   }
}
