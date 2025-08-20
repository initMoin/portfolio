# iOS 26 Micro‑Apps Portfolio

A focused portfolio of small, interview‑ready iOS apps built with **Swift 6**, **SwiftUI**, and iOS 26 APIs.  
Each app is a separate Xcode project (no shared workspace) to keep setup simple and friction‑free.

- **Xcode:** 26 (beta)
- **iOS SDK:** 18.0+
- **Architecture:** Model–View (MV) with tiny service helpers
- **Tests:** Fast unit tests (pure logic + in‑memory persistence where applicable)

---

## Apps

- [**Pocket Pantry**](PocketPantry/README.md) — SwiftData CRUD + safe auto‑migration  
  _@Model, @Query, v1 → v1.1 optional field, “Expiring Soon” section, in‑memory SwiftData tests._

- [**Step Counter Widget**](StepCounterWidget/) — WidgetKit + (optionally) HealthKit + ActivityKit  
  _Small/medium widget with timeline; simulator fallback for steps; optional Live Activity if time permits._

- [**Hot‑Cold Finder**](HotColdFinder/) — NearbyInteraction + MultipeerConnectivity  
  _Two‑device token exchange; distance → heat mapping; minimal, responsive UI._

- [**Daily Quote Fetcher**](DailyQuoteFetcher/) — BackgroundTasks + UserNotifications  
  _BG refresh pulls one quote per day; posts a local notification; tiny foreground UI for manual fetch._

---

## Repo Structure
ios26-microapps-portfolio/
├─ PocketPantry/
│  ├─ PocketPantry.xcodeproj
│  ├─ PocketPantry/
│  ├─ PocketPantryTests/
│  └─ README.md
├─ StepCounterWidget/
│  ├─ StepCounterWidget.xcodeproj
│  └─ README.md
├─ HotColdFinder/
│  ├─ HotColdFinder.xcodeproj
│  └─ README.md
├─ DailyQuoteFetcher/
│  ├─ DailyQuoteFetcher.xcodeproj
│  └─ README.md
├─ README.md
└─ .gitignore

---

### 🚀 Getting Started
```markdown
## Getting Started

1. **Clone**
   ```bash
   git clone https://github.com/<you>/ios26-microapps-portfolio.git
2. **Open a project**
   ``bash
   * Example: PocketPantry/PocketPantry.xcodeproj
3. **Build & Run**
   ``bash
   * Requires Xcode 26 (beta) and iOS SDK 18.0+
   * Select an iPhone Simulator and run
> Each app is independent -- open only the project you want to run. No shared workspace needed.

---

```markdown
## Testing

* Each app has its own test bundle. Run tests with ⌘U (Product → Test).
* Tests cover:
   * Pure logic (e.g., formatting, countdowns)
   * Persistence using an in-memory SwiftData ModelContainer (fast, disk-free)

Example:
```swift
import SwiftData

let config = ModelConfiguration(isStoredInMemoryOnly: true)
let container = try ModelContainer(for: PantryItem.self, configurations: config)
let ctx = ModelContext(container)

```markdown
if you see **"No such module 'XCTest'"**, set the file's **Target Membership** to the test bundle (not the app target).
