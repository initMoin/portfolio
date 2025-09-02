//
//  Pocket_PantryApp.swift
//  Pocket Pantry
//
//  Created by Moinuddin Ahmad on 8/19/25.
//

import SwiftUI
import SwiftData

@main
struct Pocket_PantryApp: App {
    
    var body: some Scene {
        WindowGroup {
            PantryListView()
        }
        .modelContainer(for: [PantryItem.self], isUndoEnabled: false)
    }
}
