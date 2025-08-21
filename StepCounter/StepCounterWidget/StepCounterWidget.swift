//
//  StepsWidget.swift
//  StepsWidget
//
//  Created by Moinuddin Ahmad on 8/21/25.
//

import WidgetKit
import SwiftUI

struct StepEntry: TimelineEntry {
   let date: Date
   let steps: Int
   let percent: Double
}

struct StepProvider: TimelineProvider {
   let service = StepsService(goal: 8000, store: SimulatedHealthStore())
   
   func placeholder(in context: Context) -> StepEntry {
      StepEntry(date: .now, steps: 5234, percent: 5234.0 / 8000.0)
   }
   
   func getSnapshot(in context: Context, completion: @escaping (StepEntry) -> Void) {
      completion(placeholder(in: context))
   }
   
   func getTimeline(in context: Context, completion: @escaping (Timeline<StepEntry>) -> Void) {
      let result = await service.stepsProgress()
      let entry = StepEntry(date: .now, steps: result.steps, percent: result.percent)
      let next = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
      
      completion(Timeline(entries: [entry], policy: .after(next)))
   }
}

struct StepCounterWidgetEntryView : View {
   var entry: StepEntry
   
   var body: some View {
      VStack(spacing: 6) {
         ProgressView(value: entry.percent)
         Text("\(entry.steps)")
            .font(.headline).monospacedDigit()
         Text("\(Int(entry.percent * 100))%")
            .font(.caption2).foregroundStyle(.secondary)
      }
      .padding()
   }
}

@main
struct StepCounterWidget: Widget {
   var body: some WidgetConfiguration {
      StaticConfiguration(kind: "StepsWidget", provider: StepProvider()) { entry in
         StepCounterWidgetEntryView(entry: entry)
      }
      .configurationDisplayName("Steps")
      .description("Shows today's steps toward your goal.")
      .supportedFamilies([.systemSmall, .systemMedium])
   }
}

