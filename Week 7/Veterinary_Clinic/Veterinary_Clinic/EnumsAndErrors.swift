//
//  AppointmentStatus.swift
//  Veterinary_Clinic
//
//  Created by SESEIU24007 on 6/11/26.
//


import Foundation

enum AppointmentStatus: String, Codable, CaseIterable {
    case scheduled = "Scheduled"
    case completed = "Completed"
    case cancelled = "Cancelled"
}

enum AppointmentError: Error, LocalizedError {
    case checkInDenied(String)
    case invalidFee(String)
    case invalidReschedule(String)
    
    var errorDescription: String? {
        switch self {
        case .checkInDenied(let msg), .invalidFee(let msg), .invalidReschedule(let msg):
            return msg
        }
    }
}