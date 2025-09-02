//
//  Formatting.swift
//  Pocket Pantry
//
//  Created by Moinuddin Ahmad on 8/20/25.
//

import Foundation

enum Formatting {
   static func dDay(from date: Date) -> String {
      let cal = Calendar.current
      let start = cal.startOfDay(for: .now)
      let other = cal.startOfDay(for: date)
      let days = cal.dateComponents([.day], from: start, to: other).day ?? 0
      
      if days == 0 {
         return "D-Day"
      }
      
      return days > 0 ? "D-\(days)" : "D+\(-days)"
   }
}
