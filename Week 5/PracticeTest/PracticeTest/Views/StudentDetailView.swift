//
//  StudentDetailView.swift
//  PracticeTest
//
//  Created by SESEIU24007 on 22/10/26.
//


import SwiftUI
import Combine

struct StudentDetailView: View {
    @ObservedObject var manager: UniversityManager
    var student: Student
    
    @State private var selectedRecord: StudentRecord?
    @State private var newMarkText: String = ""
    @State private var showingEditSheet = false
    
    var body: some View {
        VStack {
            // Student Info Header
            VStack(alignment: .leading, spacing: 6) {
                Text(student.displayInfo())
                    .font(.headline)
                let avg = manager.calculateWeightedAverage(for: student)
                let rank = manager.getAcademicRanking(for: student)
                Text("Weighted Average: \(String(format: "%.2f", avg)) - Ranking: \(rank)")
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
            
            // List of Subjects & Marks
            List {
                Section(header: Text("Registered Subjects")) {
                    let studentRecords = manager.records.filter { $0.student.id == student.id }
                    if studentRecords.isEmpty {
                        Text("No subjects registered.")
                    } else {
                        ForEach(studentRecords) { record in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(record.subject.name)
                                        .font(.body)
                                    Text("Credits: \(record.subject.credits)")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text(String(format: "Mark: %.1f", record.mark))
                                        .fontWeight(.semibold)
                                    Text(record.isPassed() ? "Passed" : "Failed")
                                        .font(.caption)
                                        .foregroundColor(record.isPassed() ? .green : .red)
                                }
                                Button("Edit") {
                                    selectedRecord = record
                                    newMarkText = "\(record.mark)"
                                    showingEditSheet = true
                                }
                                .buttonStyle(.bordered)
                                .font(.caption)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Student Details")
        .sheet(isPresented: $showingEditSheet) {
            if let record = selectedRecord {
                EditMarkView(record: record, markText: $newMarkText, isPresented: $showingEditSheet) {
                    manager.objectWillChange.send()
                }
            }
        }
    }
}
