//
//  StepsView.swift
//  StepCounter
//
//  Created by Moinuddin Ahmad on 8/21/25.
//

import SwiftUI

struct StepsView: View {
   @State private var steps: Int = 0
   @State private var percent: Double = 0.0
   
   #if targetEnvironment(simulator)
   private let service = StepsService(goal: 8000, store: SimulatedHealthStore())
   #else
   private let service = StepsService(goal: 8000, store: HealthKitStore())
   #endif
   
   var body: some View {
      VStack(spacing: 16) {
         ProgressView(value: percent)
            .progressViewStyle(.linear)
            .padding(.horizontal)
         Text("\(steps) steps")
            .font(.title3).monospacedDigit()
         Text("\(Int(percent * 100))% of 8,000")
            .font(.caption).foregroundStyle(.secondary)
         Button("Refresh") { Task { await refresh() } }
            .buttonStyle(.borderedProminent)
      }
      .padding()
      .onAppear { Task { await refresh() } }
      .navigationTitle("Steps")
   }
   
   private func refresh() async {
      let result = await service.stepsProgress()
      await MainActor.run {
         steps = result.steps
         percent = result.percent
      }
   }
   
}

