//
//  MembershipStatus.swift
//  Fitness_Membership
//
//  Created by SESEIU24007 on 6/11/26.
//


import Foundation

enum MembershipStatus: String, Codable, CaseIterable {
    case active = "Active"
    case suspended = "Suspended"
    case expired = "Expired"
}

enum MembershipType: String, Codable {
    case basic = "Basic"
    case premium = "Premium"
    case personalTraining = "Personal Training"
}

enum MembershipError: Error, LocalizedError {
    case checkInDenied(String)
    case invalidFee(String)
    case sessionError(String)
    
    var errorDescription: String? {
        switch self {
        case .checkInDenied(let msg), .invalidFee(let msg), .sessionError(let msg):
            return msg
        }
    }
}