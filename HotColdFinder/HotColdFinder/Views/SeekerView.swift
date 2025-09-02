//
//  SeekerView.swift
//  HotColdFinder
//
//  Created by Moinuddin Ahmad on 9/2/25.
//

import SwiftUI
import NearbyInteraction

struct SeekerView: View {
   @ObservedObject private var ni = NIService.shared
   @ObservedObject private var mpc = MPCService.shared
   
   @State private var isBrowsing = false
   @State private var mapper = HotColdMapper()
   
   private var connected: Bool { !mpc.connectedPeers.isEmpty }
   private var mapped: HotColdMapper.Output { mapper.map(distanceMeters: ni.distanceMeters) }
   
   var body: some View {
      let caps = NIService.capabilityReport()
      
      if !caps.preciseDistance {
         VStack(spacing: 8) {
            Text("This device can't measure precise distance to peers.")
               .font(.callout).multilineTextAlignment(.center)
            Text("Use 2 UWB-enabled iPhones (iPhone 11 or newer).")
               .font(.caption).foregroundStyle(.secondary).multilineTextAlignment(.center)
         }
         .padding()
      }
      
      VStack(spacing: 16) {
         CapabilityBanner()
         
         Text("Seeker")
            .font(.title2).bold()
         
         Label(isBrowsing ? "Browsing..." : "Stopped", systemImage: isBrowsing ? "magnifyingglass.circle" : "stop")
            .foregroundStyle(isBrowsing ? .blue : .secondary)
         
         Label(connected ? "Connected" : "Looking for target...", systemImage: connected ? "checkmark.seal.fill" : "hourglass")
            .foregroundStyle(connected ? .green : .secondary)
         
         ProgressView(value: mapped.normalized)
            .tint(mapped.bucket == .hot ? .red : mapped.bucket == .warm ? .orange : .blue)
            .padding(.horizontal)
         
         Text(mapped.bucket == .hot ? "HOT" : mapped.bucket == .warm ? "WARM" : "COLD")
            .font(.largeTitle).monospaced()
         
         if let dist = ni.distanceMeters {
            Text(String(format: "%.2f m", dist))
               .font(.caption).foregroundStyle(.secondary)
         }
         
         Button(isBrowsing ? "Stop" : "Start") {
            isBrowsing ? stop() : start()
         }
         .buttonStyle(.borderedProminent)
      }
      .padding()
      .onAppear { attachCallbacks() }
      .onDisappear { stop() }
   }
   
   private func attachCallbacks() {
      mpc.onConnected = { _ in }
      mpc.onReceive = { msg, _ in
         switch msg {
         case .discoveryToken(let data):
            NIService.shared.configure(with: data)
         case .debug:
            break
         }
      }
   }
   
   private func start() {
      isBrowsing = true
      mpc.startBrowsing()
      
      let session = NISession()
      if let token = session.discoveryToken,
         let data = try? NSKeyedArchiver.archivedData(withRootObject: token, requiringSecureCoding: true) {
         mpc.send(.discoveryToken(data))
      }
   }
   
   private func stop() {
      isBrowsing = false
      NIService.shared.invalidate()
      mpc.stop()
   }
}


