//
//  PeerMessage.swift
//  HotColdFinder
//
//  Created by Moinuddin Ahmad on 9/2/25.
//

import Foundation

enum PeerMessage: Equatable, Sendable {
   case discoveryToken(Data)
   case debug(String)
}

extension PeerMessage: Codable {
   private enum CodingKeys: String, CodingKey { case kind, token, message }
   private enum Kind: String, Codable { case discoveryToken, debug }
   
   nonisolated init(from decoder: Decoder) throws {
      let c = try decoder.container(keyedBy: CodingKeys.self)
      switch try c.decode(Kind.self, forKey: .kind) {
      case .discoveryToken:
         let data = try c.decode(Data.self, forKey: .token)
         self = .discoveryToken(data)
      case .debug:
         let msg = try c.decode(String.self, forKey: .message)
         self = .debug(msg)
      }
   }
   
   nonisolated func encode(to encoder: Encoder) throws {
      var c = encoder.container(keyedBy: CodingKeys.self)
      switch self {
      case .discoveryToken(let data):
         try c.encode(Kind.discoveryToken, forKey: .kind)
         try c.encode(data, forKey: .token)
      case .debug(let msg):
         try c.encode(Kind.debug, forKey: .kind)
         try c.encode(msg, forKey: .message)
      }
   }
}
