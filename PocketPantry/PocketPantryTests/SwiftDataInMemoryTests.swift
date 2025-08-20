//
//  SwiftDataInMemoryTests.swift
//  Pocket Pantry
//
//  Created by Moinuddin Ahmad on 8/20/25.
//

import SwiftData
import XCTest
@testable import PocketPantry

final class SwiftDataInMemoryTests: XCTestCase {
   func testInsertAndFetch() throws {
      let config = ModelConfiguration(isStoredInMemoryOnly: true)
      let container = try ModelContainer(for: PantryItem.self, configurations: config)
      let ctx = ModelContext(container)
      
      ctx.insert(PantryItem(name: "Milk", quantity: 1))
      try ctx.save()
      
      let fetched = try ctx.fetch(FetchDescriptor<PantryItem>(
         sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
      ))
      
      XCTAssertEqual(fetched.count, 1)
      XCTAssertEqual(fetched.first?.name, "Milk")
   }
}
