//
//  PantryItem.swift
//  Pocket Pantry
//
//  Created by Moinuddin Ahmad on 8/19/25.
//

import SwiftData
import Foundation

@Model
final class PantryItem {
   var name: String
   var quantity: Int
   var createdAt: Date
   var expiryDate: Date?
   
   init(name: String, quantity: Int, createdAt: Date = .now, expiryDate: Date? = nil) {
      self.name = name
      self.quantity = quantity
      self.createdAt = createdAt
      self.expiryDate = expiryDate
   }
}

extension PantryItem {
   static func daysUntilExpiry(from date: Date?) -> Int? {
      guard let date else { return nil }
      
      let cal = Calendar.current
      let start = cal.startOfDay(for: .now)
      let other = cal.startOfDay(for: date)
      
      return cal.dateComponents([.day], from: start, to: other).day
   }
}
