//
//  StudentsView.swift
//  School Management
//
//  Created by SESEIU24007 on 15/10/26.
//


import SwiftUI

struct StudentsView: View {
    @ObservedObject var viewModel: ClassManagerViewModel
    @State private var showingAddAlert = false
    @State private var id = ""
    @State private var name = ""
    @State private var className = ""
    @State private var dob = ""

    var body: some View {
        NavigationStack {
            List(viewModel.students) { student in
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(student.name)
                            .font(.headline)
                        Spacer()
                        Text(student.id)
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                    Text("Class: \(student.className) | DOB: \(student.dateOfBirth)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Students Management")
            .toolbar {
                Button(action: { showingAddAlert = true }) {
                    Image(systemName: "plus")
                }
            }
            .alert("Add Student to Class", isPresented: $showingAddAlert) {
                TextField("Student ID (e.g. SESEIU24XXX)", text: $id)
                TextField("Full Name", text: $name)
                TextField("Class (e.g. PHSE24IU41)", text: $className)
                TextField("Date of Birth (DD/MM/YYYY)", text: $dob)
                Button("Add") {
                    viewModel.addStudent(id: id, name: name, className: className, dob: dob)
                    id = ""; name = ""; className = ""; dob = ""
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
}