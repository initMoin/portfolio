//
//  HealthStore.swift
//  StepCounter
//
//  Created by Moinuddin Ahmad on 8/21/25.
//

import Foundation
import HealthKit

protocol HealthStore {
   func isAvailable() -> Bool
   func requestAuthorization() async throws
   func todaySteps() async throws -> Int
}

struct HealthKitStore: HealthStore {
   private let store = HKHealthStore()
   
   func isAvailable() -> Bool {
      HKHealthStore.isHealthDataAvailable()
   }
   
   func requestAuthorization() async throws {
      guard isAvailable() else { return }
      let steps = HKObjectType.quantityType(forIdentifier: .stepCount)!
      try await store.requestAuthorization(toShare: [], read: [steps])
   }
   
   func todaySteps() async throws -> Int {
      let stepsType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
      let start = Calendar.current.startOfDay(for: Date())
      
      let query = HKStatisticsCollectionQueryDescriptor(
         predicate: HKQuery.predicateForSamples(withStart: start, end: nil),
         options: .cumulativeSum,
         anchorDate: start,
         intervalComponents: DateComponents(day: 1)
      )
      
      let result = try await query.result(for: store)
      let today = result.statistics().first(where: { Calendar.current.isDate($0.startDate, inSameDayAs: start) })
      let sum = today?.sumQuantity()
      
      return Int(sum?.doubleValue(for: .count()) ?? 0)
   }
}

struct SimulatedHealthStore: HealthStore {
   func isAvailable() -> Bool { false }
   func requestAuthorization() async throws {}
   func todaySteps() async throws -> Int { 5234 }
}
