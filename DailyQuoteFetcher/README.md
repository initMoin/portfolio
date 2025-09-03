# DailyQuoteFetcher

Background task demo that fetches a motivational quote from the network and delivers it via local notification once per day. Minimal SwiftUI UI, **MV (Model–View)** + services, and unit tests with **Swift Testing**.

- **Xcode:** 26 beta  
- **iOS:** 26.0+  
- **Swift:** 6.x  
- **Architecture:** Model–View (no view models) + services  

---

## Features (and Why)

- **Quote model (`Quote`)**
  - **What:** Codable struct with `text`, `author`, `date`.  
  - **Why:** Provides a lightweight, serializable model for networking and persistence.

- **Networking (`QuoteService`)**
  - **What:** Uses `URLSession` + `async/await` to fetch a random quote from the Quotable API (`https://api.quotable.io/random`).  
  - **Why:** Demonstrates modern API consumption with error handling and multiple decoding strategies.

- **Persistence**
  - **What:** Saves the last quote + fetch timestamp in `UserDefaults`.  
  - **Why:** Avoids over-engineering (SwiftData not required) while proving persistence capability.

- **Background refresh**
  - **What:** Registers a `BGAppRefreshTask` that runs daily, fetching and caching a new quote.  
  - **Why:** Showcases background task scheduling and lifecycle management.

- **Local notifications**
  - **What:** Posts a notification with the quote text + author.  
  - **Why:** Demonstrates local notification scheduling and delivery.

- **Deep link from notification**
  - **What:** Tapping a delivered notification routes back into the app’s `QuoteView`.  
  - **Why:** Shows handling of notification payloads to support navigation flows.

- **Repeat delivery & permissions QA**
  - **What:** Debug button shows current notification authorization state and can trigger immediate notification delivery.  
  - **Why:** Provides tools for verifying repeat delivery and permission handling in development.

- **Resilience**
  - **What:** Fallback to last cached quote on network errors; soft handling of failures.  
  - **Why:** Keeps the UI functional and highlights awareness of offline/error scenarios.

---

## Architecture

- **Model** → `Quote` (Codable struct)  
- **View** → `QuoteView` (SwiftUI screen with Fetch + Debug controls)  
- **Services** →  
  - `QuoteService` → Networking + persistence  
  - `NotificationService` → Local notifications (request auth + post)  
  - `BackgroundScheduler` → Registers/schedules BG tasks  
- **App** → `DailyQuoteFetcherApp` wires everything with `.backgroundTask`

Pattern: **Model–View + Services**.

---

## Project Structure

```
DailyQuoteFetcher/  
├─ App/  
│  ├─ DailyQuoteFetcherApp.swift  
│  └─ AppIDs.swift  
├─ Models/  
│  └─ Quote.swift  
├─ Services/  
│  ├─ QuoteService.swift  
│  ├─ NotificationService.swift  
│  └─ BackgroundScheduler.swift  
├─ Views/  
│  └─ QuoteView.swift  
├─ Resources/  
│  └─ Info.plist  
├─ Supporting/  
│  └─ DailyQuoteFetcher.entitlements  
│
DailyQuoteFetcherTests/  
├─ QuoteServiceTests.swift  
└─ NotificationServiceTests.swift  
```

---

## App Identifiers & Capabilities

- **Bundle ID:** `com.MoinAhmad.DailyQuoteFetcher`  
- **BG refresh task identifier:** `com.MoinAhmad.DailyQuoteFetcher.refresh`  
- **Entitlements/Capabilities:**  
  - Background Modes → ✅ Background fetch  
  - Push Notifications → ✅ (for local notifications)  
- **Info.plist additions:**  
  - `BGTaskSchedulerPermittedIdentifiers` → includes refresh identifier  
  - `UIApplicationSceneManifest` → `UIApplicationSupportsMultipleScenes` = `NO`  

---

## Build & Run

1. Enable required capabilities in Signing & Capabilities.  
2. Add BGTask identifier to **Info.plist**.  
3. Run the app:  
   - On first launch, grant Notifications.  
   - Tap **Fetch Now** to verify API + caching.  
4. Simulate background fetch:  
   - Xcode menu → **Debug → Simulate Background Fetch**.  
   - Expected: local notification with a new quote.

---

## Testing

- **Unit tests (Swift Testing)**  
  - `QuoteServiceTests` → Injects mocked `URLSession` to validate decode + error paths.  
  - `NotificationServiceTests` → Fires notification code path (verifies no crash).  

Run with ⌘U in Xcode 26. Ensure target membership is **DailyQuoteFetcherTests**.

---

## Accessibility

- Dynamic Type support in `QuoteView`.  
- VoiceOver reads “Daily Quote” header, quote, and author.  
- Secondary styling for author line maintains contrast.

---

## Troubleshooting

- **No notifications appear** → Verify permissions (Settings → Notifications).  
- **BG task doesn’t fire** → Check Info.plist identifier + Background fetch enabled.  
- **Offline mode** → App shows last cached quote.  
- **Simulator limits** → Use “Simulate Background Fetch” (system heuristics differ on device).  
- **Low Power Mode** → Background refresh may be deferred.

---

## Future Ideas (Not in MVP)

- In-app scheduling control (time of day).  
- Cache quote history with SwiftData.  
- Widget showing today’s quote.  
- Share sheet integration.  
- App Intents → Siri/Shortcuts: “Give me today’s quote.”  

---

## Demo Script (60–90s)

1. Launch app → grant Notifications.  
2. Show placeholder or last cached quote.  
3. Tap **Fetch Now** → new quote appears.  
4. Note persistence (quote survives relaunch).  
5. Trigger **Simulate Background Fetch** → notification delivered.  
6. Tap notification → app deep-links to quote screen.  
7. Show Debug button checking permission + posting immediate notification.  

---

## Changelog

### [1.0.0] — 2025-08-24
- Initial release with daily background fetch + notification delivery.  
- Networking with Quotable API (async/await + Codable).  
- Persistence of last quote in UserDefaults.  
- Local notifications with deep link back into app.  
- Debug button for repeat delivery + permission checks.  
- Resilience for offline/error cases.  
- Unit tests + accessibility pass.  

---

## License

MIT License

Copyright (c) 2025 Moinuddin Ahmad

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.