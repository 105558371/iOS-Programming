//
//  EmployeeDetailView.swift
//  Employee_Compensation
//
//  Created by SESEIU24007 on 6/11/26.
//

import SwiftUI

struct EmployeeDetailView: View {
    @ObservedObject var employee: Employee
    @ObservedObject var viewModel: PayrollViewModel
    
    var body: some View {
        Form {
            Section(header: Text("Employee Summary")) {
                LabeledContent("Employee Name", value: employee.employeeName)
                LabeledContent("Arrangement", value: employee.arrangementDescription)
                LabeledContent("Employment Status", value: employee.status.rawValue)
                LabeledContent("Monthly Payable", value: String(format: "$%.2f", employee.calculateMonthlyCompensation()))
                LabeledContent("Hire Date", value: employee.hireDate.formatted(date: .abbreviated, time: .omitted))
            }
            
            Section(header: Text("Compensation Details Breakdown")) {
                ForEach(employee.getCompensationDetails(), id: \.self) { detail in
                    HStack {
                        Image(systemName: "dollarsign.circle.fill").foregroundColor(.blue)
                        Text(detail)
                    }
                }
            }
        }
        .navigationTitle("Compensation Profile")
    }
}
