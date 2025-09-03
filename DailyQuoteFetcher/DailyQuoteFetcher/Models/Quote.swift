//
//  Quote.swift
//  DailyQuoteFetcher
//
//  Created by Moinuddin Ahmad on 9/2/25.
//

import Foundation

struct Quote: Codable, Equatable, Sendable {
   let text: String
   let author: String?
   let date: Date
   
   static let placeholder = Quote(text: "Stay hungry, stay foolish.", author: "Steve Jobs", date: .now)
}
