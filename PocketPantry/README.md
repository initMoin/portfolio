# Pocket Pantry

A tiny SwiftUI + **SwiftData** app that demonstrates modern persistence with **MV (Model–View)**, CRUD, and a safe **auto-migration** from v1 → v1.1. The UI is deliberately small (1 list screen + add sheet) to keep focus on data modeling, queries, and testing.

- **Xcode:** 26 beta  
- **iOS:** 18.0+  
- **Swift:** 6  
- **Architecture:** Model–View (no view models)

---

## Features (and Why)

### 1) `@Model PantryItem` with CRUD
- **What:** Minimal `PantryItem` using SwiftData `@Model` with `name`, `quantity`, `createdAt` (v1), and optional `expiryDate` (v1.1).
- **Why:** Demonstrates modern Apple-first persistence with concise code and automatic schema handling.

### 2) `@Query` list (sorted by `createdAt`)
- **What:** Main screen (`PantryListView`) uses `@Query` to fetch items sorted newest-first.
- **Why:** `@Query` updates the UI reactively when data changes.

### 3) Add sheet with validation
- **What:** `AddEditItemView` validates input (non-empty name, bounded quantity).
- **Why:** Ensures clean data and user-friendly input.

### 4) Swipe-to-delete with `modelContext`
- **What:** Standard list deletion with explicit save.
- **Why:** Matches Apple patterns; avoids hidden auto-saves.

### 5) v1.1 auto-migration (`expiryDate`)
- **What:** Schema evolution via optional `expiryDate`.
- **Why:** Demonstrates safe, low-risk migrations.

### 6) “Expiring Soon” section + D-day badge
- **What:** Items expiring within 7 days show in a separate section with countdown.
- **Why:** Adds user-centric logic atop persisted data.

### 7) Accessibility & typography
- **What:** Combined labels, monospaced digits, Dynamic Type.
- **Why:** Shows awareness of inclusivity & polish.

### 8) Focused tests
- **What:**  
  - `FormattingTests` (date countdown logic).  
  - `SwiftDataInMemoryTests` (CRUD in memory-only store).  
- **Why:** Fast, reliable tests with no disk I/O.

### 9) Optional debug migration helper
- **What:** Temporary DEBUG-only button to assign expiry defaults.  
- **Why:** Safe one-off backfill; code is removed after running.

---

## Architecture

- **Model–View only**: Views read with `@Query`, write with `@Environment(\.modelContext)`.  
- **Helpers**: Small pure functions for testability.  
- **Trade-offs**: No repository abstraction, no background sync — intentional for MVP scope.

---

## Data Model

```swift
@Model
final class PantryItem {
    var name: String
    var quantity: Int
    var createdAt: Date
    var expiryDate: Date? // v1.1 optional field
}
```
---

## Project Structure

PocketPantry/
├─ PocketPantryApp.swift
├─ Models/
│  └─ PantryItem.swift
├─ Views/
│  ├─ PantryListView.swift
│  └─ AddEditItemView.swift
├─ Utilities/
│  └─ Formatting.swift
└─ PocketPantryTests/
   ├─ FormattingTests.swift
   └─ SwiftDataInMemoryTests.swift

---

## Build & Run

1. Open `PocketPantry/PocketPantry.xcodeproj` in Xcode 26 (beta).
2. Ensure the target’s deployment is iOS **18.0** and Swift **6** (Build Settings → Swift Language Version = Latest / 6).
3. Select an iPhone simulator and **Run**.
4. Add a couple of items via **+**, delete via swipe; relaunch to confirm persistence.

---

## Migration Demo (v1 → v1.1)

**Goal:** Demonstrate a safe SwiftData auto‑migration by adding an optional field.

1) **v1** (baseline)
   - `PantryItem` has: `name`, `quantity`, `createdAt`.
   - Build & run; add a few items.
   - **Do not delete the app** between v1 and v1.1.

2) **v1.1** (migrated)
   - Add `var expiryDate: Date?` to `PantryItem` and update initializers/UI.
   - Build & run on the **same** simulator/device.
   - Existing rows are preserved with `expiryDate = nil`.
   - New items can set an expiry; items expiring in ≤ 7 days appear in “Expiring Soon”.

> If you delete the app or reset the simulator between runs, you restart with a clean store (no visible migration), which is expected.

---

## Testing

- **Run all tests:** select the `PocketPantryTests` scheme → **⌘U**.

### What’s covered
- `FormattingTests`: pure date/countdown logic (fast, no I/O).
- `SwiftDataInMemoryTests`: CRUD using an **in‑memory** `ModelContainer`:
  ```swift
  let config = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try ModelContainer(for: PantryItem.self, configurations: config)
  let ctx = ModelContext(container)
  ```
---

## Future Ideas (Not in MVP)

- Inline editing in the list or a dedicated edit sheet
- Search / categories with a simple `@Query` predicate
- Local notifications for upcoming expiry
- iCloud sync (CloudKit + SwiftData)
- Basic analytics (e.g., items added per week)

---

## Demo Script (60–90s)

1. Launch, tap **+**, add two items (make one expire within 7 days).
2. Point out **Expiring Soon** and the **D‑day** badge.
3. Swipe to delete an item; relaunch to show persistence.
4. Briefly explain v1 → v1.1 migration (added optional `expiryDate`).
5. Run tests (**⌘U**) to show green checks.