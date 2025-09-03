//
//  DailyQuoteFetcherApp.swift
//  DailyQuoteFetcher
//
//  Created by Moinuddin Ahmad on 9/2/25.
//

import SwiftUI
import BackgroundTasks

@main
struct DailyQuoteFetcherApp: App {
   @State private var quoteService = QuoteService()
   @State private var notificationService = NotificationService()
   
    var body: some Scene {
        WindowGroup {
            QuoteView()
              .task {
                 BackgroundScheduler.shared.register(
                  quoteService: quoteService,
                  notificationService: notificationService
                 )
                 BackgroundScheduler.shared.scheduleNextRefresh()
              }
        }
        .backgroundTask(.appRefresh(AppIDs.bgRefreshID)) {
           await handleAppRefresh()
        }
    }
   
   @MainActor
   private func handleAppRefresh() async {
      do {
         let quote = try await quoteService.fetchQuote()
         await notificationService.postLocalNotification(for: quote)
      } catch {
         // TODO: Soft-fail; system will try again based on heuristics
      }
   }
}


