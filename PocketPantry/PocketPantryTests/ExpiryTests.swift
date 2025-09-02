//
//  ExpiryTests.swift
//  Pocket Pantry
//
//  Created by Moinuddin Ahmad on 8/20/25.
//

import XCTest
@testable import PocketPantry

final class ExpiryTests: XCTestCase {
   func testDaysUntilExpiry() {
      let cal = Calendar.current
      let today = cal.startOfDay(for: .now)
      let in3 = cal.date(byAdding: .day, value: 3, to: today)!
      let past2 = cal.date(byAdding: .day, value: -1, to: today)!
      
      XCTAssertEqual(PantryItem.daysUntilExpiry(from: in3), 3)
      XCTAssertEqual(PantryItem.daysUntilExpiry(from: past2), -2)
      XCTAssertNil(PantryItem.daysUntilExpiry(from: nil))
   }
}

