//
//  Employee.swift
//  Employee_Compensation
//
//  Created by SESEIU24007 on 6/11/26.
//


import Foundation
import Combine

class Employee: Identifiable, ObservableObject {
    let id: UUID
    let employeeName: String
    let hireDate: Date
    
    @Published private(set) var status: EmploymentStatus
    @Published private(set) var baseOrFixedSalary: Double
    
    init(id: UUID = UUID(), employeeName: String, hireDate: Date, status: EmploymentStatus = .active, baseOrFixedSalary: Double) {
        self.id = id
        self.employeeName = employeeName
        self.hireDate = hireDate
        self.status = status
        self.baseOrFixedSalary = max(0.0, baseOrFixedSalary)
    }
    
    func updateStatus(to newStatus: EmploymentStatus) {
        self.status = newStatus
    }
    
    func updateSalary(to newSalary: Double) throws {
        guard newSalary >= 0 else {
            throw PayrollError.invalidPayment("Salary/Base cannot be negative.")
        }
        self.baseOrFixedSalary = newSalary
    }
    
    // Polymorphic monthly compensation calculation
    func calculateMonthlyCompensation() -> Double {
        return baseOrFixedSalary
    }
    
    // Polymorphic compensation details breakdown
    func getCompensationDetails() -> [String] {
        return ["Base Pay: $\(String(format: "%.2f", baseOrFixedSalary))"]
    }
    
    var arrangementDescription: String {
        return "Standard Employee"
    }
}

// MARK: - Specialized Subclasses

class FullTimeEmployee: Employee {
    @Published private(set) var monthlyBonus: Double
    @Published private(set) var allowance: Double
    
    init(employeeName: String, hireDate: Date = Date(), status: EmploymentStatus = .active, monthlySalary: Double, monthlyBonus: Double, allowance: Double) {
        self.monthlyBonus = max(0.0, monthlyBonus)
        self.allowance = max(0.0, allowance)
        super.init(employeeName: employeeName, hireDate: hireDate, status: status, baseOrFixedSalary: monthlySalary)
    }
    
    func updateBonus(to newBonus: Double) throws {
        guard newBonus >= 0 else {
            throw PayrollError.invalidPayment("Bonus cannot be negative.")
        }
        self.monthlyBonus = newBonus
    }
    
    override func calculateMonthlyCompensation() -> Double {
        return baseOrFixedSalary + monthlyBonus + allowance
    }
    
    override func getCompensationDetails() -> [String] {
        return [
            "Base Salary: $\(String(format: "%.2f", baseOrFixedSalary))",
            "Performance Bonus: $\(String(format: "%.2f", monthlyBonus))",
            "Monthly Allowance: $\(String(format: "%.2f", allowance))"
        ]
    }
    
    override var arrangementDescription: String {
        return "Full-Time (Salary + Bonus)"
    }
}

class PartTimeEmployee: Employee {
    @Published private(set) var hoursWorked: Double
    let hourlyRate: Double
    
    init(employeeName: String, hireDate: Date = Date(), status: EmploymentStatus = .active, hoursWorked: Double, hourlyRate: Double) {
        self.hoursWorked = max(0.0, hoursWorked)
        self.hourlyRate = max(0.0, hourlyRate)
        super.init(employeeName: employeeName, hireDate: hireDate, status: status, baseOrFixedSalary: 0.0)
    }
    
    func recordHours(hours: Double) throws {
        guard hours >= 0 else {
            throw PayrollError.invalidHours("Working hours cannot be negative.")
        }
        guard hours <= 200 else {
            throw PayrollError.invalidHours("Monthly hours exceed maximum allowable limit (200 hrs).")
        }
        self.hoursWorked = hours
    }
    
    override func calculateMonthlyCompensation() -> Double {
        return hoursWorked * hourlyRate
    }
    
    override func getCompensationDetails() -> [String] {
        return [
            "Hourly Rate: $\(String(format: "%.2f", hourlyRate)) / hr",
            "Hours Worked: \(String(format: "%.1f", hoursWorked)) hrs",
            "Calculated Pay: $\(String(format: "%.2f", calculateMonthlyCompensation()))"
        ]
    }
    
    override var arrangementDescription: String {
        return "Part-Time (Hourly)"
    }
}

class ContractEmployee: Employee {
    @Published private(set) var milestoneCompleted: Bool
    let contractTotal: Double
    
    init(employeeName: String, hireDate: Date = Date(), status: EmploymentStatus = .active, contractTotal: Double, milestoneCompleted: Bool) {
        self.contractTotal = max(0.0, contractTotal)
        self.milestoneCompleted = milestoneCompleted
        super.init(employeeName: employeeName, hireDate: hireDate, status: status, baseOrFixedSalary: contractTotal)
    }
    
    func setMilestoneCompleted(_ completed: Bool) {
        self.milestoneCompleted = completed
    }
    
    override func calculateMonthlyCompensation() -> Double {
        return milestoneCompleted ? contractTotal : 0.0
    }
    
    override func getCompensationDetails() -> [String] {
        return [
            "Contract Total Value: $\(String(format: "%.2f", contractTotal))",
            "Milestone Approved: \(milestoneCompleted ? "Yes" : "No (Pending)")"
        ]
    }
    
    override var arrangementDescription: String {
        return "Contract-Based (Milestone)"
    }
}