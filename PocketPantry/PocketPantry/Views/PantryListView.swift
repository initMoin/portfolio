//
//  PantryListView.swift
//  Pocket Pantry
//
//  Created by Moinuddin Ahmad on 8/19/25.
//

import SwiftUI
import SwiftData

struct PantryListView: View {
   @Environment(\.modelContext) private var context
   @Query(sort: [SortDescriptor(\PantryItem.createdAt, order: .reverse)])
   private var items: [PantryItem]
   
   @State private var showingAdd = false
   
   var body: some View {
      NavigationStack {
         List {
            if !expiringSoon(items).isEmpty {
               Section("Expiring Soon") {
                  ForEach(expiringSoon(items)) { item in
                     PantryRow(item: item, showExpiryBadge: true)
                  }
               }
            }
            
            if !items.isEmpty {
               Section("All Items") {
                  ForEach(items) { item in
                     PantryRow(item: item, showExpiryBadge: true)
                        .swipeActions {
                           Button(role: .destructive) {
                              context.delete(item)
                              try? context.save()
                           } label: {
                              Label("Delete", systemImage: "trash")
                           }
                        }
                  }
               }
            } else {
               HStack(alignment: .center) {
                  Spacer()
                  
                  VStack(alignment: .center) {
                     Text("No Items Added")
                     Text("Add items by tapping on the plus button")
                  }
                  .italic()
                  .colorMultiply(.gray.opacity(0.7))
                  
                  Spacer()
               }
            }
         }
         .navigationTitle("Pocket Pantry")
         .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
               Button {
                  showingAdd = true
               } label: {
                  Image(systemName: "plus")
               }
            }
         }
         .sheet(isPresented: $showingAdd) {
            AddEditItemView()
         }
         #if DEBUG
         .toolbar {
            ToolbarItem(placement: .bottomBar) {
               Button("Assign Default Expiry") {
                  assignDefaultExpiry(days: 7)
               }
            }
         }
         #endif
      }
   }
   
   private func expiringSoon(_ list: [PantryItem]) -> [PantryItem] {
      list
         .compactMap { item in
            guard let days = PantryItem.daysUntilExpiry(from: item.expiryDate) else { return nil }
            return days <= 7 ? item : nil
         }
         .sorted {
            ($0.expiryDate ?? .distantFuture) < ($1.expiryDate ?? .distantFuture)
         }
   }
   
   private func assignDefaultExpiry(days: Int) {
      let target = Calendar.current.date(byAdding: .day, value: days, to: .now)
      
      for item in items where item.expiryDate == nil {
         item.expiryDate = target
      }
      
      try? context.save()
   }
}

private struct PantryRow: View {
   let item: PantryItem
   var showExpiryBadge: Bool = false
   
   var body: some View {
      HStack {
         Text(item.name).font(.body)
         Spacer()
         
         if showExpiryBadge, let days = PantryItem.daysUntilExpiry(from: item.expiryDate) {
            Text(days >= 0 ? "D-\(days)" : "Expired")
               .font(.caption)
               .foregroundStyle(days < 0 ? .red : .secondary)
               .padding(.trailing, 8)
         }
         
         Text("x\(item.quantity)").monospacedDigit()
      }
      .accessibilityElement(children: .combine)
      .accessibilityLabel("\(item.name), quantity \(item.quantity)")
   }
}
