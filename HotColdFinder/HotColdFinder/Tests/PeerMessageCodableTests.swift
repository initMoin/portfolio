//
//  PeerMessageCodableTests.swift
//  HotColdFinder
//
//  Created by Moinuddin Ahmad on 9/2/25.
//

import Foundation
import Testing
@testable import HotColdFinder

@Suite("PeerMessage Codable")
struct PeerMessageCodableTests {
   @Test("Round-trip encode/decode")
   func roundTrip() throws {
      let token = Data([0xAA, 0xBB, 0xCC])
      let original = PeerMessage.discoveryToken(token)
      
      let encoded = try JSONEncoder().encode(original)
      let decoded = try JSONDecoder().decode(PeerMessage.self, from: encoded)
      
      #expect(decoded == original)
   }
}


