//
//  AppRole.swift
//  HotColdFinder
//
//  Created by Moinuddin Ahmad on 9/2/25.
//

import Foundation

enum AppRole: String, Identifiable, Codable, Hashable {
   case target
   case seeker
   
   var id: String { rawValue }
}
