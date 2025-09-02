# StepCounter

A tiny SwiftUI app + **WidgetKit** extension that demonstrates HealthKit step counting. The app shows today’s steps toward a goal with a refresh button; the widget provides an at-a-glance progress ring. A simulated store is included so the widget and previews work without HealthKit.

- **Xcode:** 26 beta  
- **iOS:** 18.0+  
- **Swift:** 6  
- **Architecture:** Model–View (no view models)

## Features (and Why)

### 1) `StepsService` abstraction
- **What:** Service that fetches today’s steps via `HealthKitStore` or simulated steps via `SimulatedHealthStore`.
- **Why:** Keeps logic testable and enables previews/tests without HealthKit entitlements.

### 2) App UI (`StepsView`)
- **What:** Shows today’s steps, percent toward an 8,000-step goal, and a refresh button.
- **Why:** Minimal, reactive SwiftUI with async service calls.

### 3) Widget extension (`StepCounterWidgetExtension`)
- **What:** Small/medium widget showing a progress ring and step count. Hourly timeline refresh.
- **Why:** Demonstrates WidgetKit timelines and integration with app services.

### 4) Simulator vs Device
- **What:** Uses a simulated store for the simulator/previews; use `HealthKitStore` on device.
- **Why:** Ensures consistent data in previews while supporting real HealthKit reads on device.

### 5) Optional App Group support
- **What:** App can cache daily steps in a shared container so the widget displays live HealthKit values.
- **Why:** Widgets can’t read HealthKit directly; App Groups bridge app ↔ widget.

### 6) Accessibility & typography
- **What:** ProgressView with labels, monospaced digits, Dynamic Type.
- **Why:** Shows attention to inclusivity and polish.

### 7) Focused tests
- **What:** `StepsServiceTests` validate simulated steps and percent mapping.
- **Why:** Fast, reliable, pure logic tests that don’t depend on HealthKit.

## Architecture

- **Model–View only:** Views read state; services fetch data.  
- **Services:** `HealthKitStore`, `SimulatedHealthStore`, `StepsService`.  
- **Trade-offs:** No persistence layer—intentional for MVP scope.

## Project Structure
```
StepCounter/
├─ StepCounterApp.swift
├─ Services/
│  ├─ HealthStore.swift
│  └─ StepsService.swift
├─ Views/
│  └─ StepsView.swift
├─ StepCounterWidgetExtension/
│  └─ StepsWidget.swift
└─ StepCounterTests/
   └─ StepsServiceTests.swift
```

## Build & Run

1. Open `StepCounter/StepCounter.xcodeproj` in Xcode 26 (beta).  
2. Enable **HealthKit** in the app target (Signing & Capabilities) and set `NSHealthShareUsageDescription`.  
3. Run on device (grant Health permissions) or simulator (uses simulated steps).  
4. Add the widget from the Home Screen; refresh is hourly by timeline policy.

## Testing

- Run all tests with **⌘U** using the `StepCounterTests` scheme.
- Covered:
  - Percent mapping and simulated step data (pure logic).
- Note:
  - Some environments may show `"No such module 'XCTest'"`. Tests compile and run correctly in Xcode 26 beta with a proper **Unit Testing Bundle** target and correct **Target Membership**.

## Future Ideas (Not in MVP)

- Live Activity via **ActivityKit** (Dynamic Island / Lock Screen).  
- Custom goals and simple weekly charts.  
- App Group defaults for real HealthKit → widget sync by the app.

## Demo Script (60–90s)

1. Launch app → show steps and progress bar.  
2. Tap **Refresh** to fetch again.  
3. Add widget to Home Screen → show progress ring.  
4. Explain simulator vs device behavior and optional App Group setup.  
5. Run tests (**⌘U**) to show passing simulated service tests.