//
//  StatisticsView.swift
//  School Management
//
//  Created by SESEIU24007 on 15/10/26.
//


import SwiftUI

struct StatisticsView: View {
    @ObservedObject var viewModel: ClassManagerViewModel

    var body: some View {
        NavigationStack {
            List {
                // Statistic A: Students whose GPA > 8
                Section(header: Text("a) Students with GPA > 8.0")) {
                    let topStudents = viewModel.getStudentsWithGPA(above: 8.0)
                    if topStudents.isEmpty {
                        Text("No students with GPA > 8.0 found.")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(topStudents, id: \.student.id) { item in
                            HStack {
                                Text(item.student.name)
                                    .font(.headline)
                                Spacer()
                                Text("GPA: \(String(format: "%.2f", item.gpa))")
                                    .bold()
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
                
                // Statistic B: List of students failed in each subject (< 5.0)
                Section(header: Text("b) Failed Students by Subject (< 5.0)")) {
                    let failedDict = viewModel.getFailedStudentsBySubject()
                    ForEach(viewModel.subjects) { subject in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(subject.name)
                                .font(.subheadline)
                                .bold()
                            
                            let failedList = failedDict[subject] ?? []
                            if failedList.isEmpty {
                                Text("• No failing students.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            } else {
                                ForEach(failedList, id: \.id) { student in
                                    Text("• \(student.name) (\(student.id))")
                                        .font(.caption)
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        .padding(.vertical, 2)
                    }
                }
            }
            .navigationTitle("Semester Statistics")
        }
    }
}