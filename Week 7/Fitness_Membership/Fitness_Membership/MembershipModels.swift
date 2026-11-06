//
//  MembershipModels.swift
//  Fitness_Membership
//
//  Created by SESEIU24007 on 6/11/26.
//

import SwiftUI
import Combine

// MARK: - Base Membership Class (Encapsulation & Polymorphism)
class Membership: Identifiable, ObservableObject {
    let id: UUID
    let memberName: String
    let activationDate: Date
    
    @Published private(set) var status: MembershipStatus
    @Published private(set) var monthlyFee: Double
    
    init(id: UUID = UUID(), memberName: String, activationDate: Date, status: MembershipStatus, monthlyFee: Double) {
        self.id = id
        self.memberName = memberName
        self.activationDate = activationDate
        self.status = status
        self.monthlyFee = max(0.0, monthlyFee)
    }
    
    func updateStatus(to newStatus: MembershipStatus) {
        self.status = newStatus
    }
    
    func updateMonthlyFee(to newFee: Double) throws {
        guard newFee >= 0 else {
            throw MembershipError.invalidFee("Monthly fee cannot be negative.")
        }
        self.monthlyFee = newFee
    }
    
    func checkIn() throws {
        guard status == .active else {
            throw MembershipError.checkInDenied("Check-in failed: Membership is \(status.rawValue.lowercased()).")
        }
    }
    
    func calculateCharges() -> Double {
        return monthlyFee
    }
    
    func getBenefits() -> [String] {
        return ["Access to general workout areas during regular opening hours."]
    }
    
    var planTypeDescription: String {
        return "Base Membership"
    }
}

// MARK: - Specialized Subclasses

class BasicMembership: Membership {
    init(memberName: String, activationDate: Date = Date(), status: MembershipStatus = .active, monthlyFee: Double = 30.0) {
        super.init(memberName: memberName, activationDate: activationDate, status: status, monthlyFee: monthlyFee)
    }
    
    override var planTypeDescription: String {
        return "Basic Plan"
    }
}

class PremiumMembership: Membership {
    @Published private(set) var guestPassesRemaining: Int
    let extendedHoursAllowed: Bool
    
    init(memberName: String, activationDate: Date = Date(), status: MembershipStatus = .active, monthlyFee: Double, guestPassesRemaining: Int, extendedHoursAllowed: Bool) {
        self.guestPassesRemaining = max(0, guestPassesRemaining)
        self.extendedHoursAllowed = extendedHoursAllowed
        super.init(memberName: memberName, activationDate: activationDate, status: status, monthlyFee: monthlyFee)
    }
    
    override func getBenefits() -> [String] {
        var benefits = super.getBenefits()
        benefits.append("Access to additional premium facilities and selected group classes.")
        if extendedHoursAllowed {
            benefits.append("Extended facility access hours.")
        }
        benefits.append("Guest passes remaining: \(guestPassesRemaining)")
        return benefits
    }
    
    override var planTypeDescription: String {
        return "Premium Plan"
    }
}

class PersonalTrainingMembership: Membership {
    @Published private(set) var remainingSessions: Int
    let costPerSession: Double
    
    init(memberName: String, activationDate: Date = Date(), status: MembershipStatus = .active, monthlyFee: Double, remainingSessions: Int, costPerSession: Double) {
        self.remainingSessions = max(0, remainingSessions)
        self.costPerSession = max(0.0, costPerSession)
        super.init(memberName: memberName, activationDate: activationDate, status: status, monthlyFee: monthlyFee)
    }
    
    func useSession() throws {
        guard status == .active else {
            throw MembershipError.sessionError("Cannot use session: Membership is not active.")
        }
        guard remainingSessions > 0 else {
            throw MembershipError.sessionError("Session balance cannot become negative or zero.")
        }
        remainingSessions -= 1
    }
    
    func addSessions(count: Int) throws {
        guard count > 0 else {
            throw MembershipError.sessionError("Must add a positive number of sessions.")
        }
        remainingSessions += count
    }
    
    override func calculateCharges() -> Double {
        return monthlyFee + (Double(remainingSessions) * 15.0)
    }
    
    override func getBenefits() -> [String] {
        var benefits = super.getBenefits()
        benefits.append("Includes personalized 1-on-1 coaching sessions.")
        benefits.append("Remaining Coaching Sessions: \(remainingSessions)")
        return benefits
    }
    
    override var planTypeDescription: String {
        return "Personal Training Plan"
    }
}
