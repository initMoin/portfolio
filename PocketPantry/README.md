# PocketPantry

A SwiftData-powered inventory tracker demonstrating **CRUD with @Model**,  
queries with `@Query`, and **schema evolution (migration)**.

- **Xcode:** 26 beta  
- **iOS:** 18.0+  
- **Swift:** 6  
- **Architecture:** Model–View (no view models)

---

## Features (and Why)

### 1) PantryItem model
- **What:** `@Model PantryItem { name, quantity, createdAt }`.
- **Why:** Minimal schema to demo SwiftData persistence.

### 2) CRUD operations
- **What:** Insert, update, delete items using `ModelContext`.
- **Why:** Covers core persistence functionality.

### 3) SwiftData queries
- **What:** `@Query` to fetch and sort pantry items; filter “expiring soon”.
- **Why:** Demonstrates modern SwiftData query system.

### 4) Migration demo
- **What:** v1.0 schema → v1.1 adds optional `expiryDate`.
- **Why:** Shows off SwiftData auto-migration.

### 5) In-memory unit tests
- **What:** `SwiftDataInMemoryTests` with in-memory `ModelContainer`.
- **Why:** Verifies CRUD logic without persisting to disk.

### 6) Accessibility & polish
- **What:** Semantic labels and Dynamic Type support.
- **Why:** Ensures inclusivity and baseline professional quality.

---

## Architecture

- **Model–View only:** Views bind to SwiftData models directly.  
- **Services:** Minimal helpers around SwiftData container.  
- **Trade-offs:** No networking/cloud sync in MVP.

---

## Project Structure
```
PocketPantry/
├─ PocketPantryApp.swift
├─ Models/
│  └─ PantryItem.swift
├─ Views/
│  └─ PantryListView.swift
├─ Services/
│  └─ PersistenceHelpers.swift
├─ Tests/
│  └─ SwiftDataInMemoryTests.swift
└─ Assets/
```

---

## Build & Run

1. Open `PocketPantry/PocketPantry.xcodeproj` in Xcode 26 (beta).  
2. Run on device or simulator.  
3. Use the “Add Item” button to insert test data.  

---

## Migration Demo (v1 → v1.1)

- **v1.0:** PantryItem = `{ name, quantity, createdAt }`  
- **v1.1:** Added optional `expiryDate`.  
- Demonstrates SwiftData **auto-migration**.  

---

## Testing

- Run all tests with **⌘U** using the `PocketPantryTests` scheme.  
- Coverage:  
  - Insert and fetch from in-memory store.  
  - Sort by `createdAt`.  
- Note:  
  - Some environments may show `"No such module 'XCTest'"`. Tests compile and run correctly in Xcode 26 beta with a proper **Unit Testing Bundle** target.

---

## Future Ideas (Not in MVP)

- iCloud sync with SwiftData + CloudKit.  
- Tagging or categories for items.  
- Notifications for expiring items.

---

## Demo Script (60–90s)

1. Launch app → add a new pantry item (e.g., “Milk”).  
2. Show list updating in real time.  
3. Update item quantity → persists immediately.  
4. Delete item → disappears instantly.  
5. Explain migration demo (added `expiryDate`).  
6. Mention SwiftData unit tests verifying CRUD.

---

## License

MIT — lightweight demo for educational and portfolio purposes.