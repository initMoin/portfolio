//
//  QuoteView.swift
//  DailyQuoteFetcher
//
//  Created by Moinuddin Ahmad on 9/2/25.
//

import SwiftUI

@MainActor
struct QuoteView: View {
   @State private var quote: Quote = .placeholder
   @State private var isLoading = false
   
   private let service = QuoteService()
   private let notifications = NotificationService()
   
   var body: some View {
      VStack(spacing: 16) {
         Text("Daily Quote")
            .font(.title2).bold()
         
         Text("\"\(quote.text)\"")
         //Text("“\(quote.text)”")
            .font(.title3)
            .multilineTextAlignment(.center)
         
         if let author = quote.author {
            Text("- \(author)")
               .foregroundStyle(.secondary)
         }
         
         Button {
            Task { await refresh() }
         } label: {
            if isLoading {
               ProgressView()
            } else {
               Text("Fetch Now")
            }
         }
         .buttonStyle(.borderedProminent)
      }
      .padding()
      .task { await initialLoad() }
      .toolbar {
         ToolbarItem(placement: .topBarTrailing) {
            Button("Notify") {
               Task { await notifications.postLocalNotification(for: quote) }
            }
         }
      }
   }
   
   private func initialLoad() async {
      if let cached = service.lastQuote() { quote = cached }
      try? await notifications.requestAuthorizationIfNeeded()
      await refresh()
   }
   
   private func refresh() async {
      isLoading = true
      defer { isLoading = false }
      
      do {
         quote = try await service.fetchQuote()
      } catch {
         // TODO: Soft fallback: keep current quote
      }
   }
}


