//
//  ClinicViewModel.swift
//  Veterinary_Clinic
//
//  Created by SESEIU24007 on 6/11/26.
//


import Foundation
import Combine

class ClinicViewModel: ObservableObject {
    @Published var appointments: [Appointment] = [
        RoutineConsultationAppointment(petName: "Max (Golden Retriever)", ownerName: "Sarah Jenkins", baseFee: 60.0),
        VaccinationAppointment(petName: "Luna (Tabby Cat)", ownerName: "Michael Chang", baseFee: 45.0, vaccineName: "FVRCP Core Vaccine", includesBooster: true),
        EmergencyAppointment(petName: "Rocky (German Shepherd)", ownerName: "David Miller", baseFee: 120.0, urgencyLevel: "Critical - Immediate Attention", emergencySurcharge: 80.0),
        // Pre-configured completed and cancelled appointments for testing rejection scenarios
        RoutineConsultationAppointment(petName: "Bella (Poodle)", ownerName: "Emma Watson", status: .completed, baseFee: 50.0),
        RoutineConsultationAppointment(petName: "Charlie (Beagle)", ownerName: "Oliver Queen", status: .cancelled, baseFee: 50.0)
    ]
    
    @Published var operationLogs: [String] = []
    
    func performCheckIn(for appointment: Appointment) {
        guard appointment.statusIsReadyForCheckIn else {
            operationLogs.insert("❌ Rejected: Check-in denied because appointment status is \(appointment.status.rawValue.lowercased()).", at: 0)
            return
        }
        operationLogs.insert("✅ Success: Checked in pet \(appointment.petName) for appointment.", at: 0)
    }
    
    func testValidationAndRejections() {
        operationLogs.insert("--- Running Veterinary Validation Test Suite ---", at: 0)
        
        // 1. Test attempting to check in a cancelled appointment
        if let cancelledAppt = appointments.first(where: { $0.status == .cancelled }) {
            performCheckIn(for: cancelledAppt)
        }
        
        // 2. Test attempting to reschedule a completed visit
        if let completedAppt = appointments.first(where: { $0.status == .completed }) {
            let futureDate = Date().addingTimeInterval(86400 * 3)
            do {
                try completedAppt.reschedule(to: futureDate)
                operationLogs.insert("✅ Success: Rescheduled completed visit.", at: 0)
            } catch {
                operationLogs.insert("❌ Rejected (Completed Visit Guard): \(error.localizedDescription)", at: 0)
            }
        }
        
        // 3. Test unauthorized/negative fee modification guard
        let routineAppt = appointments[0]
        do {
            try routineAppt.updateBaseFee(to: -25.0)
            operationLogs.insert("✅ Success: Fee updated.", at: 0)
        } catch {
            operationLogs.insert("❌ Rejected (Fee Encapsulation Guard): \(error.localizedDescription)", at: 0)
        }
        
        // 4. Test valid update: successfully rescheduling an active appointment
        let activeAppt = appointments[0]
        let newSlot = Date().addingTimeInterval(86400 * 2)
        do {
            try activeAppt.reschedule(to: newSlot)
            operationLogs.insert("✅ Valid Update: Successfully rescheduled appointment for \(activeAppt.petName).", at: 0)
        } catch {
            operationLogs.insert("❌ Error: \(error.localizedDescription)", at: 0)
        }
    }
}