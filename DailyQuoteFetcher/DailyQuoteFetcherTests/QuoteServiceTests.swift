//
//  QuoteServiceTests.swift
//  DailyQuoteFetcher
//
//  Created by Moinuddin Ahmad on 9/2/25.
//

import Testing
import Foundation
@testable import DailyQuoteFetcher

struct QuoteServiceTests {
   @Test
   func decodesQuotableShape() async throws {
      
   }
}

// MARK: - Test helper

final class MockURLProtocol: URLProtocol {
   static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
   
   override class func canInit(with request: URLRequest) -> Bool { true }
   override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
   
   override func startLoading() {
      guard let handler = MockURLProtocol.requestHandler else { return }
      
      do {
         let (response, data) = try handler(request)
         client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
         client?.urlProtocol(self, didLoad: data)
         client?.urlProtocolDidFinishLoading(self)
      } catch {
         client?.urlProtocol(self, didFailWithError: error)
      }
   }
   
   override func stopLoading() {}
}


