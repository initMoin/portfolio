# iOS 26 Micro‑Apps Portfolio

A focused portfolio of small, interview‑ready iOS apps built with **Swift 6**, **SwiftUI**, and iOS 26 APIs.  
Each app is a separate Xcode project (no shared workspace) to keep setup simple and friction‑free.

- **Xcode:** 26 (beta)
- **iOS SDK:** 18.0+
- **Architecture:** Model–View (MV) with tiny service helpers
- **Tests:** Fast unit tests (pure logic + in‑memory persistence where applicable)

---

## Apps

### 1. [PocketPantry](PocketPantry/README.md)
- **Frameworks:** SwiftData  
- **Features:**  
  - `@Model` pantry items with CRUD operations  
  - `@Query` list with “expiring soon” filter  
  - Schema evolution demo: v1 → v1.1 adds `expiryDate`  
  - Unit tests with in-memory SwiftData container  
- **Focus:** Persistence, queries, safe migrations  

---

### 2. [StepCounter](StepCounter/README.md)
- **Frameworks:** HealthKit, WidgetKit, (optional) ActivityKit  
- **Features:**  
  - App UI shows today’s steps and progress toward goal  
  - Widget extension (small/medium) with hourly refresh  
  - Simulated store for previews + simulator fallback  
  - Unit tests for `StepsService`  
- **Focus:** HealthKit integration, interactive widgets  

---

### 3. HotColdFinder (Coming Soon)
- **Frameworks:** NearbyInteraction, MultipeerConnectivity  
- **Features:**  
  - Seeker vs Target mode with token exchange  
  - Real-time distance feedback (“hotter/colder”)  
- **Focus:** Spatial computing APIs, responsive feedback  

---

### 4. DailyQuoteFetcher (Coming Soon)
- **Frameworks:** BackgroundTasks, UserNotifications  
- **Features:**  
  - Daily BGAppRefreshTask fetches a motivational quote  
  - Posts local notification with minimal UI  
- **Focus:** Background execution, notification delivery  

---

## Repo Structure
ios26-microapps-portfolio/
   - PocketPantry/
      - PocketPantry.xcodeproj
      - PocketPantry/
      - PocketPantryTests/
      - README.md
   - StepCounterWidget/
      - StepCounterWidget.xcodeproj
      - StepCounter/
      - StepCounterWidget/
      - README.md
   - HotColdFinder/
   - DailyQuoteFetcher/
   - README.md

---

## Getting Started

1. **Clone**
   git clone https://github.com/<you>/ios26-microapps-portfolio.git
2. **Open a project**
   * Example: PocketPantry/PocketPantry.xcodeproj
3. **Build & Run**
   * Requires Xcode 26 (beta) and iOS SDK 18.0+
   * Select an iPhone Simulator and run
> Each app is independent -- open only the project you want to run. No shared workspace needed.

---

## Testing

* Each app has its own test bundle. Run tests with ⌘U (Product → Test).
* Tests cover:
  * Pure logic (e.g., formatting, countdowns, step percentage mapping)
  * Persistence using an in-memory SwiftData ModelContainer (fast, disk-free)

Example:
```
import SwiftData

let config = ModelConfiguration(isStoredInMemoryOnly: true)
let container = try ModelContainer(for: PantryItem.self, configurations: config)
let ctx = ModelContext(container)
```
if you see **"No such module 'XCTest'"**, set the file's **Target Membership** to the test bundle (not the app target).

## Tracking & Docs
* Planning and tasks are managed in Notion database with:
    * Kanban by Status
    * Boards per app
    * Priority view for actionable tasks
    * QA queue
* Each app includes a README.md with:
  * Features implemented and rationale
  * Migration notes (if any)
  * Demo script (60-90s)
* Add a short demo GIF (20-30s) when each app is finished.

## Status
* Pocket Pantry // v1.1 complete / CRUD, migration, tests
* Step Counter Widget // MVP v1.0 complete / app, widget, tests
* Holt-Cold Finder // pending
* Daily Quote Fetcher // pending
