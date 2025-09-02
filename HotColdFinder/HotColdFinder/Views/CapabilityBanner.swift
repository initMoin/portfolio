//
//  CapabilityBanner.swift
//  HotColdFinder
//
//  Created by Moinuddin Ahmad on 9/2/25.
//

import SwiftUI

struct CapabilityBanner: View {
   let caps = NIService.capabilityReport()
   
   var body: some View {
      if !caps.preciseDistance {
         VStack(spacing: 8) {
            Label("Nearby Interaction Unsupported", systemImage: "exclamationmark.triangle.fill")
               .font(.headline)
               .foregroundStyle(.orange)
            
            Text("This device can't measure precise distances.")
               .font(.callout)
               .multilineTextAlignment(.center)
            
            Text("Use 2 UWB-enabled iPhones (iPhone 11 or newer) or Apple Watch (Series 6+).")
               .font(.caption)
               .foregroundStyle(.secondary)
               .multilineTextAlignment(.center)
         }
         .padding()
         .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
         .padding(.horizontal)
      }
   }
}


