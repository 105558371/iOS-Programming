//
//  EmploymentStatus.swift
//  Employee_Compensation
//
//  Created by SESEIU24007 on 6/11/26.
//


import Foundation

enum EmploymentStatus: String, Codable, CaseIterable {
    case active = "Active"
    case onLeave = "On Leave"
    case terminated = "Terminated"
}

enum PayrollError: Error, LocalizedError {
    case invalidHours(String)
    case invalidPayment(String)
    case unauthorizedModification(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidHours(let msg), .invalidPayment(let msg), .unauthorizedModification(let msg):
            return msg
        }
    }
}