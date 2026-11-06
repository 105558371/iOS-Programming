//
//  ContentView.swift
//  Employee_Compensation
//
//  Created by SESEIU24007 on 6/11/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PayrollViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Validation & Testing Controls")) {
                    Button(action: {
                        viewModel.testValidationAndUpdates()
                    }) {
                        Label("Run Valid/Invalid Test Suite", systemImage: "shield.checkered")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                
                Section(header: Text("Employee Directory")) {
                    ForEach(viewModel.employees) { employee in
                        NavigationLink(destination: EmployeeDetailView(employee: employee, viewModel: viewModel)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(employee.employeeName).font(.headline)
                                    Text(employee.arrangementDescription).font(.subheadline).foregroundColor(.secondary)
                                }
                                Spacer()
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text(employee.status.rawValue)
                                        .font(.caption)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.green.opacity(0.2))
                                        .foregroundColor(.green)
                                        .cornerRadius(6)
                                    Text(String(format: "$%.2f/mo", employee.calculateMonthlyCompensation()))
                                        .font(.subheadline)
                                        .bold()
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                
                Section(header: Text("Payroll & Validation Logs")) {
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
            .navigationTitle("Employee Compensation")
        }
    }
}
#Preview {
    ContentView()
}
