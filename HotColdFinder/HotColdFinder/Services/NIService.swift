//
//  NIService.swift
//  HotColdFinder
//
//  Created by Moinuddin Ahmad on 9/2/25.
//

import Foundation
import NearbyInteraction
import Combine

@MainActor
final class NIService: NSObject, ObservableObject {
   static let shared = NIService()
   
   @Published private(set) var distanceMeters: Double?
   @Published private(set) var isRunning = false
   @Published private(set) var hasPeer = false
   
   private var session: NISession?
   
//   override init() {
//      super.init()
//   }
   
   func configure(with peerTokenData: Data) {
      guard let token = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NIDiscoveryToken.self, from: peerTokenData) else {
         print("NI: failed to unarchive peer token")
         return
      }
      
      let config = NINearbyPeerConfiguration(peerToken: token)
      startSession(config: config)
      hasPeer = true
   }
   
   private func startSession(config: NINearbyPeerConfiguration) {
      let sesh = NISession()
      sesh.delegate = self
      sesh.run(config)
      session = sesh
      isRunning = true
   }
   
   func invalidate() {
      session?.invalidate()
      session = nil
      isRunning = false
      hasPeer = false
      distanceMeters = nil
   }
   
   func ownDiscoveryTokenData() -> Data? {
      let sesh = session ?? NISession()
      guard let token = sesh.discoveryToken else { return nil }
      return try? NSKeyedArchiver.archivedData(withRootObject: token, requiringSecureCoding: true)
   }
}

extension NIService: NISessionDelegate {
   func session(_ session: NISession, didUpdate nearbyObjects: [NINearbyObject]) {
      guard let obj = nearbyObjects.first else { return }
      if let dist = obj.distance {
         distanceMeters = Double(dist)
      } else {
         distanceMeters = nil
      }
   }
   
   func sessionWasSuspended(_ session: NISession) {
      isRunning = false
   }
   
   func sessionSuspensionEnded(_ session: NISession) {
      isRunning = true
   }
   
   func session(_ session: NISession, didInvalidateWith error: any Error) {
      print("NIService invalidated: \(error)")
      invalidate()
   }
}

@MainActor
extension NIService {
   struct CapabilityReport {
      let isSupported: Bool
      let preciseDistance: Bool
      let direction: Bool
      let cameraAssist: Bool
   }
   
   static func capabilityReport() -> CapabilityReport {
      let supported = NISession.isSupported
      let cap = NISession.deviceCapabilities
      
      return CapabilityReport(
         isSupported: supported,
         preciseDistance: cap.supportsPreciseDistanceMeasurement,
         direction: cap.supportsDirectionMeasurement,
         cameraAssist: cap.supportsCameraAssistance
      )
   }
}


