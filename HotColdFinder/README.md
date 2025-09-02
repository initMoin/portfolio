# HotColdFinder

Two-device “Hot / Cold” demo using **NearbyInteraction (UWB)** for ranging and **MultipeerConnectivity** for peer discovery + token exchange. Minimal SwiftUI UI, **MV (Model–View)** + services, and unit tests with **Swift Testing**.

- **Xcode:** 26 beta  
- **iOS:** 26.0+  
- **Swift:** 6.x  
- **Architecture:** Model–View (no view models) + services  

---

## Features (and Why)

### 1) Role selection (Target / Seeker)
- **What:** On launch, users choose to act as Target or Seeker.  
- **Why:** Clear entry point for demo; each role has a minimal, focused view.

### 2) Peer discovery + token exchange (MPCService)
- **What:** Uses MultipeerConnectivity to advertise/browse and exchange NI discovery tokens (`PeerMessage.discoveryToken`).  
- **Why:** MPC ensures local peer discovery without server infra; reliable for interview demos.

### 3) NearbyInteraction session (NIService)
- **What:** After token exchange, Seeker starts an `NISession` with peer token to get continuous ranging updates.  
- **Why:** Demonstrates Apple’s spatial APIs (distance, direction if hardware supports).

### 4) Hot/Warm/Cold feedback (HotColdMapper)
- **What:** Maps distance (meters) → bucket + normalized progress for UI.  
- **Why:** Translates raw UWB ranging into intuitive UX.

### 5) SeekerView feedback UI
- **What:** Large HOT/WARM/COLD label, colored progress bar, optional distance (rounded).  
- **Why:** Minimal but clear, recruiter-friendly demo of live ranging.

### 6) TargetView status
- **What:** Shows advertising status and connection state; no ranging.  
- **Why:** Keeps Target role simple, avoids UI clutter.

### 7) Accessibility & typography
- **What:** Monospaced text, large HOT/WARM/COLD labels, VoiceOver-friendly buttons.  
- **Why:** Improves inclusivity and readability.

### 8) Focused tests
- **What:** `HotColdMapperTests` validate thresholds + normalization; `PeerMessageCodableTests` verify encoding/decoding.  
- **Why:** Fast, reliable tests; demonstrate **Swift Testing** adoption.

### 9) Capability fallback (new)
- **What:** On devices without UWB support (e.g. iPads), SeekerView and TargetView show a clear banner explaining why ranging is unavailable.  
- **Why:** Ensures polished UX even on unsupported hardware.

---

## Architecture

- **Model–View only**: Views handle presentation; logic isolated in services.  
- **Services**:  
  - `MPCService` → peer discovery & token exchange.  
  - `NIService` → session lifecycle & ranging delegate.  
  - `HotColdMapper` → pure distance→bucket mapping.  
- **Models**: `AppRole` (Target/Seeker), `PeerMessage` (Codable tokens).  
- **Views**: `RolePickerView`, `TargetView`, `SeekerView`.

---

## Project Structure

```
HotColdFinder/
├─ HotColdFinder/
│  ├─ App/
│  │  ├─ HotColdFinderApp.swift
│  │  └─ RolePickerView.swift
│  ├─ Models/
│  │  ├─ AppRole.swift
│  │  └─ PeerMessage.swift
│  ├─ Services/
│  │  ├─ HotColdMapper.swift
│  │  ├─ MPCService.swift
│  │  └─ NIService.swift
│  ├─ Tests/
│  │  ├─ HotColdMapperTests.swift
│  │  └─ PeerMessageCodableTests.swift
│  ├─ Views/
│  │  ├─ CapabilityBanner.swift
│  │  ├─ SeekerView.swift
│  │  └─ TargetView.swift
│  └─ Assets/
│     └─ Assets.xcassets
├─ HotColdFinderTests/
│  └─ HotColdFinderTests.swift
└─ README.md
```

---

## Build & Run

1. Open `HotColdFinder/HotColdFinder.xcodeproj` in Xcode 26 (beta).  
2. Enable **Nearby Interaction** capability for the app target.  
3. Add **Info.plist** keys:  
   - `NSNearbyInteractionUsageDescription` = “Used to range nearby devices for the Hot/Cold game.”  
   - `NSLocalNetworkUsageDescription` = “Used to discover and connect to a nearby device for token exchange.”  
4. Run on **two UWB-capable devices** (Simulator won’t produce distance).  
5. On one device: choose **Target**. On the other: choose **Seeker**.  
6. When connected, Seeker shows HOT/WARM/COLD and progress. 

---

## Hardware Requirement

Nearby Interaction ranging requires **two UWB-equipped iPhones** (iPhone 11 or newer).  
- iPads and Macs currently do not support UWB.  
- Apple Watch (Series 6 and later) also supports UWB, but this demo app targets iPhone-to-iPhone pairing.  

On unsupported devices, a clear banner is shown in the UI explaining that ranging is unavailable.  
QA with two devices is **blocked** until a second UWB iPhone is available.

---

## Testing

- **Run all tests:** Product → Test (**⌘U**) in Xcode 26.  
- **Swift Testing suites included:**  
  - `HotColdMapperTests`: verify bucket thresholds and normalization.  
  - `PeerMessageCodableTests`: ensure round-trip JSON encoding/decoding works.  

---

## Future Ideas (Not in MVP)

- Visual radial “heat ring” instead of text-only UI.  
- Haptic feedback on “HOT” transitions.  
- Role auto-negotiation (first joiner = Target).  
- Multiple seekers per target (MPC supports this).  
- Optional camera overlays if AR integration desired.  

---

## Demo Script (60–90s)

1. Launch app on two devices → choose Target & Seeker.  
2. Point out MPC discovery: “Connected!” appears.  
3. Walk closer/further with Seeker → watch HOT/WARM/COLD change.  
4. Show optional distance readout (meters).  
5. Run tests (**⌘U**) in Xcode to prove logic correctness.  

---

## NearbyInteraction Integration

- Uses `NISession` + `NINearbyPeerConfiguration`.  
- Seeker calls `session(_:didUpdate:)` to get `NINearbyObject.distance`.  
- Target only provides its discovery token; does not perform ranging.  
- Requires UWB-capable iPhones (Simulator will not provide distances).  

---

## App Group Keys

_Not applicable_: HotColdFinder does not use persistence or shared defaults.  

---

## Widget Implementation

_Not applicable_: HotColdFinder has no widget extension.  

---

## Auto-Refresh

- Ranging updates are delivered continuously by NI once session is active.  
- No timers needed; UI updates automatically when `distanceMeters` changes.  

---

## Accessibility

- Large HOT/WARM/COLD text with high contrast.  
- Monospaced digits for distance (if shown).  
- Buttons labeled with SF Symbols (“target”, “location.north.circle”).  

---

## Troubleshooting

- **Widget not available:** Not supported for this app.  
- **No ranging data:** Ensure both devices are UWB-capable and NI capability is enabled in target.  
- **Peers don’t connect:** Check both devices are on same network or in direct P2P; `serviceType` ≤ 15 chars, lowercase.  

---

## License

MIT License (typical for portfolio samples). Replace with your preferred license.

