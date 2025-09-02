//
//  StepsService.swift
//  StepCounter
//
//  Created by Moinuddin Ahmad on 8/21/25.
//

import Foundation

struct StepsService {
   var goal: Int = 8000
   var store: HealthStore
   
   func stepsProgress() async -> (steps: Int, percent: Double) {
      do {
         try await store.requestAuthorization()
         let steps = try await store.todaySteps()
         return (steps, min(1, Double(steps) / Double(max(1, goal))))
      } catch {
         let steps = (try? await store.todaySteps()) ?? 0
         return (steps, min(1, Double(steps) / Double(max(1, goal))))
      }
   }
}
