//
//  AddEditItemView.swift
//  Pocket Pantry
//
//  Created by Moinuddin Ahmad on 8/20/25.
//

import SwiftUI
import SwiftData

struct AddEditItemView: View {
   @Environment(\.modelContext) private var context
   @Environment(\.dismiss) private var dismiss
   
   @State private var name = ""
   @State private var quantity = 1
   
   @State private var hasExpiry = false
   @State private var expiry = Calendar.current.date(byAdding: .day, value: 3, to: .now)!
   
   var body: some View {
      NavigationStack {
         Form {
            TextField("Name", text: $name)
               .textInputAutocapitalization(.words)
            Stepper(value: $quantity, in: 1...99) {
               Text("Quantity: \(quantity)")
            }
            
            Section {
               Toggle("Has expiry date", isOn: $hasExpiry)
               
               if hasExpiry {
                  DatePicker("Expiry", selection: $expiry, displayedComponents: .date)
               }
            }
         }
         .navigationTitle("Add Item")
         .toolbar {
            ToolbarItem(placement: .cancellationAction) {
               Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
               Button("Save") {
                  let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
                  guard !trimmed.isEmpty else { return }
                  let item = PantryItem(
                     name: trimmed,
                     quantity: quantity,
                     expiryDate: hasExpiry ? expiry : nil
                  )
                  context.insert(item)
                  try? context.save()
                  dismiss()
               }
               .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
         }
      }
   }
}
