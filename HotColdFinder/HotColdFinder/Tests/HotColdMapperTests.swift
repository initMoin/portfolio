//
//  HotColdMapperTests.swift
//  HotColdFinder
//
//  Created by Moinuddin Ahmad on 9/2/25.
//

import Testing
@testable import HotColdFinder

@Suite("HotColdMapper")
struct HotColdMapperTests {
   @Test("Buckets: cold/warm/hot thresholds")
   func testBuckets() {
      let mapper = HotColdMapper(warmThreshold: 3.0, hotThreshold: 1.5, maxDistanceForNormalize: 6.0)
      #expect(mapper.map(distanceMeters: 5.5).bucket == .cold)
      #expect(mapper.map(distanceMeters: 2.0).bucket == .warm)
      #expect(mapper.map(distanceMeters: 0.9).bucket == .hot)
   }
   
   @Test("Normalization 0→1, max→0")
   func testNormalization() {
      let mapper = HotColdMapper(maxDistanceForNormalize: 6.0)
      #expect(abs(mapper.map(distanceMeters: 0).normalized - 1) < 0.001)
      #expect(abs(mapper.map(distanceMeters: 6).normalized - 0) < 0.001)
      #expect(abs(mapper.map(distanceMeters: 3).normalized - 0.5) < 0.001)
   }
}


