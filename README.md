# iOS 26 Micro-Apps Portfolio

A collection of four small, surgical iOS apps built with **Xcode 26 (beta)**, **Swift 6**, **SwiftUI**, and modern Apple APIs. Each app demonstrates targeted features for interviews and showcases clean code, MV architecture, unit tests, and accessibility basics.

## Apps

### 1. [PocketPantry](PocketPantry/README.md)
- **Frameworks:** SwiftData  
- **Features:** `@Model` CRUD, `@Query` list with “expiring soon,” v1 → v1.1 migration via optional `expiryDate`, in-memory SwiftData tests.  
- **Focus:** Persistence, queries, safe migrations.

### 2. [StepCounter](StepCounter/README.md)
- **Frameworks:** HealthKit, WidgetKit, (optional) ActivityKit  
- **Features:** App UI with steps and progress; widget with hourly timeline; simulated store for previews/simulator; unit tests for `StepsService`.  
- **Focus:** HealthKit integration, widgets.

### 3. HotColdFinder (Coming Soon)
- **Frameworks:** NearbyInteraction, MultipeerConnectivity  
- **Features:** Seeker/Target with token exchange; distance → heat mapping.  
- **Focus:** Spatial computing APIs, responsive feedback.

### 4. DailyQuoteFetcher (Coming Soon)
- **Frameworks:** BackgroundTasks, UserNotifications  
- **Features:** Daily BG refresh pulls a quote and posts a notification; minimal foreground UI.  
- **Focus:** Background execution, notification delivery.

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
├─ HotColdFinder/         # placeholder
├─ DailyQuoteFetcher/     # placeholder
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
- 🚧 HotColdFinder — planned  
- 🚧 DailyQuoteFetcher — planned

## License

MIT — open and permissive for educational/demo use.
