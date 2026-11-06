//
//  MembershipDetailView.swift
//  Fitness_Membership
//
//  Created by SESEIU24007 on 6/11/26.
//

import Foundation
import SwiftUI

struct MembershipDetailView: View {
    @ObservedObject var membership: Membership
    @ObservedObject var viewModel: FitnessCenterViewModel
    
    var body: some View {
        Form {
            Section(header: Text("Membership Details")) {
                LabeledContent("Member Name", value: membership.memberName)
                LabeledContent("Plan Type", value: membership.planTypeDescription)
                LabeledContent("Status", value: membership.status.rawValue)
                LabeledContent("Estimated Charges", value: String(format: "$%.2f", membership.calculateCharges()))
                LabeledContent("Activation Date", value: membership.activationDate.formatted(date: .abbreviated, time: .omitted))
            }
            
            Section(header: Text("Plan Benefits & Privileges")) {
                ForEach(membership.getBenefits(), id: \.self) { benefit in
                    HStack(alignment: .top) {
                        Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                        Text(benefit)
                    }
                }
            }
            
            Section(header: Text("Actions")) {
                Button(action: {
                    viewModel.performCheckIn(for: membership)
                }) {
                    Label("Attempt Facility Check-In", systemImage: "checkmark.rectangle.stack")
                }
            }
        }
        .navigationTitle("Profile Overview")
    }
}
