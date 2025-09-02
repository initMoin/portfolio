//
//  MPCService.swift
//  HotColdFinder
//
//  Created by Moinuddin Ahmad on 9/2/25.
//

import Foundation
import MultipeerConnectivity
import Combine
import UIKit

@MainActor
final class MPCService: NSObject, ObservableObject {
   static let shared = MPCService()
   
   @Published private(set) var connectedPeers: [MCPeerID] = []
   @Published private(set) var isAdvertising: Bool = false
   @Published private(set) var isBrowsing: Bool = false
   
   private let serviceType = "hcfinder"
   private let myPeer = MCPeerID(displayName: UIDevice.current.name)
   
   private var session: MCSession!
   private var advertiser: MCNearbyServiceAdvertiser?
   private var browser: MCNearbyServiceBrowser?
   
   // Callbacks
   var onConnected: ((MCPeerID) -> Void)?
   var onReceive: ((PeerMessage, MCPeerID) -> Void)?
   
   private override init() {
      super.init()
      
      session = MCSession(peer: myPeer, securityIdentity: nil, encryptionPreference: .required)
      session.delegate = self
   }
   
   func startAdvertising() {
      stop()
      advertiser = MCNearbyServiceAdvertiser(peer: myPeer,
                                             discoveryInfo: nil,
                                             serviceType: serviceType)
      
      advertiser?.delegate = self
      advertiser?.startAdvertisingPeer()
      isAdvertising = true
      isBrowsing = false
   }
   
   func startBrowsing() {
      stop()
      
      browser = MCNearbyServiceBrowser(peer: myPeer, serviceType: serviceType)
      browser?.delegate = self
      browser?.startBrowsingForPeers()
      isBrowsing = true
      isAdvertising = false
   }
   
   func stop() {
      advertiser?.stopAdvertisingPeer()
      browser?.stopBrowsingForPeers()
      advertiser = nil
      browser = nil
      isAdvertising = false
      isBrowsing = false
   }
   
   func send(_ message: PeerMessage, to peers: [MCPeerID]? = nil) {
      guard !session.connectedPeers.isEmpty else { return }
      
      do {
         let data = try JSONEncoder().encode(message)
         try session.send(data, toPeers: peers ?? session.connectedPeers, with: .reliable)
      } catch {
         print("MPC send error: \(error)")
      }
   }
}

extension MPCService: MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate, MCSessionDelegate {
   // Advertiser
   func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
      invitationHandler(true, session)
   }
   
   // Browser
   func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
      browser.invitePeer(peerID, to: session, withContext: nil, timeout: 10)
   }
   
   func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {}
   
   // Session
   func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
      switch state {
      case .connected:
         if !connectedPeers.contains(peerID) { connectedPeers.append(peerID) }
         onConnected?(peerID)
      case .notConnected:
         connectedPeers.removeAll { $0 == peerID }
      case .connecting:
         break
      @unknown default:
         break
      }
   }
   
   func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
      if let msg = try? JSONDecoder().decode(PeerMessage.self, from: data) {
         Task { @MainActor in self.onReceive?(msg, peerID) }
      }
   }
   
   func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
   func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {}
   func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: (any Error)?) {}
   
   #if !os(visionOS)
   func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) { certificateHandler(true) }
   #endif
}


