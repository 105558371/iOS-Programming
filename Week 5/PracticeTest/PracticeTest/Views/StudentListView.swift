//
//  StudentListView.swift
//  PracticeTest
//
//  Created by SESEIU24007 on 22/10/26.
//


import SwiftUI

struct StudentListView: View {
    @StateObject private var manager = UniversityManager()
    
    var body: some View {
        NavigationView {
            List(manager.students) { student in
                NavigationLink(destination: StudentDetailView(manager: manager, student: student)) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(student.name)
                            .font(.headline)
                        Text("ID: \(student.id) | Age: \(student.age)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        let avg = manager.calculateWeightedAverage(for: student)
                        let rank = manager.getAcademicRanking(for: student)
                        
                        HStack {
                            Text(String(format: "Avg: %.2f", avg))
                            Spacer()
                            Text("Rank: \(rank)")
                                .fontWeight(.bold)
                                .foregroundColor(rankColor(rank))
                        }
                        .font(.caption)
                        .padding(.top, 2)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("University Students")
            .navigationBarTitleDisplayMode(.inline)
            .font(.headline)
            .fontWeight(.bold)
        }
    }
    
    func rankColor(_ rank: String) -> Color {
        switch rank {
        case "Excellent": return .purple
        case "Good": return .blue
        case "Fair": return .yellow
        case "Average": return .orange
        case "Pass": return .green
        default: return .red
        }
    }
}
