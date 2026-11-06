//
//  AppointmentDetailView.swift
//  Veterinary_Clinic
//
//  Created by SESEIU24007 on 6/11/26.
//

import SwiftUI

struct AppointmentDetailView: View {
    @ObservedObject var appointment: Appointment
    @ObservedObject var viewModel: ClinicViewModel
    
    var body: some View {
        Form {
            Section(header: Text("Appointment Information")) {
                LabeledContent("Patient Pet", value: appointment.petName)
                LabeledContent("Pet Owner", value: appointment.ownerName)
                LabeledContent("Service Type", value: appointment.serviceTypeDescription)
                LabeledContent("Current Status", value: appointment.status.rawValue)
                LabeledContent("Estimated Charges", value: String(format: "$%.2f", appointment.calculateCharges()))
                LabeledContent("Scheduled Date", value: appointment.scheduledDate.formatted(date: .abbreviated, time: .shortened))
            }
            
            Section(header: Text("Visit Details & Breakdown")) {
                ForEach(appointment.getVisitDetails(), id: \.self) { detail in
                    HStack {
                        Image(systemName: "checkmark.seal.fill").foregroundColor(.indigo)
                        Text(detail)
                    }
                }
            }
            
            Section(header: Text("Clinic Actions")) {
                Button(action: {
                    viewModel.performCheckIn(for: appointment)
                }) {
                    Label("Attempt Facility Check-In", systemImage: "rectangle.portrait.and.arrow.right")
                }
            }
        }
        .navigationTitle("Appointment Summary")
    }
}
