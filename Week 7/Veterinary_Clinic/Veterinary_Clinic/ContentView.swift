//
//  ContentView.swift
//  Veterinary_Clinic
//
//  Created by SESEIU24007 on 6/11/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ClinicViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Validation & Testing Controls")) {
                    Button(action: {
                        viewModel.testValidationAndRejections()
                    }) {
                        Label("Run Validation Test Suite", systemImage: "cross.case.fill")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.indigo)
                            .cornerRadius(10)
                    }
                }
                
                Section(header: Text("Clinic Appointments Directory")) {
                    ForEach(viewModel.appointments) { appointment in
                        NavigationLink(destination: AppointmentDetailView(appointment: appointment, viewModel: viewModel)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(appointment.petName).font(.headline)
                                    Text("Owner: \(appointment.ownerName)").font(.subheadline).foregroundColor(.secondary)
                                    Text(appointment.serviceTypeDescription).font(.caption).foregroundColor(.blue)
                                }
                                Spacer()
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text(appointment.status.rawValue)
                                        .font(.caption)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(statusColor(for: appointment.status).opacity(0.2))
                                        .foregroundColor(statusColor(for: appointment.status))
                                        .cornerRadius(6)
                                    Text(String(format: "$%.2f", appointment.calculateCharges()))
                                        .font(.subheadline)
                                        .bold()
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                
                Section(header: Text("System & Validation Audit Logs")) {
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
            .navigationTitle("Vet Clinic Booking")
        }
    }
    
    func statusColor(for status: AppointmentStatus) -> Color {
        switch status {
        case .scheduled: return .green
        case .completed: return .blue
        case .cancelled: return .orange
        }
    }
}

#Preview {
    ContentView()
}
