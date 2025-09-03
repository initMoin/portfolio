# iOS 26 Micro-Apps Portfolio

A collection of four small, surgical iOS apps built with **Xcode 26 (beta)**, **Swift 6**, **SwiftUI**, and modern Apple APIs. Each app demonstrates targeted features for interviews and showcases clean code, MV architecture, unit tests, and accessibility basics.

## Apps

### 1. [PocketPantry](PocketPantry/README.md)
- **Frameworks:** SwiftData  
- **Features:** `@Model` CRUD, `@Query` list with “expiring soon,” v1 → v1.1 migration via optional `expiryDate`, in-memory SwiftData tests.  
- **Focus:** Persistence, queries, safe migrations.

### 2. [StepCounter](StepCounter/README.md)
- **Frameworks:** HealthKit, WidgetKit, (optional) ActivityKit  
- **Features:** App UI with steps and progress; widget with hourly timeline; simulated store for previews/simulator; unit tests for `StepsService`; watchOS companion app with sync via WatchConnectivity.  
- **Focus:** HealthKit integration, widgets, cross-device sync.

### 3. [HotColdFinder](HotColdFinder/README.md)
- **Frameworks:** NearbyInteraction, MultipeerConnectivity  
- **Features:** Seeker/Target roles; NI discovery token exchange over MPC; ranging session with live HOT/WARM/COLD mapping; polished fallback banner for unsupported devices; unit tests for `HotColdMapper` and `PeerMessage`.  
- **Focus:** Spatial computing APIs (UWB), real-time feedback, capability-aware UI.  
- **Hardware Requirement:** Requires two UWB-capable iPhones (iPhone 11 or newer). QA blocked until a second UWB device is available.

### 4. [DailyQuoteFetcher](DailyQuoteFetcher/README.md)
- **Frameworks:** BackgroundTasks, UserNotifications  
- **Features:**  
  - Networking (URLSession async/await) to fetch quotes from the Quotable API.  
  - Persistence via `UserDefaults` (last quote + timestamp).  
  - Background refresh with `BGAppRefreshTask`.  
  - Local notifications with quote text + author.  
  - Deep link into the app from notification tap.  
  - Debug tools for repeat delivery + permission QA.  
  - Resilience fallback to cached quote if offline.  
- **Focus:** Networking, background execution, notification delivery.

## Repo Structure
```
ios26-microapps-portfolio/
├─ PocketPantry/
│  ├─ PocketPantry.xcodeproj
│  ├─ PocketPantry/
│  ├─ PocketPantryTests/
│  └─ README.md
├─ StepCounter/
│  ├─ StepCounter.xcodeproj
│  ├─ StepCounter/
│  ├─ StepCounterTests/
│  └─ README.md
├─ HotColdFinder/
│  ├─ HotColdFinder.xcodeproj
│  ├─ HotColdFinder/
│  ├─ HotColdFinderTests/
│  └─ README.md
├─ DailyQuoteFetcher/
│  ├─ DailyQuoteFetcher.xcodeproj
│  ├─ DailyQuoteFetcher/
│  ├─ DailyQuoteFetcherTests/
│  └─ README.md
└─ README.md              # this file
```

## Getting Started

1. Clone the repo:
   ```
   git clone https://github.com/<you>/ios26-microapps-portfolio.git
   ```
2. Open any app project (`.xcodeproj`) in **Xcode 26 (beta)**.  
3. Run on an iOS 18.0+ simulator or device.

> Each app is independent. There is no shared workspace—open the project you want to explore.

## Testing

- Each app includes its own test bundle; run with **⌘U** in Xcode.  
- Coverage:
  - Pure logic (e.g., formatting, percent mapping).  
  - In-memory SwiftData persistence (PocketPantry).  
- Note:
  - If you see `"No such module 'XCTest'"`, ensure a **Unit Testing Bundle** exists and test files’ **Target Membership** is the test bundle.

## Tracking

- Development tracked in Notion (boards by App and Status; Priority view; QA queue).  
- Each app includes a `README.md` with features, migration/demo notes, and a demo script.  
- Add short demo GIFs (20–30s) as apps are finished.

## Status

- ✅ PocketPantry — v1.1 complete (CRUD + migration + tests)
- ✅ StepCounter — MVP complete (app + widget + tests)
- ✅ HotColdFinder — MVP complete (NI + MPC, HOT/WARM/COLD, tests)
- ✅ DailyQuoteFetcher — v1.0 complete (Networking + BackgroundTasks + Notifications + tests)

## Portfolio Changelog

### [1.0.0] — 2025-08-12
- **PocketPantry** released (SwiftData CRUD + schema migration demo).

### [1.0.0] — 2025-08-21
- **StepCounter** released (HealthKit + WidgetKit + Watch app companion).  
- Interactive widget with Liquid Glass background.  
- Added Watch app with live sync.

### [1.0.0] — 2025-08-23
- **HotColdFinder** released (NearbyInteraction + MultipeerConnectivity demo).  
- Requires two UWB-capable Apple devices.

### [1.0.0] — 2025-08-24
- **DailyQuoteFetcher** released (Networking + BackgroundTasks + Notifications).  
- Features deep link from notification + repeat delivery/permissions QA.

## License

MIT License

Copyright (c) 2025 Moinuddin Ahmad

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


