//
//  NotificationService.swift
//  DailyQuoteFetcher
//
//  Created by Moinuddin Ahmad on 9/2/25.
//

import Foundation
import UserNotifications

@MainActor
final class NotificationService: Sendable {
   func requestAuthorizationIfNeeded() async throws {
      let center = UNUserNotificationCenter.current()
      let settings = await center.notificationSettings()
      
      guard settings.authorizationStatus != .authorized else { return }
      
      let granted = try await center.requestAuthorization(options: [.alert, .sound, .badge])
      if !granted { throw NSError(domain: "Notifications", code: 1) }
   }
   
   func postLocalNotification(for quote: Quote) async {
      let content = UNMutableNotificationContent()
      
      content.title = "Daily Quote"
      content.body = "\"\(quote.text)\"" + (quote.author.map { " - \($0)" } ?? "")
      content.sound = .default
      
      let request = UNNotificationRequest(
         identifier: UUID().uuidString,
         content: content,
         trigger: nil)
      
      try? await UNUserNotificationCenter.current().add(request)
   }
}


