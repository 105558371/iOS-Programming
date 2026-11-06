//
//  ContentView.swift
//  Fitness_Membership
//
//  Created by SESEIU24007 on 6/11/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FitnessCenterViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Validation & Testing Controls")) {
                    Button(action: {
                        viewModel.testInvalidOperations()
                    }) {
                        Label("Run Valid/Invalid Test Suite", systemImage: "exclamationmark.shield.fill")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                
                Section(header: Text("Active Memberships")) {
                    ForEach(viewModel.memberships) { membership in
                        NavigationLink(destination: MembershipDetailView(membership: membership, viewModel: viewModel)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(membership.memberName).font(.headline)
                                    Text(membership.planTypeDescription).font(.subheadline).foregroundColor(.secondary)
                                }
                                Spacer()
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text(membership.status.rawValue)
                                        .font(.caption)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(membership.status == .active ? Color.green.opacity(0.2) : Color.orange.opacity(0.2))
                                        .foregroundColor(membership.status == .active ? .green : .orange)
                                        .cornerRadius(6)
                                    Text("$\(membership.calculateCharges(), specifier: "%.2f")/mo")
                                        .font(.subheadline)
                                        .bold()
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                
                Section(header: Text("System & Validation Logs")) {
                    if viewModel.operationLogs.isEmpty {
                        Text("No operations performed yet. Click the test button above.")
                            .foregroundColor(.secondary)
                            .italic()
                    } else {
                        ForEach(viewModel.operationLogs, id: \.self) { log in
                            Text(log)
                                .font(.caption)
                                .fontDesign(.monospaced)
                        }
                    }
                }
            }
            .navigationTitle("Fitness Center Management")
        }
    }
}

#Preview {
    ContentView()
}
