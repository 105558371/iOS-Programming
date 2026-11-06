//
//  FitnessCenterViewModel.swift
//  Fitness_Membership
//
//  Created by SESEIU24007 on 6/11/26.
//


import Foundation
import SwiftUI
import Combine

class FitnessCenterViewModel: ObservableObject {
    @Published var memberships: [Membership] = [
        BasicMembership(memberName: "Alice Smith", monthlyFee: 35.0),
        PremiumMembership(memberName: "Bob Johnson", monthlyFee: 75.0, guestPassesRemaining: 3, extendedHoursAllowed: true),
        PersonalTrainingMembership(memberName: "Charlie Davis", monthlyFee: 50.0, remainingSessions: 2, costPerSession: 40.0),
        BasicMembership(memberName: "Diana Prince", status: .suspended, monthlyFee: 35.0)
    ]
    
    @Published var operationLogs: [String] = []
    
    func performCheckIn(for membership: Membership) {
        do {
            try membership.checkIn()
            operationLogs.insert("✅ Success: Check-in allowed for \(membership.memberName).", at: 0)
        } catch {
            operationLogs.insert("❌ Rejected: \(error.localizedDescription)", at: 0)
        }
    }
    
    func testInvalidOperations() {
        operationLogs.insert("--- Running Validation Tests ---", at: 0)
        
        // 1. Test check-in on suspended member
        if let suspendedMember = memberships.first(where: { $0.status == .suspended }) {
            performCheckIn(for: suspendedMember)
        }
        
        // 2. Test negative fee update enforcement
        let sampleMember = memberships[0]
        do {
            try sampleMember.updateMonthlyFee(to: -10.0)
            operationLogs.insert("✅ Success: Fee updated.", at: 0)
        } catch {
            operationLogs.insert("❌ Rejected (Encapsulation Guard): \(error.localizedDescription)", at: 0)
        }
        
        // 3. Test negative session balance protection
        if let ptMember = memberships.first(where: { $0 is PersonalTrainingMembership }) as? PersonalTrainingMembership {
            for _ in 0...ptMember.remainingSessions + 1 {
                do {
                    try ptMember.useSession()
                    operationLogs.insert("✅ Success: Session used for \(ptMember.memberName). Remaining: \(ptMember.remainingSessions)", at: 0)
                } catch {
                    operationLogs.insert("❌ Rejected (Session Guard): \(error.localizedDescription)", at: 0)
                }
            }
        }
    }
}
