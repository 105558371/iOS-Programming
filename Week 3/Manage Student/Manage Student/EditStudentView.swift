//
//  EditStudentView.swift
//  Manage Student
//
//  Created by SESEIU24007 on 9/10/26.
//


import SwiftUI

struct EditStudentView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var student: Student
    var onSave: (Student) -> Void

    @State private var name: String = ""
    @State private var gpaText: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Student Details")) {
                    LabeledContent("Student ID", value: student.id)
                    
                    TextField("Name", text: $name)
                    
                    TextField("GPA", text: $gpaText)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Edit Student")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                name = student.name
                gpaText = String(format: "%.1f", student.gpa)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let newGPA = Double(gpaText), !name.isEmpty {
                            var updatedStudent = student
                            updatedStudent.name = name
                            updatedStudent.gpa = newGPA
                            onSave(updatedStudent)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}