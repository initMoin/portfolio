# StepCounter

A tiny SwiftUI app + **WidgetKit** extension that demonstrates HealthKit integration with a simple steps tracker. The app shows today’s steps toward a goal, with a refresh button, while the widget provides an at-a-glance progress ring on the Home Screen. A simulated store is included so the widget and previews work without HealthKit.

- **Xcode:** 26 beta  
- **iOS:** 18.0+  
- **Swift:** 6  
- **Architecture:** Model–View (no view models)

---

## Features (and Why)

### 1) `StepsService` abstraction
- **What:** Service that fetches today’s steps via `HealthKitStore` or returns simulated steps via `SimulatedHealthStore`.
- **Why:** Keeps logic testable and allows previews/tests to run without HealthKit entitlements.

### 2) App UI (`StepsView`)
- **What:** Displays today’s steps, percent toward a fixed goal (8,000), and a refresh button.
- **Why:** Simple, reactive UI demonstrating SwiftUI with async service calls.

### 3) Widget extension (`StepCounterWidgetExtension`)
- **What:** Small/medium widget showing progress ring and step count. Updates hourly via a timeline.
- **Why:** Demonstrates WidgetKit timelines and integration with app services.

### 4) Simulator vs Device
- **What:** Uses `#if targetEnvironment(simulator)` to swap in the simulated store.
- **Why:** Ensures widget previews and simulator builds always show data, while device builds can read HealthKit.

### 5) Optional App Group support
- **What:** If added, the app can persist daily steps into a shared container so the widget displays live HealthKit values.
- **Why:** Widgets can’t query HealthKit directly; App Groups bridge app ↔ widget.

### 6) Accessibility & typography
- **What:** ProgressView with labels, monospaced digits, Dynamic Type.
- **Why:** Shows awareness of inclusivity & polish.

### 7) Focused tests
- **What:** `StepsServiceTests` validate simulated steps and percent mapping.
- **Why:** Fast, reliable, pure logic tests that don’t depend on HealthKit.

---

## Architecture

- **Model–View only**: Views read state, services fetch data.  
- **Services**: `HealthKitStore`, `SimulatedHealthStore`, `StepsService`.  
- **Trade-offs**: No persistence layer — intentional for MVP scope.

---

## Project Structure

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

---

## Build & Run

1. Open `StepCounter/StepCounter.xcodeproj` in Xcode 26 (beta).  
2. Enable the **HealthKit** capability in the app target.  
3. On device: grant Health permissions to read steps.  
4. On simulator: simulated steps (5,234) are displayed automatically.  
5. Add the widget from the Home Screen; it updates hourly.  

---

## Testing

- **Run all tests:** select the `StepCounterTests` scheme → **⌘U**.

### What’s covered
- `StepsServiceTests`: percent mapping and simulated step data.  

> ⚠️ Note: `"No such module 'XCTest'"` may appear outside Xcode 26 beta.  
> Tests compile and run correctly in the proper environment.

---

## Future Ideas (Not in MVP)

- Live Activity via **ActivityKit** to show step progress in the Dynamic Island.  
- Custom goals with user input.  
- Weekly step history with simple charts.  
- Shared App Group defaults for real HealthKit step syncing to the widget.  

---

## Demo Script (60–90s)

1. Launch app: show simulated (or real) steps + progress bar.  
2. Tap **Refresh** to re-fetch values.  
3. Add widget to Home Screen: show at-a-glance progress ring.  
4. Explain simulator vs device behavior.  
5. (Optional) Mention App Group support for real HealthKit → widget sync.  
6. Run tests (**⌘U**) to show simulated service tests passing.  