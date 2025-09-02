//
//  TargetView.swift
//  HotColdFinder
//
//  Created by Moinuddin Ahmad on 9/2/25.
//

import SwiftUI
import NearbyInteraction

struct TargetView: View {
   @State private var isAdvertising = false
   @State private var connected = false
   
   private let mpc = MPCService.shared
   
   var body: some View {
      VStack(spacing: 16) {
         CapabilityBanner()
         
         Text("Target")
            .font(.title2).bold()
         
         Label(isAdvertising ? "Advertising..." : "Stopped", systemImage: isAdvertising ? "dot.radiowaves.left.and.right" : "stop")
            .foregroundStyle(isAdvertising ? .green : .secondary)
         
         Label(connected ? "Connected" : "Waiting for seeker...", systemImage: connected ? "checkmark.seal.fill" : "hourglass")
            .foregroundStyle(connected ? .green : .secondary)
         
         Button(isAdvertising ? "Stop" : "Start") {
            isAdvertising ? stop() : start()
         }
         .buttonStyle(.borderedProminent)
      }
      .padding()
      .onAppear {
         attachCallbacks()
      }
      .onDisappear {
         stop()
      }
   }
   
   private func attachCallbacks() {
      mpc.onConnected = { _ in connected = true }
      mpc.onReceive = { _, _ in }
   }
   
   private func start() {
      isAdvertising = true
      MPCService.shared.startAdvertising()
      
      let session = NISession()
      guard let token = session.discoveryToken,
            let data = try? NSKeyedArchiver.archivedData(withRootObject: token, requiringSecureCoding: true) else {
         return
      }
      
      MPCService.shared.send(.discoveryToken(data))
   }
   
   private func stop() {
      isAdvertising = false
      connected = false
      MPCService.shared.stop()
   }
}



