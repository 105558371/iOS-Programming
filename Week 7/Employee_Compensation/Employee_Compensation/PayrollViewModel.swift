//
//  PayrollViewModel.swift
//  Employee_Compensation
//
//  Created by SESEIU24007 on 6/11/26.
//


import Foundation
import Combine

class PayrollViewModel: ObservableObject {
    @Published var employees: [Employee] = [
        FullTimeEmployee(employeeName: "Alice Smith", monthlySalary: 5000.0, monthlyBonus: 600.0, allowance: 300.0),
        PartTimeEmployee(employeeName: "Bob Johnson", hoursWorked: 85.5, hourlyRate: 25.0),
        ContractEmployee(employeeName: "Charlie Davis", contractTotal: 4000.0, milestoneCompleted: true),
        PartTimeEmployee(employeeName: "Diana Prince", hoursWorked: 0.0, hourlyRate: 30.0)
    ]
    
    @Published var operationLogs: [String] = []
    
    func testValidationAndUpdates() {
        operationLogs.insert("--- Running Payroll Validation Tests ---", at: 0)
        
        // 1. Test negative hours rejection on Part-Time employee
        if let partTimer = employees.first(where: { $0 is PartTimeEmployee }) as? PartTimeEmployee {
            do {
                try partTimer.recordHours(hours: -15.0)
                operationLogs.insert("✅ Success: Recorded hours.", at: 0)
            } catch {
                operationLogs.insert("❌ Rejected (Hours Guard): \(error.localizedDescription)", at: 0)
            }
        }
        
        // 2. Test negative salary update protection on Full-Time employee
        let fullTimer = employees[0]
        do {
            try fullTimer.updateSalary(to: -500.0)
            operationLogs.insert("✅ Success: Salary updated.", at: 0)
        } catch {
            operationLogs.insert("❌ Rejected (Salary Guard): \(error.localizedDescription)", at: 0)
        }
        
        // 3. Test valid update: updating full-timer's bonus
        if let ftEmployee = employees.first(where: { $0 is FullTimeEmployee }) as? FullTimeEmployee {
            do {
                try ftEmployee.updateBonus(to: 850.0)
                operationLogs.insert("✅ Valid Update: Bonus updated to $850.00 for \(ftEmployee.employeeName).", at: 0)
            } catch {
                operationLogs.insert("❌ Error: \(error.localizedDescription)", at: 0)
            }
        }
    }
}