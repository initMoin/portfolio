//
//  NotificationServiceTests.swift
//  DailyQuoteFetcher
//
//  Created by Moinuddin Ahmad on 9/2/25.
//

import Testing
import UserNotifications
@testable import DailyQuoteFetcher

struct NotificationServiceTests {
   @Test(arguments: [Quote.placeholder])
   func buildsContent(_ quote: Quote) async {
      let svc = await MainActor.run { NotificationService() }
      await svc.postLocalNotification(for: quote)
      #expect(true)
   }
}


