//
//  RolePickerView.swift
//  HotColdFinder
//
//  Created by Moinuddin Ahmad on 9/2/25.
//

import SwiftUI

struct RolePickerView: View {
   @State private var selectedRole: AppRole? = nil
   
   var body: some View {
      NavigationStack {
         VStack(spacing: 24) {
            Text("HotColdFinder")
               .font(.largeTitle).bold()
            
            HStack(spacing: 20) {
               Button {
                  selectedRole = .target
               } label: {
                  Label("Target", systemImage: "target")
                     .frame(maxWidth: .infinity)
               }
               .buttonStyle(.borderedProminent)
               
               Button {
                  selectedRole = .seeker
               } label: {
                  Label("Seeker", systemImage: "location.north.circle")
                     .frame(maxWidth: .infinity)
               }
               .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)
            
            Text("Choose a role on each device.\nTarget stays discoverable. Seeker searches and ranges.")
               .font(.footnote)
               .multilineTextAlignment(.center)
               .foregroundStyle(.secondary)
            
            NavigationLink(value: selectedRole) { EmptyView() }
               .opacity(0)
         }
         .navigationDestination(item: $selectedRole) { role in
            switch role {
            case .target: TargetView()
            case .seeker: SeekerView()
            }
         }
      }
   }
}

