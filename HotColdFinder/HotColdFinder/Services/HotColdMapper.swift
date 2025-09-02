//
//  HotColdMapper.swift
//  HotColdFinder
//
//  Created by Moinuddin Ahmad on 9/2/25.
//

import Foundation

struct HotColdMapper {
   struct Output: Equatable {
      let bucket: Bucket
      let normalized: Double // 0..1, where 1 is hottest/closest
   }
   
   enum Bucket: String, Equatable {
      case cold, warm, hot
   }
   
   // Tunable thresholds (meters)
   var warmThreshold: Double = 3.0
   var hotThreshold: Double = 1.5
   var maxDistanceForNormalize: Double = 6.0
   
   func map(distanceMeters distance: Double?) -> Output {
      guard let distance, distance.isFinite, distance >= 0 else {
         return .init(bucket: .cold, normalized: 0)
      }
      
      let bucket: Bucket
      
      switch distance {
      case ..<hotThreshold:  bucket = .hot
      case ..<warmThreshold: bucket = .warm
      default:               bucket = .cold
      }
      
      // Normalize so that 0m → 1.0 and ≥ maxDistance → ~0.0
      let clamped = max(0, min(distance, maxDistanceForNormalize))
      let normalized = 1.0 - (clamped / maxDistanceForNormalize)
      
      return .init(bucket: bucket, normalized: normalized)
   }
}

