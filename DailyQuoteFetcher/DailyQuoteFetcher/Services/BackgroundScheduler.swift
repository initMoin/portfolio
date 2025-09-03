//
//  BackgroundScheduler.swift
//  DailyQuoteFetcher
//
//  Created by Moinuddin Ahmad on 9/2/25.
//

import Foundation
import BackgroundTasks

@MainActor
final class BackgroundScheduler: Sendable {
   static let shared = BackgroundScheduler()
   
   private init() {}
   
   func register(quoteService: QuoteService, notificationService: NotificationService) {
      BGTaskScheduler.shared.register(forTaskWithIdentifier: AppIDs.bgRefreshID, using: nil) { task in
         self.handleAppRefresh(task: task as! BGAppRefreshTask,
                               quoteService: quoteService,
                               notificationService: notificationService)
      }
   }
   
   func scheduleNextRefresh(earliest: TimeInterval = 60 * 60 * 24) {
      let request = BGAppRefreshTaskRequest(identifier: AppIDs.bgRefreshID)
      request.earliestBeginDate = Date(timeIntervalSinceNow: earliest)
      try? BGTaskScheduler.shared.submit(request)
   }
   
   private func handleAppRefresh(task: BGAppRefreshTask,
                                 quoteService: QuoteService,
                                 notificationService: NotificationService) {
      scheduleNextRefresh()
      
      task.expirationHandler = {
         task.setTaskCompleted(success: false)
      }
      
      Task {
         do {
            let quote = try await quoteService.fetchQuote()
            await notificationService.postLocalNotification(for: quote)
            task.setTaskCompleted(success: true)
         } catch {
            task.setTaskCompleted(success: false)
         }
      }
   }
}


