//
//  Appointment.swift
//  Veterinary_Clinic
//
//  Created by SESEIU24007 on 6/11/26.
//


import Foundation
import Combine

class Appointment: Identifiable, ObservableObject {
    let id: UUID
    let petName: String
    let ownerName: String
    
    @Published private(set) var scheduledDate: Date
    @Published private(set) var status: AppointmentStatus
    @Published private(set) var baseFee: Double
    
    init(id: UUID = UUID(), petName: String, ownerName: String, scheduledDate: Date, status: AppointmentStatus = .scheduled, baseFee: Double) {
        self.id = id
        self.petName = petName
        self.ownerName = ownerName
        self.scheduledDate = scheduledDate
        self.status = status
        self.baseFee = max(0.0, baseFee)
    }
    
    func updateStatus(to newStatus: AppointmentStatus) {
        self.status = newStatus
    }
    
    // Encapsulated fee update with validation against arbitrary/negative changes
    func updateBaseFee(to newFee: Double) throws {
        guard newFee >= 0 else {
            throw AppointmentError.invalidFee("Appointment fee cannot be negative.")
        }
        self.baseFee = newFee
    }
    
    // Encapsulated rescheduling rule: completed or cancelled visits cannot be easily rescheduled without proper workflow
    func reschedule(to newDate: Date) throws {
        guard status != .completed else {
            throw AppointmentError.invalidReschedule("A completed visit cannot be rescheduled.")
        }
        guard status != .cancelled else {
            throw AppointmentError.invalidReschedule("A cancelled appointment cannot be rescheduled directly.")
        }
        self.scheduledDate = newDate
    }
    
    // Polymorphic check-in validation
    func checkIn() throws {
        guard status == .scheduled else {
            // handled per subclass or general status check
            throw AppointmentError.checkInDenied("Check-in failed: Appointment status is \(status.rawValue.lowercased()).")
        }
    }
    
    var statusIsReadyForCheckIn: Bool {
        return status == .scheduled
    }
    
    // Polymorphic calculation of visit charges
    func calculateCharges() -> Double {
        return baseFee
    }
    
    // Polymorphic details breakdown
    func getVisitDetails() -> [String] {
        return ["Standard consultation fee: $\(String(format: "%.2f", baseFee))"]
    }
    
    var serviceTypeDescription: String {
        return "General Appointment"
    }
}

// MARK: - Specialized Subclasses

class RoutineConsultationAppointment: Appointment {
    let examinationType: String
    
    init(petName: String, ownerName: String, scheduledDate: Date = Date(), status: AppointmentStatus = .scheduled, baseFee: Double = 50.0, examinationType: String = "Comprehensive Physical Exam") {
        self.examinationType = examinationType
        super.init(petName: petName, ownerName: ownerName, scheduledDate: scheduledDate, status: status, baseFee: baseFee)
    }
    
    override func calculateCharges() -> Double {
        return baseFee
    }
    
    override func getVisitDetails() -> [String] {
        return [
            "Examination Type: \(examinationType)",
            "Standard Consultation Fee: $\(String(format: "%.2f", baseFee))"
        ]
    }
    
    override var serviceTypeDescription: String {
        return "Routine Consultation"
    }
}

class VaccinationAppointment: Appointment {
    @Published private(set) var vaccineName: String
    let includesBooster: Bool
    
    init(petName: String, ownerName: String, scheduledDate: Date = Date(), status: AppointmentStatus = .scheduled, baseFee: Double = 40.0, vaccineName: String, includesBooster: Bool) {
        self.vaccineName = vaccineName
        self.includesBooster = includesBooster
        super.init(petName: petName, ownerName: ownerName, scheduledDate: scheduledDate, status: status, baseFee: baseFee)
    }
    
    override func calculateCharges() -> Double {
        let boosterFee = includesBooster ? 25.0 : 0.0
        return baseFee + boosterFee
    }
    
    override func getVisitDetails() -> [String] {
        var details = [
            "Vaccine Administered: \(vaccineName)",
            "Base Vaccination Fee: $\(String(format: "%.2f", baseFee))"
        ]
        if includesBooster {
            details.append("Includes Annual Booster: +$25.00")
        }
        return details
    }
    
    override var serviceTypeDescription: String {
        return "Vaccination Service"
    }
}

class EmergencyAppointment: Appointment {
    @Published private(set) var urgencyLevel: String
    let emergencySurcharge: Double
    
    init(petName: String, ownerName: String, scheduledDate: Date = Date(), status: AppointmentStatus = .scheduled, baseFee: Double, urgencyLevel: String, emergencySurcharge: Double) {
        self.urgencyLevel = urgencyLevel
        self.emergencySurcharge = max(0.0, emergencySurcharge)
        super.init(petName: petName, ownerName: ownerName, scheduledDate: scheduledDate, status: status, baseFee: baseFee)
    }
    
    override func calculateCharges() -> Double {
        return baseFee + emergencySurcharge
    }
    
    override func getVisitDetails() -> [String] {
        return [
            "Urgency Priority Level: \(urgencyLevel)",
            "Base Fee: $\(String(format: "%.2f", baseFee))",
            "Emergency Priority Surcharge: $\(String(format: "%.2f", emergencySurcharge))"
        ]
    }
    
    override var serviceTypeDescription: String {
        return "Emergency Priority Visit"
    }
}
