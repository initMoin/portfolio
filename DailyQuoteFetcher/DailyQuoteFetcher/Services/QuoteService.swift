//
//  QuoteService.swift
//  DailyQuoteFetcher
//
//  Created by Moinuddin Ahmad on 9/2/25.
//

import Foundation

@MainActor
final class QuoteService: Sendable {
   private let session: URLSession
   private let sourceURL: URL
   
   init(session: URLSession = .shared,
        sourceURL: URL = URL(string: "https://api.quotable.io/random")!) {
      self.session = session
      self.sourceURL = sourceURL
   }
   
   struct APIQuote: Decodable {
      let content: String
      let author: String
   }
   
   func fetchQuote() async throws -> Quote {
      let (data, response) = try await session.data(from: sourceURL)
      
      guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
         throw URLError(.badServerResponse)
      }
      
      if let decoded = try? JSONDecoder().decode(APIQuote.self, from: data) {
         let quote = Quote(text: decoded.content, author: decoded.author, date: .now)
         persist(quote)
         
         return quote
      }
      
      if let raw = String(data: data, encoding: .utf8), raw.isEmpty == false {
         let quote = Quote(text: raw, author: nil, date: .now)
         persist(quote)
         
         return quote
      }
      
      throw URLError(.cannotParseResponse)
   }
   
   func lastQuote() -> Quote? {
      let defaults = UserDefaults.standard
      guard
         let data = defaults.data(forKey: AppIDs.userDefaultsLastQuoteKey),
         let quote = try? JSONDecoder().decode(Quote.self, from: data)
      else { return nil }
      
      return quote
   }
   
   private func persist(_ quote: Quote) {
      let defaults = UserDefaults.standard
      
      if let data = try? JSONEncoder().encode(quote) {
         defaults.set(data, forKey: AppIDs.userDefaultsLastQuoteKey)
      }
      
      defaults.set(Date(), forKey: AppIDs.userDefaultsLastFetchKey)
   }
}


